local debug = {}
local upvaluesRegistry = {}

function debug.getupvalue(modulePath, funcName, index)
    local module = require(modulePath)
    local func = module and module[funcName]
    if type(func) ~= "function" then return nil, "Invalid function" end

    local upvalues = debug.getupvalues(func)
    if index and index > 0 and index <= #upvalues then return upvalues[index], nil end
    return nil, "Invalid index"
end

function debug.setupvalues(func, upvalues)
    if type(func) ~= "function" then return nil, "Argument must be a function" end
    upvaluesRegistry[func] = upvalues
    return true
end

function debug.getupvalues(func)
    if type(func) ~= "function" then return nil, "Argument must be a function" end
    return upvaluesRegistry[func] or {}
end

function debug.getupvalue3(modulePath, funcName, index)
    return debug.getupvalue(modulePath, funcName, index)
end

return debug
