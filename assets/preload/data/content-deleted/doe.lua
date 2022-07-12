windowText = {"JohnDoe.Transparency = lerp(JohnDoe.Transparency, 1 * math.cos(0.1), elapsed * 2)",
            'forceStretchWindow()',
            'menu.Transparency = 0', 
            'songSpeed = 3.1',
            'menu.Transparency = 1',
            'menu.Transparency = 0',
            'speedSwitch = true',
            'playerStrums[i].Transparency = 0',
            'playerStrums[i].Transparency = 1',
            'speedSwitch = false',
            'skyscraper.Transparency = 0',
            'menu.Transparency = 1',
            'forceWindowPos = false',
            'house.Transparency = 0',
            'skyscraper.Transparency = 1',
            'glass.Transparency = 0',
            'house.Transparency = 1',
            'glass.Transparency = 1'
            }
textBeat = {11, 17 ,22, 40, 72, 88, 104, 156,216, 221, 222, 223, 226 ,238, 239, 254, 255, 284}
resetTextBeat = {16, 19 ,24, 44, 76, 92, 107, 159, 218, 222, 223,224, 232 ,239, 240, 255, 256, 288}
timerBeat = {0.03 ,0.055, 0.055, 0.06, 0.06 , 0.06,0.04, 0.025, 0.02,0.01,0.005,0.01, 0.04 ,0.005, 0.005, 0.005, 0.005, 0.04}
local textTarget = 0
enabledCrash = false
johnX = 0
johnY = 0
function onCreatePost()
    windowText[0] = 'Sys.exit(0)'

    setProperty('dad.alpha', 0.00001)
    setProperty('gf.visible', false)
    setProperty('boyfriend.visible', false)
    addCharacterToList('john')

    johnX = getProperty('dad.x')
    johnY = getProperty('dad.y')
end
function startWindowText(timer, target)
    runTimer('winText', timer, string.len(windowText[target]))
    textTarget = target
end

function startErrortext()
    runTimer('winTextError', 0.04, string.len("ERROR: Couldn't modify that."))
end

function lerp(a,b,t) return a * (1-t) + b * t end

function remap(value, a1, a2, b1, b2)
    return b1 + (value-a1)*(b2-b1)/(a2-a1);
end
forceWindowPos = true

function forceStretchWindow(elapsex)
    winWidth = remap(990, 0,1,0,1.3) -- 1280
    winHeight = remap(563, 0,1,0,1.3) -- 720
    winX = remap(50, 0,1,0,1.3)
    winY = remap(20, 0,1,0,1.3)
    --if getPropertyFromClass("openfl.Lib", "application.window.width") >= 1280 or getPropertyFromClass("openfl.Lib", "application.window.width") <= 1280 then
        setPropertyFromClass("openfl.Lib", "application.window.width", lerp(getPropertyFromClass("openfl.Lib", "application.window.width"), winWidth * math.cos(0.1), elapsex))
    --elseif getPropertyFromClass("openfl.Lib", "application.window.height") >= 1280 or getPropertyFromClass("openfl.Lib", "application.window.height") <= 1280 then
        setPropertyFromClass("openfl.Lib", "application.window.height", lerp(getPropertyFromClass("openfl.Lib", "application.window.height"), winHeight * math.cos(0.1), elapsex))
    --end
    --debugPrint('winWidth: '..getPropertyFromClass("openfl.Lib", "application.window.width")..', winHeight: '..getPropertyFromClass("openfl.Lib", "application.window.height"))
    if forceWindowPos then
        setPropertyFromClass("openfl.Lib", "application.window.x", lerp(getPropertyFromClass("openfl.Lib", "application.window.x"), winX * math.cos(0.1), elapsex* 2))
        setPropertyFromClass("openfl.Lib", "application.window.y", lerp(getPropertyFromClass("openfl.Lib", "application.window.y"), winY * math.cos(0.1), elapsex* 2))
        --debugPrint(getPropertyFromClass("openfl.Lib", "application.window.x"))
        --debugPrint(getPropertyFromClass("openfl.Lib", "application.window.y"))
    end
end
enableUnderscore = false
underscore = '_'
local forceFNF = true
function onStepHit()
    enableUnderscore = not enableUnderscore
    if enableUnderscore then underscore = '_' else underscore = '' end
