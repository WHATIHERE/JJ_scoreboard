version '1.0.2'
author 'JJ Copy X'
description 'JJ_SCOREBOARD'
fx_version 'bodacious'
games { 'gta5' }

ui_page "html/ui.html"

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

files {
	"html/*"
}