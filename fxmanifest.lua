fx_version 'cerulean'
game 'gta5'

version '0.3.0'

author 'Maximus7474'
repository 'https://github.com/Maximus7474/lb-tablet-dispatch'

dependancy 'lb-tablet'

client_scripts {
    '@qbx_core/modules/playerdata.lua',
}

client_script 'client/utils/*.lua'
client_script 'client/bridge/*.lua'
client_script 'client/events/*.lua'

server_script 'server/*.lua'