end
function onTimerCompleted(tag, loop, loopleft)
    if tag == 'winText' then
        if not enabledCrash then
            setPropertyFromClass("openfl.Lib", "application.window.title", '>'..string.sub(windowText[textTarget], 0, (loop - loopleft))..underscore)
        else
            setPropertyFromClass("openfl.Lib", "application.window.title", '>'..string.sub(windowText[0], 0, (loop - loopleft))..underscore)
        end
        forceFNF = false
        cancelTimer('winTextError')
    end
    if tag == 'winTextError' then
        setPropertyFromClass("openfl.Lib", "application.window.title", string.sub("ERROR: Couldn't modify that.", 0, (loop - loopleft)))
        forceFNF = false
        cancelTimer('endErrorText')

        runTimer('endErrorText', 0.7)
    end
    if tag == 'CRASH' then
        for i = 0, getProperty('unspawnNotes.length')-1 do
            for i=0,4,1 do
                setPropertyFromGroup('opponentStrums', i, 'texture', nil)
            end
        end
    end
    if tag == 'endErrorText' then
        forceFNF = true
    end
end

function onBeatHit()
    setPropertyFromClass("FlxG", "fullscreen", false)
    for i = 1, #textBeat do
        if textBeat[i] == curBeat then
            startWindowText(timerBeat[i], i)
        end
    end
    for i = 1, #resetTextBeat do
        if resetTextBeat[i] == curBeat then
            forceFNF = true
        end
    end
        
    if curBeat == resetTextBeat[4] then
        cameraFlash('hud','ffffff', 1)
        if getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') then
            setProperty('songSpeed', 3.1)
        end
        setProperty('darklayer.visible', false);
    end
    if getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') then
    for i = 0,3 do 
        for a = 0, getProperty('unspawnNotes.length') - 1 do
        if curBeat == resetTextBeat[8] then
                setPropertyFromGroup('playerStrums',i,'alpha',0)
                setPropertyFromGroup('unspawnNotes', a, 'copyAlpha', false)
        elseif curBeat == resetTextBeat[9] then
                setPropertyFromGroup('playerStrums',i,'alpha',1)
                setPropertyFromGroup('unspawnNotes', a, 'copyAlpha', true)
            end
        end
    end
end

    if curBeat == resetTextBeat[2] or curBeat == resetTextBeat[4] or curBeat == resetTextBeat[7] or curBeat == resetTextBeat[8] or curBeat == resetTextBeat[10] or curBeat == resetTextBeat[13]  then
        if not getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') then
            startErrortext()
        end
    end

    if curBeat >= 382 then
        endSong()
    end
end

local lerpValueX = 0
local lerpValueY = 0
function onUpdate(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 20)
        lerpValueY =  5 * math.cos((currentBeat * 0.25) * math.pi)
        lerpValueX = 12 * math.sin((currentBeat * 0.25) * math.pi)
        setProperty('dad.x', lerp(getProperty('dad.x'), johnX + lerpValueX * math.cos(0.1), elapsed * 12))
        setProperty('dad.y', lerp(getProperty('dad.y'), johnY + lerpValueY * math.cos(0.1), elapsed * 12))
    valueremap = remap(45, 0,1,0,1.3)
    if curBeat >= resetTextBeat[13] and curBeat <= 351  and getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') then
        forceWindowPos = false
        setPropertyFromClass("openfl.Lib", "application.window.x", valueremap + (60 * math.sin((currentBeat*0.25) * math.pi)))
        setPropertyFromClass("openfl.Lib", "application.window.y", (valueremap - 20) + (60 * math.cos((currentBeat*0.25) * math.pi)))
    else
        forceWindowPos = true
    end
end

function onUpdatePost(elapsed)
    if forceFNF then setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine") end
    setPropertyFromClass('openfl.Lib','application.window.fullscreen', false) -- bahaha fuck you
    if curBeat >= resetTextBeat[1] and curBeat <= 40 then
        setProperty('dad.alpha',lerp(getProperty('dad.alpha'), 1 * math.cos(0.1), elapsed * 2)) -- im not using tweenAlpha
    end
    if curBeat >= resetTextBeat[2] then
        if getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') then
            forceStretchWindow(elapsed * 4)
        end
    end
    if enabledCrash and isOn then
        startWindowText(0.3, 0)
        runTimer('CRASH', 4)
        isOn = false
    end

end

-- reset the title window
function onGameOver()
    cancelTimer('winText')
    cancelTimer('winTextError')
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
    return Function_Continue
end
    
function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
end
-- end