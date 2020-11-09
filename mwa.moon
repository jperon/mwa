#!/usr/bin/env moon
import attributes, dir, mkdir from require"lfs"
import wrap, yield from coroutine
import open, stderr from io
import exit from os
import concat, sort from table

TEMPLATES = "./templates"

OPTIONS = {
  path: false
  name: false
  short_name: false
  description: ""
  lang: "fr-FR"
  background_color: "white"
  theme_color: "black"
  start_url: "/"
}

err = (...) -> stderr\write("#{concat {...}, " "}\n")

opairs = (fn) =>
  _k = [k for k in pairs @]
  sort _k, fn
  i = 0
  ->
    i += 1
    k = _k[i]
    k, @[k]

do
  mandatory_options = ["    --#{k}=#{k\upper!}" for k, v in opairs OPTIONS when not v]
  other_options = ["    --#{k}=#{k\upper!}  (#{v})" for k, v in opairs OPTIONS when v]
  mandatory = "\n\n  Mandatory options:#{#mandatory_options > 0 and '\n' .. concat(mandatory_options, '\n') or ' none'}" or ""
  other = #other_options > 0 and "\n\n  Other options:\n#{concat other_options, '\n'}" or ""
  export USAGE = "Usage: #{arg[0]} [OPTIONS]#{mandatory}#{other}"
do
  for opt in *arg
    if opt == "-h" or opt == "--help"
      print USAGE
      exit 0
    k, v = opt\match("%-%-(.*)=(.*)")
    if OPTIONS[k] ~= nil
      OPTIONS[k] = v
    else
      err "Unknown argument: #{k}.\n\n#{USAGE}"
      exit 1
  ok = true
  for k in pairs OPTIONS
    unless OPTIONS[k]
      err "Missing mandatory argument: #{k}."
      ok = false
  unless ok
    err "\n#{USAGE}"
    exit 1

do
  opt_path = OPTIONS.path
  path = opt_path\sub(1, 1) == "/" and "/" or ""
  for d in opt_path\gmatch "[^/]+"
    path ..= "#{d}/"
    mkdir path
  OPTIONS.path = path\sub 1, -2


generate_project = (input_dir, output_dir) ->
  for template in dir input_dir
    continue if template\match "^%."
    input_path = "#{input_dir}/#{template}"
    output_path = "#{output_dir}/#{template}"
    switch attributes input_path, "mode"
      when "directory"
        mkdir output_path
        generate_project input_path, output_path
      when "file"
        input = assert open input_path, "r"
        content = input\read "*a"
        input\close!
        for k in content\gmatch "<<<(.-)>>>"
          content = content\gsub("<<<#{k}>>>", OPTIONS[k]) if OPTIONS[k]
        output = assert open output_path, "w"
        output\write content
        output\close!

generate_project TEMPLATES, OPTIONS.path
