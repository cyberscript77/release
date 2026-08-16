logme(1,"CyberScript: db module loaded")
cyberscript.module = cyberscript.module +1

-- Defensive: ensure the db global exists and has the expected tables before
-- any query runs. If the db is missing or the schema is wrong, log a clear
-- error and return empty tables instead of crashing the entire init chain.
-- This prevents the "no such table: Characters" fatal error that aborts
-- setupCore() → initCore() → makeNativeSettings().
function ensureDBReady()
        if db == nil then
                logme(1, "[Cyberscript DB] ERROR: db global is nil — sqlite3 connection not established. Database features disabled.", true)
                return false
        end
        -- Check that the Characters table exists
        local hasChars = false
        local checkOk = pcall(function()
                for row in db:nrows("SELECT name FROM sqlite_master WHERE type='table' AND name='Characters'") do
                        hasChars = true
                end
        end)
        if not checkOk or not hasChars then
                logme(1, "[Cyberscript DB] ERROR: Characters table missing from db.sqlite3. Database features disabled. Please restore db.sqlite3 from the Cyberscript distribution.", true)
                return false
        end
        return true
end



function loadCharacters(arrayPnjDb)
        if not ensureDBReady() then return end
        local stat = string.format("SELECT * FROM Characters")
        
        for row in db:nrows(stat) do
                local quest = {}
                quest.ID= row.ID
                quest.TweakIDs= row.TweakIDs
                quest.Names= row.Names
                table.insert(arrayPnjDb, quest)
                
                -- ----logme(2,arrayQuest[row.Id].Id) 
                
        end
        
end


function loadItems(arrayItems)
        if not ensureDBReady() then return end
        local stat = string.format("SELECT * FROM Items")
        
        for row in db:nrows(stat) do
                local item = {}
                item.Id= row.Id
                item.TweakId= row.TweakId
                item.Name= row.Name
                table.insert(arrayItems, item)
                
                -- ----logme(2,arrayQuest[row.Id].Id) 
                
        end
        
end


function readDBOutput(res)
        
        if(res == 0) then
                
                logme(2,"DB saved")
                
                else
                logme(2,"Error in DB : "..res)
                error("db error code " .. res)
                error (db:errmsg())
                db:interrupt()
        end
        
        
end

function reloadDB()
        
        --arrayQuest = initQuest()
        
        

        loadCharacters(arrayPnjDb)
        loadItems(arrayItems)
        
        
        
end