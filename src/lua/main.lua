-- This section must be included in all plugins you want to show up in /lukkit:pl or /lukkit:help. FROM HERE...

if not plugins then plugins = {} end
if not commands then commands = {} end
if not global then global = {} end

-- ...UNTIL HERE

global.noPerm = "§cYou do not have permission to do that"

commands.help = {cmd="help",alias={"?","cmds","commands"}, desc="Displays a list of available commands.", perm="geeorge.core.help")
commands.ping = {cmd="ping",alias={"pong","pingpong"}, desc="Pong!", perm="geeorge.core.ping"}

plugins[#plugins+1] = lukkit.addPlugin( "GeeorgeCore", "GeeorgeOS-1.0-4.16.0958", function(plugin)
  plugin.onEnable( function() plugin.print("Plugin loaded in slot: "..#plugins) end)
  plugin.onDisable( function() plugin.warn("Plugin has been disabled!") end)
end)
  
