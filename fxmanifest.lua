fx_version 'cerulean'
game 'gta5'

author 'F1FOFTY'
description 'A script for QB-Core that allows players to flash their badge and manage badge information.'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

dependencies {
    'qb-core',
    'oxmysql'
}
