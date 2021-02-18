import html from require"lib.html"
import open from io
import date from os

STATIC = './static'

read = =>
  f = open(@) or open("src/#{@}") or open("src/lib/#{@}")
  r = f\read"*a"
  f\close! and r

load_lua = => "package.loaded[\"#{@}\"] = (function() #{read(@..'.lua')\gsub('[%s]*%-%-.-\n', '\n')\gsub('[\n]+', '\n')} end)()\n"

(infos = {}) ->
  version = infos.version or date "%y%m%d%H%M"
  html ->
    text "<!DOCTYPE html>"
    _html lang:"fr", ->
      head ->
        meta charset:"utf-8"
        meta name:"viewport", content:"width=device-width, initial-scale=1"
        meta name:"theme-color", content:"<<<theme_color>>>"
        meta name:"robots", content:"none"
        link rel:"manifest", href:"#{STATIC}/manifest.json"
        link rel:"icon", href:"#{STATIC}/favicon.ico", type:"image/x-icon"
        link rel:"apple-touch-icon", href:"#{STATIC}/icon.png"
        title "<<<name>>>"
        meta name:"description", content:"<<<description>>>"
        meta name:"version", content:"#{version}"
      body ->
        style ->
          text read "style.css"
        div id:"div_attente", "Veuillez activer Javascript."
        div id:"corps", style: "display:none;", ->
          div id: "contenu", ->
            button id: "btn", "Cliquez ici."
          p id: "note_version", "Version #{version}"
        script type:"application/lua", ->
          text load_lua "html"
          text load_lua "luajs"
          -- text load_lua "json"
          text read "app.lua"
        script type:"application/javascript", src:"#{STATIC}/fengariWeb.js", ""
        script type:"application/javascript", src:"#{STATIC}/install_sw.js", async:true, ""
