function onCreate()
	-- background shit
	makeAnimatedLuaSprite('static','roblox/static', 1170, -20)
	addAnimationByPrefix('static','idle','6fcb43823fa8700a9b405f5d6160e4e4_w200_gif',24,true) -- :skull:
	objectPlayAnimation('static','idle')
	setProperty('static.width',getProperty('static.width') * 3.2 )
	setProperty('static.height',getProperty('static.height') * 2 )
	addLuaSprite('static')
	setProperty('static.alpha', 0.3)

	makeLuaSprite('menu','roblox/menu',450, -100);
	setLuaSpriteScrollFactor('menu', 0.6,0.6);
	scaleObject('menu', 0.75, 0.75);

	makeLuaSprite('skyscraper', 'roblox/skyscraper', 200, -70);
	setLuaSpriteScrollFactor('skyscraper', 0.2,0.2);
	scaleObject('skyscraper',0.72, 0.72);

	makeLuaSprite('house', 'roblox/house', 200, -70);
	setLuaSpriteScrollFactor('house',  0.2, 0.2);
	scaleObject('house', 0.72, 0.72);

	makeLuaSprite('glass', 'roblox/glass',200, -70);
	setLuaSpriteScrollFactor('glass',  0.2, 0.2);
	scaleObject('glass', 0.72, 0.72);

	makeLuaSprite('darklayer', 'roblox/darklayer',0, -50);
	setLuaSpriteScrollFactor('darklayer',  0, 0);
	scaleObject('darklayer', 7, 7);
	
	makeLuaSprite('dark', 'roblox/dark',0, -50);
	setLuaSpriteScrollFactor('dark',  0, 0);
	scaleObject('dark', 7, 7);

	makeLuaSprite('whitelayer', 'roblox/whitelayer',0, -50);
	setLuaSpriteScrollFactor('whitelayer',  0, 0);
	scaleObject('whitelayer', 7, 7);

	makeLuaSprite('glitch1', 'roblox/glitch1',0, -50);
	setLuaSpriteScrollFactor('glitch1',  0, 0);
	scaleObject('glitch1', 7, 7);

	makeLuaSprite('glitch2', 'roblox/glitch2',0, -50);
	setLuaSpriteScrollFactor('glitch2',  0, 0);
	scaleObject('glitch2', 7, 7);

	makeLuaSprite('glitch3', 'roblox/glitch3',0, -50);
	setLuaSpriteScrollFactor('glitch3',  0, 0);
	scaleObject('glitch3', 7, 7);

	addLuaSprite('glitch1', true);
	addLuaSprite('glitch2', true);
	addLuaSprite('glitch3', true);
    addLuaSprite('dark', true);
	addLuaSprite('menu', false);
	addLuaSprite('skyscraper', false);
	addLuaSprite('house', false);
	addLuaSprite('whitelayer', true);
	addLuaSprite('darklayer', true);
	addLuaSprite('glass', false);
	setProperty('dark.visible', false);
	setProperty('glass.visible', false);
	setProperty('skyscraper.visible', false);
	setProperty('house.visible', false);
	setProperty('whitelayer.visible', false);
	setProperty('darklayer.visible', false);
	setProperty('menu.visible', false);
	setProperty('camHUD.visible', false); 
	setProperty('glitch1.visible', false); 
	setProperty('glitch2.visible', false); 
	setProperty('glitch3.visible', false);  

	precacheImage('roblox/menu')
	precacheImage('roblox/skyscraper')
	precacheImage('roblox/house')
	precacheImage('roblox/glass')
	

	makeLuaSprite('gradient', 'roblox/gradiento', 100, -600);
	setGraphicSize('gradient', getProperty('gradient.width') * 1.2, getProperty('gradient.height') * 1.2)
	setScrollFactor('gradient', 0.1, 0.1);
	addLuaSprite('gradient', true); 
	setProperty('gradient.alpha', 0);  
	
end

