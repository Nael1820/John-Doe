
local modchart = false
local beginY, lerpY, sustainVal = 20000,0,0


function seTup()
	modchart = getPropertyFromClass('flixel.FlxG','save.data.modchartEnable')
	if modchart then
		if downscroll then
			beginY = -beginY
			lerpY = 10000
			sustainVal = -500
		else
			lerpY = 990
		end
	end
end

function onStartCountdown()
	seTup()
	for a = 0, getProperty('unspawnNotes.length') - 1 do
		local strumTime = getPropertyFromGroup('notes', a, 'strumTime');
	   if getPropertyFromGroup('unspawnNotes', a, 'noteType') == 'Cool Note Effect' and modchart then
		  setPropertyFromGroup("unspawnNotes", a, "offsetY", beginY)
		  if getPropertyFromGroup("unspawnNotes", a, "isSustainNote") then 
			 setPropertyFromGroup("unspawnNotes", a, "offsetY", beginY + (downscroll and 20 or -20))
		  end
		end
	end
	return Function_Continue;
end

function lerp(a, b, t) return a + (b - a) * t end
	
function onUpdatePost(elapsed)
	if modchart then
		for a = 0, getProperty('notes.length') - 1 do
			local strumTime = getPropertyFromGroup('notes', a, 'strumTime');
			local sus = getPropertyFromGroup('notes', a, 'isSustainNote');
			if getPropertyFromGroup('notes', a, 'noteType') == 'Cool Note Effect' then
				setPropertyFromGroup('notes',a,'y',getPropertyFromGroup('notes',a,'y') * 0.05)
			if (strumTime - getSongPosition()) < 2500 / scrollSpeed then
				if sus then
					setPropertyFromGroup("notes", a, "offsetY", lerp(getPropertyFromGroup("notes", a, "offsetY"), lerpY + (0.2 * scrollSpeed) + sustainVal , elapsed * (1.5 * scrollSpeed)))
				else
					setPropertyFromGroup("notes", a, "offsetY", lerp(getPropertyFromGroup("notes", a, "offsetY"), lerpY + (0.2 * scrollSpeed) , elapsed * (1.5 * scrollSpeed)))
				end
			end
	
			end
		end
	end
end

 -- Credits for reference: AN AMMAR