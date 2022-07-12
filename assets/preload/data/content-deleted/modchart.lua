local defaultDadnotePos = {};
local defaultBfnotePos = {};
local defaultNotePos = {};
local downscrollnum = 20
local downscrollnum2 = -10

function lerp(a,b,t) return a * (1-t) + b * t end

function remap(value, a1, a2, b1, b2)
    return b1 + (value-a1)*(b2-b1)/(a2-a1);
end

function round(exact, quantum)
    local quant,frac = math.modf(exact/quantum)
    return quantum * (quant + (frac > 0.5 and 1 or 0))
end

function onSongStart()
    if downscroll then
        downscrollnum = -20
        downscrollnum2 = 10
    end
    setProperty('cameraSpeed', 2)
    for i = 0,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y') + downscrollnum

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')

        table.insert(defaultNotePos, {x, y, angle})
    end
    for i = 0,3 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y') + downscrollnum

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')

        table.insert(defaultDadnotePos, {x, y, angle})
    end
    for i = 4,7 do
        x = getPropertyFromGroup('strumLineNotes', i, 'x')

        y = getPropertyFromGroup('strumLineNotes', i, 'y') + downscrollnum

        angle = getPropertyFromGroup('strumLineNotes', i, 'angle')

        table.insert(defaultBfnotePos, {x, y, angle})
    end
end
wave = false
spinningHUD = false
swayingHUD = false
swayingNotes = false
weirdNoteMovement = false
speedSwitch = false
annoyingNote = false
idkNote = false
oneNoteScroll = false
bopFuck = false
swayingStrums = false

function centeredStrums()
    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] - 318)
    end
    for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
end

function onUpdatePost(elapsed)
    songPos = getPropertyFromClass('Conductor', 'songPosition');
    currentBeat = (songPos / 1000) * (bpm / 40)
    currentBeat2 = (songPos / 1000) * (bpm / 20)
    currentBeat3 = (songPos / 1000) * (bpm / 80)
    currentBeat4 = (songPos / 1000) * (bpm / 120)
    if getProperty('health') >= 0.05 then
    if wave then 
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 15 * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 5 * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end
    if spinningHUD then
        setProperty('camHUD.x', 10 - 40 * math.sin((currentBeat2 * 0.25) * math.pi))
        setProperty('camHUD.y', 20 * math.cos((currentBeat2 * 0.25) * math.pi))
        setProperty('camHUD.angle', 1 * math.cos((currentBeat2 * 0.25) * math.pi))
    end
    if swayingHUD then
        setProperty('camHUD.angle', 30 * math.cos((currentBeat3 * 0.25) * math.pi))
        setProperty('camHUD.zoom', 0.95 + 0.15 * math.sin((currentBeat*0.25)*math.pi))
        setProperty('camHUD.y', 0.5 * math.sin((currentBeat*0.25)*math.pi))
    end
    if swayingNotes then
        for i = 0, 7 do
            noteTweenDirection('sway'..i, i, 90 + 15 * math.cos((currentBeat2 * 0.25) * math.pi), 0.001 )
            noteTweenAngle('swayangle'..i, i,15 * math.cos((currentBeat2 * 0.25) * math.pi), 0.001 )
        end
    end
    if weirdNoteMovement then
        for i = 0,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', lerp(getPropertyFromGroup('strumLineNotes', i, 'x'), defaultNotePos[i + 1][1] + 40 * math.sin((currentBeat2*0.25) * math.pi), elapsed * 3))
            setPropertyFromGroup('strumLineNotes', i, 'y', lerp(getPropertyFromGroup('strumLineNotes', i, 'y'), defaultNotePos[i + 1][2] + 60 * math.cos((currentBeat2*0.25) * math.pi), elapsed * 3))
        end
    end
    if speedSwitch then
        triggerEvent('Change Scroll Speed', 1.1 + 0.1 * math.sin((currentBeat2*0.25)*math.pi), 0.001)
    end
    if annoyingNote then
        for i = 0, getProperty('notes.length') do
            if downscroll then shit = 300 else shit = -300 end

            setPropertyFromGroup('notes', i,'y', shit + (songPos - getPropertyFromGroup('notes', i, 'strumTime') * (0.45 * round(getProperty('songSpeed'), 2))))
        end
    end
    
    if idkNote then
        for i = 0, getProperty('notes.length') - 1 do
                if songPos >= getPropertyFromGroup('notes', i, 'strumTime') - 400 then
                    setPropertyFromGroup('notes', i,'y', lerp(getPropertyFromGroup('notes', i, 'y'), remap(getPropertyFromGroup('notes', i, 'y') * 20, 0,1,0,1.5) - ((songPos / 1000) - getPropertyFromGroup('notes', i, 'strumTime')) * math.cos(0.1), elapsed / 4))
                else
                    setPropertyFromGroup('notes', i,'y', lerp(getPropertyFromGroup('notes', i, 'y'), remap(getPropertyFromGroup('notes', i, 'y') * 0.01, 0,1,0,1.3) - ((songPos / 1000) - getPropertyFromGroup('notes', i, 'strumTime')) * math.cos(0.1), elapsed / 2))
                end
        end
    end

    for i = 0,7 do
        setPropertyFromGroup('strumLineNotes', i, 'scale.x', lerp(getPropertyFromGroup('strumLineNotes', i, 'scale.x'), 0.7 * math.cos(0.1), elapsed * 6))
    end

    if swayingStrums then
        for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'x', defaultDadnotePos[i + 1][1] + 40 + 280 * math.sin((currentBeat4+i*0.025) * math.pi))
        end
        for i = 4,7 do
            setPropertyFromGroup('strumLineNotes', i, 'x', (defaultBfnotePos[i - 3][1] - 300) - 280 * math.sin((currentBeat4+i*0.025) * math.pi))
        end
    end