function onStepHit()

	if curStep == 96 then
		cameraFlash('game', '0xFFFFFF', 1, true);
		setProperty('camHUD.visible', true); 
		setProperty('menu.visible', true);
		setProperty('darklayer.visible', true);
	end
	if curStep == 160 then
		setProperty('glitch1.visible', true);
	end
	if curStep == 161 then
		setProperty('glitch1.visible', false);
	end
	if curStep == 163 then
		setProperty('glitch3.visible', true);
	end
	if curStep == 171 then
		setProperty('glitch2.visible', true);
		setProperty('glitch1.visible', true);
		cameraShake('camGame', 0.05, 0.5);
	end
	if curStep == 176 then
		setProperty('glitch2.visible', false);
		setProperty('glitch1.visible', false);
	end
	if curStep == 304 then
		setProperty('glitch3.visible', false);
		cameraFlash('game', '000000', 1, false);
		setProperty('menu.visible', false);
		setProperty('camHUD.visible', false); 
		setProperty('darklayer.visible', false);
	end
	if curStep == 345 then 
		cameraFlash('game', '000000', 1, true);
		setProperty('camHUD.visible', false);
		setProperty('menu.visible', false);
		setProperty('dark.visible', true);
	end
	if curStep == 368 then
		cameraFlash('game', '0xFFFFFF', 0.2, false);
		setProperty('camHUD.visible', true)
		setProperty('menu.visible', true);
		setProperty('dark.visible', false);
		setProperty('darklayer.visible', true);
	end
	if curStep == 636 then
		setProperty('glitch1.visible', true);
	end
	if curStep == 637 then
		setProperty('glitch1.visible', false);
		setProperty('glitch2.visible', true);
	end
	if curStep == 638 then
		setProperty('glitch2.visible', false);
	end
	if curStep == 856 then
		setProperty('glitch2.visible', true);
	end
	if curStep == 857 then
		setProperty('glitch2.visible', false);
	end
	if curStep == 881 then
		setProperty('glitch2.visible', true);
	end
	if curStep == 883 then
		setProperty('glitch3.visible', true);
	end
	if curStep == 884 then
		setProperty('glitch1.visible', true);
		setProperty('glitch2.visible', false);
	end
	if curStep == 896 then
		cameraFlash('game', '0xFFFFFF', 0.5, true);
		setProperty('menu.visible', false);
		setProperty('darklayer.visible', false);
		setProperty('skyscraper.visible', true);
		cameraShake('camGame', 0.002, 7);
	end
	if curStep == 881 then
		cameraShake('camGame', 0.02, 1);
	end
	if curStep == 960 then
		cameraFlash('game', '0xFFFFFF', 0.2, true)
		setProperty('darklayer.visible', true);
		setProperty('skyscraper.visible', false);
		setProperty('house.visible', true);
	end
	if curStep == 1023 then
		cameraShake('camGame', 0.01, 6);
		cameraShake('hud', 0.005, 6);
	end
	if curStep == 1093 then
		cameraShake('camGame', 0.02, 3);
		cameraShake('hud', 0.01, 3);
	end
	if curStep == 1127 then
		cameraShake('camGame', 0.03, 2.65);
		cameraShake('hud', 0.02, 2.65);
	end
	if curStep == 1024 then
		cameraFlash('game', '0xFFFFFF', 2.2, true)
		setProperty('house.visible', false);
		setProperty('darklayer.visible', false);
		setProperty('glass.visible', true);
		setProperty('whitelayer.visible', true);
	end
	if curStep == 1423 then
		cameraFade('game', '000000', 7 , false);
		cameraFade('hud', '000000', 7 , false);
	end
	if curStep == 1152 then
		cameraFlash('game', '0xFFFFFF', 5, true);
		setProperty('camHUD.visible', true); 
		setProperty('menu.visible', false);
		setProperty('glass.visible', false);
		setProperty('darklayer.visible', true);
	end
end