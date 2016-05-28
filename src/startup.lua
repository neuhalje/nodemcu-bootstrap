local M = {}

function M.go() 
  app = require("application")  
  config = require("config")  
  setup = require("setup")

  setup.start()
end


return M
