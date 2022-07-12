local gradientColor = ''
local numfucker = 1
randomColor = {}
gradientAppear = {44, 88, 220}
gradientDisappear = {76, 156, 228}
gradientBool = false

function onCreatePost()
    --gradientColor = getProperty('gradient.color')
end
function onBeatHit()
    for i = 1, #gradientAppear do
        if gradientAppear[i] == curBeat then
            gradientBool = true
        elseif gradientDisappear[i] == curBeat then
            gradientBool = false
        end
    end
    if curBeat % numfucker == 0 and gradientBool then
        randomColor = {getColorFromHex('ffff3d'), getColorFromHex('0053d9'), getColorFromHex('8700b0'), getColorFromHex('fa4848'), getColorFromHex('ff3072')}
        random = getRandomInt(1, 5)
        setProperty('gradient.color', randomColor[random])
        
        setProperty('gradient.alpha', 1)
        doTweenAlpha('boppinggradient','gradient', 0, crochet*0.001)
    end
end
