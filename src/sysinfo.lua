local M =  {}


local function format_wifi_mode(mode)
  if ( mode == nil ) then
    return "not set"
  elseif ( mode == wifi.STATION ) then
    return "STATION"
  elseif ( mode == wifi.SOFTAP ) then
    return "SOFTAP"
  elseif ( mode == wifi.STATIONAP ) then
    return "STATIONAP"
  elseif ( mode == wifi.NULLMODE ) then
    return "NULLMODE"
  else
    return "UNKNOWN (" .. mode .. ")"
  end
end

local function format_wifi_phymode(mode)
  if ( mode == nil ) then
    return "not set"
  elseif ( mode == wifi.PHYMODE_B ) then
    return "802.11 b"
  elseif ( mode == wifi.PHYMODE_G ) then
    return "802.11 g"
  elseif ( mode == wifi.PHYMODE_N ) then
    return "802.11 n"
  else
    return "UNKNOWN (" .. mode .. ")"
  end
end

local function get_configured_ssid()
  ssid, tmp, bssid_set, bssid = wifi.sta.getconfig() 
  if ( ssid == nil ) then
    return "<not connected>"
  else
    return ssid 
  end
end

local function get_ip_config()
  ip, mask, gw = wifi.sta.getip()
  if ( ip == nil ) then
    return "<not set>"
  else
    return ip .. " mask: " .. mask .. " gw: " .. gw
  end
end

function M.wifi_configuration()
  phymode = format_wifi_phymode(wifi.getphymode())
  mode = format_wifi_mode(wifi.getmode())
  mac = wifi.sta.getmac()
  connect_to = get_configured_ssid()
  ip_config = get_ip_config()

  return  string.format("MAC:\t\t%s\nmode:\t\t%s\nphymode:\t%s\nconfigured ssid:\t%q\nip:\t\t%s", mac, mode, phymode, connect_to, ip_config)
end

return M
