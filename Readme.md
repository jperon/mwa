# PWA en Lua / MoonScript

Ce script génère un squelette d'application web avec [fengari](https://fengari.io).

## Dépendances

- [Lua](http://www.lua.org/) / [LuaJiT](https://luajit.org/)
- [LuaFileSystem](https://keplerproject.github.io/luafilesystem/)
- [MoonScript](https://moonscript.org/)
- [luamin](https://github.com/mathiasbynens/luamin)

Le script pourrait ètre adapté de façon à fonctionner avec Lua seul.

## Utilisation

### Création d'un nouveau projet

Elle s'effectue grâce à la commande `moon ./mwa.moon` :

```sh
./mwa.moon [OPTIONS]

  Mandatory options:
    --name=NAME
    --path=PATH
    --short_name=SHORT_NAME

  Other options:
    --background_color=BACKGROUND_COLOR  (white)
    --description=DESCRIPTION  ()
    --lang=LANG  (fr-FR)
    --start_url=START_URL  (/)
    --theme_color=THEME_COLOR  (black)
```

Le projet sera créé dans `PATH` ; s'il y a des sous-dossiers,
ils seront créés automatiquement.

Les fichiers à modifier se trouvent alors dans `PATH/src`, et éventuellement
dans `PATH/templates`. Les icônes du projet se trouvent dans `PATH/dist`.

### Publication du projet

Une fois les sources modifiées, se placer dans `PATH` et utiliser la commande
`moon make.moon` :

```sh
./make.moon [OPTIONS]

  Mandatory options: none

  Other options:
    --start_url=START_URL  (/)
    --version=VERSION  ()
```

Le dossier `PATH/dist` contiendra alors les fichiers résultants, à copier sur
un serveur (accessible en https pour les fonctionnalités PWA). Le fichier
`index.html` est indépendant et peut être utilisé sans serveur web.
