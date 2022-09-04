version '1.0.0'
author 'JJ Copy X'
description 'scoreboardX'
fx_version 'bodacious'
games {'gta5'}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

client_scripts {
	'client.lua'
}

ui_page "html/index.html"

files {
	"html/*"
}client_script "@SCRIPTX-AC/core/client/stop.resource.lua"