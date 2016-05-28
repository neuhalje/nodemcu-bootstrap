local setup = require "setup"
require "lunit"

module( "setup_tc", package.seeall, lunit.testcase )


local function dev_null(ignored)
--  print(ignored)
end

function test_sut_module_loaded()
  assert_not_nil(setup, "Setup module should be loaded")
end

function test_valiate_nil_config__fails()
  nil_config = nil
  assert_false( setup.validate_config(empty_config, dev_null), "A nil config does not validate")
end

function test_valiate_empty_config__fails()
  nil_config = {}
  assert_false( setup.validate_config(empty_config, dev_null), "An empty config does not validate")
end


function test_valiate_config_with_empty_SSID__fails()
  config_with_empty_SSID = {}
  config_with_empty_SSID.SSID =  {}
  assert_false( setup.validate_config(config_with_empty_SSID, dev_null), "A config with empty SSID table does not validate")
end

function test_valiate_config_with_SSID__succeeds()
  config_with_SSID = {}
  config_with_SSID.SSID = {}
  config_with_SSID.SSID["demo SSID"] = "demo password"
  assert_true( setup.validate_config(config_with_SSID, dev_null), "A config with configured SSID validates")
end
