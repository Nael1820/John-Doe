local luaTextArray = {'red','green','blue', 'normal'}
local luaNumArray = {-4, 7, 12, 0}
local luaColorArray = {'FF0000','00FF00','0000FF','FFFFFF'}
function onCreatePost()
    for i = 1, #luaTextArray do
        makeLuaText('johnspeak'..i,'', 789 ,240 +i+ luaNumArray[i], 100 + i + luaNumArray[i])
        setTextSize('johnspeak'..i, 50)
        setTextColor('johnspeak'..i, luaColorArray[i])
        setTextFont('johnspeak4','gillsans.ttf')
        addLuaText('johnspeak'..i)
        setObjectCamera('johnspeak'..i, 'other')
        setProperty('johnspeak4.antialiasing', false)
        setTextColor('johnspeak4', '383838')
        setTextBorder('johnspeak4', 1, 'FFFFFF')
    end
end

local textArray = {"Hi, I'm John from Roblox customer support. I'm here to inform you that I am logging into your account to make sure you are rightfully punished for attempting to gain access to an official Roblox account. Your punishment begins tomorrow on March 18th.",
                    "You know this is just a stupid block game, right???"}
local textTarget = 0

function lerp(a,b,t) return a * (1-t) + b * t end
function remap(value, a1, a2, b1, b2)
    return b1 + (value-a1)*(b2-b1)/(a2-a1);
end

function startText(timer, target)
    runTimer('textWrite', timer, string.len(textArray[target]))
    textTarget = target
end

function onTimerCompleted(tag, loop, loopleft)
    if tag == 'textWrite' then
        for i = 1, #luaTextArray do
            if i <= 3 then
                setProperty('johnspeak'..i..'.alpha', 0.5)
            else
                setProperty('johnspeak'..i..'.alpha', 1)
            end
        end
        --for i = 1, #luaTextArray do
            setTextString('johnspeak4',string.sub(textArray[textTarget], 0, (loop - loopleft)))
            screenCenter('johnspeak4','x')
        --end
        -- COLORED TEXT HAS BEEN SCRAPPED DUE TO MEMORY INCREASE GOT FUCKING DAMMIT
    end
end

function onBeatHit()
    if curBeat == 2 then
        startText(0.056, 1)
    end

    if curBeat == 23 then
        for i = 1, #luaTextArray do
            doTweenAlpha('e'..i,'johnspeak'..i, 0, 0.4)
        end
    end
    
    if curBeat == 78 then
        startText(0.05, 2)
    end
    
    if curBeat == 88 then
        for i = 1, #luaTextArray do
            doTweenAlpha('e'..i,'johnspeak'..i, 0, 0.4)
        end
    end
end