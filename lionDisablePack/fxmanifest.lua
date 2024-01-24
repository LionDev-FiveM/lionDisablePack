fx_version 'cerulean'
game 'gta5'
lua54 'on'

author 'Lion Development'
description 'DisablePack'
version '1.1'

client_scripts {
	'client.lua',
	'config.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

file 'version.json'

escrow_ignore {
	'config.lua',
	'client.lua',
	'server.lua'
}