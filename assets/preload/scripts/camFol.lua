local charName = {}
local charPosX = {}
local charPosY = {}
local xx = 0
local yy = 0
local xx2 = 0
local yy2 = 0
local fastenCam = true
local dadZoom = 0
local bfZoom = 0
local offseto = 20

function onCreate()
    dadZoom = getProperty('defaultCamZoom') + 0.1
    bfZoom = getProperty('defaultCamZoom')
    setProperty('camZooming', true)
    if fastenCam then
        setProperty('cameraSpeed', 2)
    end
end
function makePos()
    charName[1] = 'gf'
    charName[2] = 'bf'
    charName[3] = 'john'

    charPosX[1] = getProperty('dad.x') + 450
    charPosX[2] = getProperty('dad.x') + 450
    charPosX[3] = getProperty('dad.x') + 450

    charPosY[1] = getProperty('dad.y') + 200;
    charPosY[2] = getProperty('dad.y') + 300;
    charPosY[3] = getProperty('dad.y') + 300;
end

function onUpdate(elapsed)
makePos()
for i = 0,3 do
    if dadName == charName[i] then
        xx = charPosX[i]
        yy = charPosY[i]
    end
end
if boyfriendName == charName[2] then
xx2 = charPosX[2]
yy2 = charPosY[2]
end
    -- HAHA STOELN FROM VANDALIZATION
    if mustHitSection == false then
        setProperty('defaultCamZoom', dadZoom)
        if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
        triggerEvent('Camera Follow Pos',xx-offseto,yy)
        elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
        triggerEvent('Camera Follow Pos',xx+offseto,yy)
        elseif getProperty('dad.animation.curAnim.name') == 'singUP' then
        triggerEvent('Camera Follow Pos',xx,yy-offseto)
        elseif getProperty('dad.animation.curAnim.name') == 'singDOWN' then
        triggerEvent('Camera Follow Pos',xx,yy+offseto)
        elseif getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
        triggerEvent('Camera Follow Pos',xx-offseto,yy)
        elseif getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
        triggerEvent('Camera Follow Pos',xx+offseto,yy)
        elseif getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
        triggerEvent('Camera Follow Pos',xx,yy-offseto)
        elseif getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
        triggerEvent('Camera Follow Pos',xx,yy+offseto)
        else
        triggerEvent('Camera Follow Pos',xx,yy)
        end
        else
        setProperty('defaultCamZoom', bfZoom)
        if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
        triggerEvent('Camera Follow Pos',xx2-offseto,yy2)
        elseif getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
        triggerEvent('Camera Follow Pos',xx2+offseto,yy2)
        elseif getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
        triggerEvent('Camera Follow Pos',xx2,yy2-offseto)
        elseif getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
        triggerEvent('Camera Follow Pos',xx2,yy2+offseto)
        else
        triggerEvent('Camera Follow Pos',xx2,yy2)
        end
    end
    -- end --
end