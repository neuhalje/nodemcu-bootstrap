local M = {}

local sysinfo = require("sysinfo")

-- outout: a function that takes one string parameter. It should communicate the result to the user
function M.validate_config(config, output)
  if config == nil then
    output("No config set. Create a /config.lua file")
    return false
  end

  if config.SSID == nil then
    output("Config set but SSID not configured")
    return false
  end

  if next(config.SSID) == nil then
    output("Config set but SSID needs at least one entry")
    return false
  end

  output("configuration is ok")
  return true
end

local function wifi_wait_ip()  
  print("...")
  if wifi.sta.getip()== nil then
    print("IP unavailable, Waiting...")
  else
    tmr.stop(0)

    print("\n====================================")
    print(sysinfo.wifi_configuration())
    print("====================================\n")

    app.start()
  end
end

local function wifi_start(list_aps)  
    ap_found = false
    if list_aps and next(list_aps) then
        print("got access points...")
        for key,value in pairs(list_aps) do
            print("Check AP '" .. key .. "'")
            if config.SSID and config.SSID[key] then
                wifi.setmode(wifi.STATION);
                wifi.sta.config(key,config.SSID[key])
                wifi.sta.connect()
                print("Connecting to " .. key .. " ...")
                config.SSID = nil  -- can save memory
                tmr.alarm(0, 2500, 1, wifi_wait_ip)
                ap_found = true
            end
        end
    else
        print("Error getting AP list")
    end
    if not ap_found then
      print("WLAN not found. Aborting.")
      -- This is evil evil recursion
      -- wifi.sta.getap(wifi_start)
    end
end

local function set_led_to_found()
   -- on
   gpio.mode(3, gpio.OUTPUT)
   gpio.write(3, gpio.LOW)
end

function M.start()  
  if M.validate_config(config, print) then
    print("Configuring Wifi ...")
    wifi.setmode(wifi.STATION)
    wifi.sta.getap(wifi_start)
    print("outa here")
  end
end

return M  
