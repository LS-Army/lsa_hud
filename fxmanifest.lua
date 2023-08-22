fx_version 'cerulean'
lua54 'yes'
game 'gta5'
name 'lsa-hud'
author 'Rota LS-ARMY'

client_scripts {
  'client/*.lua',
}

shared_script {
  '@es_extended/imports.lua',
  '@ox_lib/init.lua',
}

ui_page('web/index.html')

files {
  'web/index.html',
  'web/style.css',
  'web/index.js',
  'locales/*.json'
}