end
    
end
function onStepHit()
    if curStep == 896 then -- 895
    centeredStrums()
    end
end

function onBeatHit() -- its fine im not using arrays
    if getPropertyFromClass('flixel.FlxG','save.data.modchartEnable') and getProperty('health') >= 0.05 then
    if curBeat == 44 then
        wave = true
    end
    if curBeat == 76 then
        wave = false
        resetShit(true)
    end
    if curBeat == 92 then
        spinningHUD = true
        swayingNotes = true
    end
    if curBeat == 107 then
        speedSwitch = true
    end
    if curBeat == 124 then
        wave = true
    end
    if curBeat == 156 then
        spinningHUD = false
        swayingNotes = false
        wave = false
        resetShit(false, false, false, true, false)
        weirdNoteMovement = true
    end
    if curBeat == 220 then
        weirdNoteMovement = false
        resetShit(true, false, false, false, false)
    end

    if curBeat == 221 then
        speedSwitch = false
        resetShit(false, false, true, false, true)
    end
    if curBeat == 224 then
        bopFuck = true
    end
    if curBeat == 240 then
        swayingNotes = true
    end
    if curBeat == 256 then
        bopFuck = false
        swayingNotes = false
        resetShit(true, false, false, true, true)
        swayingStrums = true
    end
    if curBeat == 288 then
        swayingStrums = false
        bopFuck = true
    end
end
end
bopBeat = -1
namber = 0
function goodNoteHit(id, dir, type, sus)
    if bopFuck and not sus then
        bopBeat = bopBeat + 1
        if bopBeat == 0 then
        fuckBop(0)
        elseif bopBeat == 1 then
        fuckBop(1)
        elseif bopBeat == 2 then
        fuckBop(0)
        elseif bopBeat == 3 then
        fuckBop()
        bopBeat = -1
        end
    end
end

