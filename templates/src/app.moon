import html from require"html"
import EL, launch from require"luajs"

attente = EL "div_attente"
body = EL "corps"
contenu = EL "contenu"
btn = EL "btn"

btn\on "click", ->
  launch ->
    contenu << html -> p "Bonjour !"

attente\hide!
body\show!
