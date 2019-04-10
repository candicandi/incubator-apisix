-- Copyright (C) Yuansheng Wang

local log = require("apimeta.comm.log")

local _M = {}

local function load()
    log.warn("dd: ", ngx.time())
end

do
    local running

function _M.load(premature)
    if premature or running then
        return
    end

    running = true
    local ok, err = pcall(load)
    running = false

    if not ok then
        log.error("failed to call `load` function: ", err)
    end
end

end -- do

function _M.init_worker()
    ngx.timer.every(1, _M.load)
end

return _M