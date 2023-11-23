-- Handle is a library that makes logging as easy as calling a function! It includes a list of functions for you to use, go to the github: _____ for documentation.

--  TODO:
-- v0.2.1 WIP cleanup

local handle = {}

-- variables used accross many functions:

local size_x, size_y = term.getSize()
local logLoc = nil
local isDebug = false


-- functions: 

function handle.setLogDebug(boolean)
    isDebug = boolean
end

function handle.setLogLocation(loc)
    if fs.exists(loc) == false then
        local file = fs.open(loc, "w")
        file.writeLine("This log was created by Handle, a logging library.")
        file.close()
    end

    logLoc = loc
end

function handle.log(msg, type)
    local logType = nil

    if type == 0 and isDebug == true then
        logType = ": [DEBUG] "
    elseif type == 1 then
        logType = ": [INFO]  "
    else
        return -1
    end

    local file = fs.open(logLoc, "a")
    file.writeLine("[" .. os.date("%T", os.epoch("utc") / 1000) .. (" %03d]"):format(os.epoch("utc") % 1000):gsub("%.", " ") .. logType .. msg)
    file.close()
    return 1
end


function handle.exception(msg, sev)
    local x, y = term.getCursorPos()
    
    if sev == 0 then
        local file = fs.open(logLoc, "a")
        file.writeLine("[" .. os.date("%T", os.epoch("utc") / 1000) .. (" %03d]"):format(os.epoch("utc") % 1000):gsub("%.", " ") .. ": [WARN]  " .. msg)
        file.close()
    elseif sev == 1 then
        local file = fs.open(logLoc, "a")
        file.writeLine("[" .. os.date("%T", os.epoch("utc") / 1000) .. (" %03d]"):format(os.epoch("utc") % 1000):gsub("%.", " ") .. ": [ERROR] " .. msg)
        file.close()
    elseif sev == 2 then
        term.setCursorPos(x ,y)
        write("Program Crashed! Check log for more info!")
        local file = fs.open(logLoc, "a")
        file.writeLine("[" .. os.date("%T", os.epoch("utc") / 1000) .. (" %03d]"):format(os.epoch("utc") % 1000):gsub("%.", " ") .. ": [FATAL] " .. msg)
        file.close()
        error(" ", 0)
    else
        return -1
    end

    return 1
end
    
    
function handle.timedShutdown(time)
    if time > 100 then
        return -1
    end
    
    handle.log("Shutdown Command Issued in " .. time .. " seconds.", 1)
    write("Shutting down in: ")
    local x, y = term.getCursorPos()

    while time > 0 do
        write(time)
        time = time - 1
        os.sleep(1)
        term.setCursorPos(x, y)
        write("   ")
        term.setCursorPos(x, y)
    end
    
    term.clear()
    os.shutdown()
end

return handle

-- by PewPewCricket