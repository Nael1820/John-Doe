local dumbNum = 6
local dumbBool = false
function goodNoteHit(id ,dir, noteType, sus)
    if mustHitSection == true and not sus then -- AAAH WHAT THE HELL
        setProperty('camGame.angle', dumbNum)
        dumbBool = not dumbBool
        if dumbBool then
            dumbNum = -2
        else
            dumbNum = 2
        end   
    end
end
function opponentNoteHit(id ,dir, noteType, sus)
    if mustHitSection == false and not sus then
        setProperty('camGame.angle', dumbNum)
        dumbBool = not dumbBool
        if dumbBool then
            dumbNum = -2
        else
            dumbNum = 2
        end  
    end
end

function lerp(a,b,t) return a * (1-t) + b * t end

function remap(value, a1, a2, b1, b2)
    return b1 + (value-a1)*(b2-b1)/(a2-a1);
end

function onUpdatePost(elapsed)
    num = remap(0.001, 0,1.1,0,1.4)
    setProperty('camGame.angle', lerp(getProperty('camGame.angle'), num * math.cos(0.1), elapsed * 6))
end