function resetShit(resetnote, resetnotealpha, resetscrollspeed, resethud, isInstant)
    if resetnote then
        for i = 0,7 do
            if isInstant then
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1])
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2])
            noteTweenDirection('directioback'..i, i, 90, 0.001 )
            noteTweenAngle('angleback'..i, i,0, 0.001 )
            else
            noteTweenX('noteX'..i, i, defaultNotePos[i + 1][1], crochet*0.002, 'circout')
            noteTweenY('noteY'..i, i, defaultNotePos[i + 1][2], crochet*0.002, 'circout')
            noteTweenDirection('directioback'..i, i, 90, crochet*0.002, 'circout' )
            noteTweenAngle('angleback'..i, i,0, crochet*0.002, 'circout' )
            end
        end
    end
    if resetnotealpha and not middlescroll then
        for i = 0,7 do
        if isInstant then
            noteTweenAlpha('fuckshit'..i, i, 1, 0)
        else
        noteTweenAlpha('fuckshit'..i, i, 1, crochet*0.001, 'circout')
            end
        end
    end
    if resetscrollspeed then
        if isInstant then
            setProperty('songSpeed', 3.1)
        else
            triggerEvent('Change Scroll Speed', 1, crochet*0.002)
        end
    end
    if resethud then
        if isInstant then
        setProperty('camHUD.angle', 0)
        setProperty('camHUD.x', 0)
        setProperty('camHUD.y', 0)
        else
        doTweenAngle('fuckinghud','camHUD', 0, crochet*0.002, 'circout')
        doTweenY('fuckinghud','camHUD', 0, crochet*0.002, 'circout')
        doTweenX('fuckinghud','camHUD', 0, crochet*0.002, 'circout')
        end
    end
end

function fuckBop(num)
if getProperty('health') >= 0.05 then
    xOffset = 318
    if num == 0 or num == 1 then
    for i = 0, 7 do
        if num == 1 then
        bitch = 7 - i
        namber = 20 * bitch
        else
        namber = 20 * i
        end
        if num == 0 then
        fucknum = defaultNotePos[i + 1][2] - namber
        elseif num == 1 then
        fucknum = defaultNotePos[i + 1][2] - namber
        end
        setPropertyFromGroup('strumLineNotes', i, 'y', fucknum)
        noteTweenY('noteYBOP'..i, i, defaultNotePos[i + 1][2], crochet*0.001, 'circout')
    end
end
    for i = 0, 1 do
        fucknum = defaultDadnotePos[i + 1][1] - 70
        if i == 1 then i = 3
        fucknum = defaultDadnotePos[i + 1][1] + 70
        end
        setPropertyFromGroup('strumLineNotes', i, 'x', fucknum - xOffset)
        noteTweenX('noteX'..i, i, defaultDadnotePos[i + 1][1] - xOffset, crochet*0.001, 'circout')
    end
    for i = 4, 5 do
        fucknum = defaultBfnotePos[i - 3][1] - 70
        if i == 5 then i = 7
        fucknum = defaultBfnotePos[i - 3][1] + 70
        end
        setPropertyFromGroup('strumLineNotes', i, 'x', fucknum - xOffset )
        noteTweenX('noteX'..i, i, defaultBfnotePos[i - 3][1] - xOffset, crochet*0.001, 'circout')
    end
    for i = 1, 2 do
        fucknum = defaultDadnotePos[i + 1][1] - 30
        if i == 2 then
        fucknum = defaultDadnotePos[i + 1][1] + 30
        end
        setPropertyFromGroup('strumLineNotes', i, 'x', fucknum- xOffset )
        noteTweenX('noteX'..i, i, defaultDadnotePos[i + 1][1] - xOffset, crochet*0.001, 'circout')
    end
    for i = 5, 6 do
        fucknum = defaultBfnotePos[i - 3][1] - 30
        if i == 6 then
        fucknum = defaultBfnotePos[i - 3][1] + 30
        end
        setPropertyFromGroup('strumLineNotes', i, 'x', fucknum - xOffset)
        noteTweenX('noteX'..i, i, defaultBfnotePos[i - 3][1] - xOffset, crochet*0.001, 'circout')
    end
    for i = 0, 7 do
        setPropertyFromGroup('strumLineNotes', i, 'scale.x', 1)
    end
end
end