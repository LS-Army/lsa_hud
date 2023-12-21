fx_version 'cerulean'
lua54 'yes'
game 'gta5'
name 'lsa_hud'
version "1.0.1"
author 'Rota LS-ARMY'

client_scripts {
  'client/*.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/*.lua'
}

shared_script {
  '@ox_lib/init.lua',
  'config.lua'
}

ui_page('web/index.html')

files {
  'web/index.html',
  'web/style.css',
  'web/index.js'
}
