local camBopNum = 0
local zoomBeat = 0
function onEvent(name, value1, value2)
    if name == 'camBop' then
        camBopNum = tonumber(value1);
        zoomBeat = tonumber(value2)
    end
end
function onStepHit()
    dumCam = camBopNum * 4
    if curStep % dumCam == 0 and getProperty('camZooming') then
        setPropertyFromClass('flixel.FlxG', 'camera.zoom', getPropertyFromClass('flixel.FlxG', 'camera.zoom') + zoomBeat)
        setProperty('camHUD.zoom', zoomBeat / 2 + getProperty('camHUD.zoom'))
    end
end