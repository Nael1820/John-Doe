function onCreatePost()
	setPropertyFromClass('flixel.FlxG','save.data.modchartEnable', true)
    makeLuaText('modcharte','Modchart', 0, 150, 200)
    makeLuaText('modchartchoice','A < true > D', 0, 150, 300)
	makeLuaText('modchartenter','Press ENTER to continue', 0, 150, 500)
    setObjectCamera('modcharte','other')
    setObjectCamera('modchartchoice','other')
	setObjectCamera('modchartenter','other')
    setTextSize('modcharte', 48)
    setTextSize('modchartchoice', 48)
	setTextSize('modchartenter', 48)
    addLuaText('modcharte')
    addLuaText('modchartchoice')
	addLuaText('modchartenter')
	screenCenter('modcharte','x')
	screenCenter('modchartchoice','x')
	screenCenter('modchartenter','x')

    if middlescroll then
        makeLuaText('scroll','Sorry mate, middlescroll is not supported.', 0, 150, 20)
        setObjectCamera('scroll','other')
        addLuaText('scroll')
        screenCenter('scroll','x')
    end
end

isOn = true
function onUpdate()
    if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ENTER') and isOn then
        if middlescroll then
            endSong()
        else
            playSound('confirmMenu', 1, 'enter')
        end
        isOn = false
    elseif (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.D') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.RIGHT'))  and isOn then
        setPropertyFromClass('flixel.FlxG','save.data.modchartEnable', true)
        setTextString('modchartchoice', 'A < true > D')
        playSound('scrollMenu', 1)
		screenCenter('modchartchoice','x')
    elseif (getPropertyFromClass('flixel.FlxG', 'keys.justPressed.A') or getPropertyFromClass('flixel.FlxG', 'keys.justPressed.LEFT')) and isOn then
        setPropertyFromClass('flixel.FlxG','save.data.modchartEnable', false)
        setTextString('modchartchoice', 'A < false > D')
        playSound('scrollMenu', 1)
		screenCenter('modchartchoice','x')
    elseif getPropertyFromClass('flixel.FlxG', 'keys.justPressed.ESCAPE')  and isOn then
        endSong()
    end
end
local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown then
		setProperty('inCutscene', true);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end


function onSoundFinished(tag)
    if tag == 'enter' then
        setProperty('inCutscene', false);
        removeLuaText('modcharte')
        removeLuaText('modchartchoice')
		removeLuaText('modchartenter')
        removeLuaText('scroll')
		startCountdown()
    end
end
