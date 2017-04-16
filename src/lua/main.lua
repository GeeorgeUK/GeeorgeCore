-- This section must be included in all plugins you want to show up in /lukkit:pl or /lukkit:help. FROM HERE...

if not plugins then plugins = {} end
if not commands then commands = {} end
if not global then global = {} end

-- ...UNTIL HERE

global.noPerm = "§cYou do not have permission to do that"

function global.spairs(t, order)
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end
  
  if order then
    table.sort(keys, function(a,b) return order(t, a, b) end)
  else
    table.sort(keys)
  end
  
  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

commands["help"], commands[#commands+1] = {cmd="help",use="/help", alias={"?","cmds","commands"}, desc="Displays a list of available commands.", perm="geeorge.core.help")
commands["ping"], commands[#commands+1] = {cmd="ping",use="/ping", alias={"pong","pingpong"}, desc="Pong!", perm="geeorge.core.ping"}

plugins[#plugins+1] = lukkit.addPlugin( "GeeorgeCore", "GeeorgeOS Core-1.0-4.16.1054-INDEV", function(plugin)
  plugin.onEnable( function() plugin.print("Plugin loaded in slot: "..#plugins) end)
  plugin.onDisable( function() plugin.warn("Plugin has been disabled!") end)
    
  plugin.addCommand( "help", "Displays a list of available commands", "/help [page]", function(sender, args)
    if sender:hasPermission("geeorge.core.help") == false then
      sender:sendMessage(global.noPerm)  return
    end
    
    local temp = {}
    for a, b in global.spairs(commands) do
      table.insert(temp, b)
    end
        
    local page = tonumber(args[1]) or 1
    local entriesperpage = tonumber(plugin.config.get("help.entriesPerPage") or 8
    local start = (( entriesperpage * ( page - 1 )) + 1 ) or 1
    local finish = ( entriesperpage * page ) or 1
    local lastpage = math.ceil( #temp / entriesperpage )
          
    sender:sendMessage("§e§m--------§e[ §aCommand Reference §e§m---§a Page "..page.." of "..lastpage.." §e]§m--------")
          
    if tonumber(page) > tonumber(lastpage) then
      sender:sendMessage("§cError: §fThere are no commands on this page.") return
    end
          
    for n = start, finish do
      if temp[n] then
        if not temp[n].perm or sender:hasPermission(temp[n].perm) == true then
          sender:sendMessage("§e"..temp[n].use.." §f"..temp[n].desc )
          if plugin.config.get("help.showPermission") == true and sender:hasPermission("geeorge.core.help.permissions") == true then
            sender:sendMessage("§7 Requires permission: " .. temp[n].perm )
          end
        end
      else
        return
      end
    end
  end)
end)
  
