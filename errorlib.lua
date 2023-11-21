-- error lib is a library for handling errors and shutdowns! It includes a list of functions for you to use, go to the github: _ for documentation.

local errorlib = {}
do
	local globaltbl = _G
	local newenv = setmetatable({}, {
		__index = function (t, k)
			local v = errorlib[k]
			if v == nil then return globaltbl[k] end
			return v
		end,
		__newindex = errorlib,
	})
	if setfenv then
		setfenv(1, newenv) -- for 5.1
	else
		_ENV = newenv -- for 5.2
	end
end


-- functions: 

function errorlib.exception(sev, msg, pos)
    os.sleep(0.5)
    term.setCursorPos(1, pos)

    if sev == 0 then
        printError(os.clock(), ": [WARN] ", msg)
        return 0
    elseif sev == 1 then
        printError(os.clock(), ": [ERROR] ", msg)
        os.sleep(0.2)
        return 0
    elseif sev == 2 then
        printError(os.clock(), ": [FATAL] ", msg)
        os.sleep(0.5)
        error(" ", 0, 0)
        return 0
    elseif sev == 3 then
        printError(os.clock(), ": [FATAL] ", msg)
        os.sleep(0.5)
        errorlib.timedShutdown(10, pos + 2)
        return 0
    end

end
    
    
function errorlib.timedShutdown(time, pos)
    if time > 100 then
        return -1
    end
    
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
    return -1
end

return errorlib

-- by PewPewCricket
