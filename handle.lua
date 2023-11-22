-- error lib is a library for handling errors and shutdowns! It includes a list of functions for you to use, go to the github: _ for documentation.

local handle = {}
do
	local globaltbl = _G
	local newenv = setmetatable({}, {
		__index = function (t, k)
			local v = handle[k]
			if v == nil then return globaltbl[k] end
			return v
		end,
		__newindex = handle,
	})
	if setfenv then
		setfenv(1, newenv) -- for 5.1
	else
		_ENV = newenv -- for 5.2
	end
end


-- functions: 

function handle.log(msg, type)
    local logType = nil

    if type == 0 then
        logType = " [INFO]   "
    elseif type == 1 then
        logType = " [WARN]   "
    elseif type == 2 then
        logType = " [ERROR]  "
    elseif type == 3 then
        logType = " [FATAL]  "
    elseif type == 4 then
        logType = " [!FATAL] "
    else
        return -1
    end

    local file = fs.open("/logs/latest.log", "a")
    file.writeLine(os.date() .. logType .. msg)
    file.close()
    return 1
end


function handle.exception(sev, msg, pos)
    os.sleep(0.5)
    term.setCursorPos(1, pos)
    if sev == 0 then
        handle.log(msg, sev + 1)
    elseif sev == 1 then
        handle.log(msg, sev + 1)
    elseif sev == 2 then
        printError("Crashed! Check log for more info!")
        handle.log(msg, sev + 1)
        error(" ", 0)
    elseif sev == 3 then
        printError("Fatal error, shutting down computer!"
        handle.log(msg, sev + 1)
        handle.timedShutdown(10, pos + 2)
    end

    return 1
end
    
    
function handle.timedShutdown(time, pos)
    if time > 100 then
        return false
    end
    
    handle.log("Shutdown Command Issued in " .. time .. " seconds.", 1)
    term.setCursorPos(1, pos)
    write("Shutting down in: ")
        
    while time > 0 do
        write(time)
        time = time - 1
        os.sleep(1)
        term.setCursorPos(19, pos)
        write("   ")
        term.setCursorPos(19, pos)
    end
    
    term.clear()
    os.shutdown()
end

return handle

-- by PewPewCricket
