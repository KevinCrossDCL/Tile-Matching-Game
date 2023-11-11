// File: functions.agc
// Created: 23-01-30

function AddLeadingZeros(string$ as string, noOfZeros as integer)
	local i as integer
	
	for i = 1 to noOfZeros
		if (len(string$) < noOfZeros)
			string$ = "0" + string$
		endif
	next
endfunction string$

function AddThousandsSeperator(number as integer, seperator$ as string)
	local counter as integer
	local formattedNumber$ as string
	local i as integer
	local numberLength as integer
	
	numberLength = len(str(number))
	
	if (numberLength < 4 or (numberLength = 4 and Left(str(number), 1) = "-"))
		formattedNumber$ = str(number)
	else
		counter = 0
		for i = numberLength to 1 step -1
			inc counter
			formattedNumber$ = mid(str(number), i, 1) + formattedNumber$
			if (mod(counter, 3) = 0 and i <> 1) then formattedNumber$ = seperator$ + formattedNumber$
		next
	endif
endfunction formattedNumber$

function CalculateTileSize()
	local sprite as integer
	
	sprite = ZestCreateSprite("position:-9999,-9999;size:" + str(PercentageToVirtualWidth(16)) + ",-1")
	tileSize.x = GetSpriteWidth(sprite)
	tileSize.y = GetSpriteHeight(sprite)
	ZestUpdateSprite(sprite, "size:" + str(PercentageToVirtualWidth(13)) + ",-1")
	trayTileSize.x = GetSpriteWidth(sprite)
	trayTileSize.y = GetSpriteHeight(sprite)
	DeleteSprite(sprite)
endfunction

function CheckIfUnlockedTiles()
	local unlockedMaxTile as integer
	local unlockedMinTile as integer
	local unlockedTiles as integer
	
	if (game[0].level[game[0].selectedTileSet] > game[0].levelLastUnlockedTiles[game[0].selectedTileSet] and game[0].level[game[0].selectedTileSet] <= 370)
		if (game[0].level[game[0].selectedTileSet] < 20)
			if (Mod(game[0].level[game[0].selectedTileSet], 5) = 0)
				unlockedTiles = 1
				unlockedMaxTile = MinInt(21 + (floor(game[0].level[game[0].selectedTileSet] / 5) * 6), 255)
				unlockedMinTile = unlockedMaxTile - 6
				game[0].levelLastUnlockedTiles[game[0].selectedTileSet] = game[0].level[game[0].selectedTileSet]
				game.save("game.json")
				PauseTimer()
				CreateTilesUnlockedWindow(unlockedMinTile, unlockedMaxTile)
				game[0].phase = GAME_PHASE_TILES_UNLOCKED
			endif
		else
			if (Mod(game[0].level[game[0].selectedTileSet], 10) = 0)
				unlockedTiles = 1
				unlockedMaxTile = MinInt(33 + (floor(game[0].level[game[0].selectedTileSet] / 10) * 6), 255)
				unlockedMinTile = unlockedMaxTile - 6
				game[0].levelLastUnlockedTiles[game[0].selectedTileSet] = game[0].level[game[0].selectedTileSet]
				game.save("game.json")
				PauseTimer()
				CreateTilesUnlockedWindow(unlockedMinTile, unlockedMaxTile)
				game[0].phase = GAME_PHASE_TILES_UNLOCKED
			endif
		endif
	endif
endfunction

function ClearTray()
	local i as integer
	
	for i = 1 to tray.length
		tray[i].image = 0
		DeleteSprite(tray[i].sprite)
		DeleteTween(tray[i].tween)
	next
	tray.length = 1
	tilesInTray = 0
endfunction

function ClearRewindHistory()
	rewindHistory.length = -1
endfunction

function CreateAddToolsWindow(toolName as string)
	local buttonY as float
	local height as float
	local i as integer
	local iconImage as integer
	local width as float
	
	windowOpen = "Add " + toolName
	
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tileImages[game[0].selectedTileSet, 255].image))
	next
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	adReward = "Free " + toolName
	addToolsWindow.toolShown = toolName
	
	addToolsWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	
	height = PercentageToVirtualHeight(37)
	if (GetRewardAdLoadedAdMob() = 0) then height = height - PercentageToVirtualHeight(9)
	if (game[0].safeCoins + game[0].levelCoins < 200) then height = height - PercentageToVirtualHeight(9)

	addToolsWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	addToolsWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(addToolsWindow.grid[1])))
	addToolsWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	addToolsWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	addToolsWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(height))
	addToolsWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	addToolsWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	addToolsWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(addToolsWindow.grid[7])))
	addToolsWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(addToolsWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(addToolsWindow.grid[1], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) - GetSpriteWidth(addToolsWindow.grid[1])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) - GetSpriteHeight(addToolsWindow.grid[1])))
	ZestUpdateSprite(addToolsWindow.grid[2], "position:" + str(GetSpriteX(addToolsWindow.grid[5])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) - GetSpriteHeight(addToolsWindow.grid[2])))
	ZestUpdateSprite(addToolsWindow.grid[3], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) + GetSpriteWidth(addToolsWindow.grid[5])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) - GetSpriteHeight(addToolsWindow.grid[3])))
	ZestUpdateSprite(addToolsWindow.grid[4], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) - GetSpriteWidth(addToolsWindow.grid[4])) + "," + str(GetSpriteY(addToolsWindow.grid[5])))
	ZestUpdateSprite(addToolsWindow.grid[6], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) + GetSpriteWidth(addToolsWindow.grid[5])) + "," + str(GetSpriteY(addToolsWindow.grid[5])))
	ZestUpdateSprite(addToolsWindow.grid[7], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) - GetSpriteWidth(addToolsWindow.grid[7])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) + GetSpriteHeight(addToolsWindow.grid[5])))
	ZestUpdateSprite(addToolsWindow.grid[8], "position:" + str(GetSpriteX(addToolsWindow.grid[5])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) + GetSpriteHeight(addToolsWindow.grid[5])))
	ZestUpdateSprite(addToolsWindow.grid[9], "position:" + str(GetSpriteX(addToolsWindow.grid[5]) + GetSpriteWidth(addToolsWindow.grid[5])) + "," + str(GetSpriteY(addToolsWindow.grid[5]) + GetSpriteHeight(addToolsWindow.grid[5])))
	
	addToolsWindow.titleText = ZestCreateText("alignment:center;color:#000000;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(addToolsWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:ADD MORE")
	
	addToolsWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(addToolsWindow.grid[3]) - PercentageToVirtualWidth(7)) + "," + str(GetSpriteY(addToolsWindow.grid[5])) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	if (lower(toolName) = "rewind") then iconImage = rewindIconImage
	if (lower(toolName) = "find") then iconImage = findIconImage
	if (lower(toolName) = "shuffle") then iconImage = shuffleIconImage
	if (lower(toolName) = "freeze") then iconImage = freezeIconImage
	addToolsWindow.toolSprite = ZestCreateSprite("depth:9;image:" + str(iconImage) + ";position:" + str(PercentageToVirtualX(40)) + "," + str(ZestGetTextY(addToolsWindow.titleText) + ZestGetTextHeight(addToolsWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	
	buttonY = GetSpriteY(addToolsWindow.toolSprite) + GetSpriteHeight(addToolsWindow.toolSprite) + PercentageToVirtualHeight(2)
	
	if (GetRewardAdLoadedAdMob() = 1)
		addToolsWindow.watchAdButton = ZestCreateImageButton("depth:9;hoverImage:" + str(watchAdButtonHoverImage) + ";image:" + str(watchAdButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(buttonY))
		SetSpriteSize(zestImageButtonCollection[addToolsWindow.watchAdButton].sprContainer, PercentageToVirtualWidth(50), -1)
		
		addToolsWindow.watchAdToolCount.leftHalfSprite = ZestCreateSprite("depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.watchAdToolCount.centreSprite = ZestCreateSprite("depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.watchAdToolCount.rightHalfSprite = ZestCreateSprite("depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.watchAdToolCount.counterText = ZestCreateText("alignment:center;bold:true;depth:7;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2.5)) + ";text:+1")
		width = ZestGetTextWidth(addToolsWindow.watchAdToolCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(addToolsWindow.watchAdToolCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(addToolsWindow.watchAdToolCount.leftHalfSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.watchAdButton) + ZestGetImageButtonWidth(addToolsWindow.watchAdButton) - PercentageToVirtualWidth(7.5) - (GetSpriteWidth(addToolsWindow.watchAdToolCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(addToolsWindow.watchAdButton) + (ZestGetImageButtonHeight(addToolsWindow.watchAdButton) / 2.0)))
		ZestUpdateSprite(addToolsWindow.watchAdToolCount.centreSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.watchAdButton) + ZestGetImageButtonWidth(addToolsWindow.watchAdButton) - PercentageToVirtualWidth(7.5)) + "," + str(ZestGetImageButtonY(addToolsWindow.watchAdButton) + (ZestGetImageButtonHeight(addToolsWindow.watchAdButton) / 2.0)))
		ZestUpdateSprite(addToolsWindow.watchAdToolCount.rightHalfSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.watchAdButton) + ZestGetImageButtonWidth(addToolsWindow.watchAdButton) - PercentageToVirtualWidth(7.5) + (GetSpriteWidth(addToolsWindow.watchAdToolCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(addToolsWindow.watchAdButton) + (ZestGetImageButtonHeight(addToolsWindow.watchAdButton) / 2.0)))
		ZestPinTextToCentreOfSprite(addToolsWindow.watchAdToolCount.counterText, addToolsWindow.watchAdToolCount.centreSprite, 0, 0)
		buttonY = buttonY + ZestGetImageButtonHeight(addToolsWindow.watchAdButton) + PercentageToVirtualHeight(1)
	endif
	
	if (game[0].safeCoins + game[0].levelCoins >= 200)
		addToolsWindow.buyButton = ZestCreateImageButton("depth:9;hoverImage:" + str(buyButtonHoverImage) + ";image:" + str(buyButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(buttonY))
		SetSpriteSize(zestImageButtonCollection[addToolsWindow.buyButton].sprContainer, PercentageToVirtualWidth(50), -1)
		
		addToolsWindow.buyToolCount.leftHalfSprite = ZestCreateSprite("depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.buyToolCount.centreSprite = ZestCreateSprite("depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.buyToolCount.rightHalfSprite = ZestCreateSprite("depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(3)))
		addToolsWindow.buyToolCount.counterText = ZestCreateText("alignment:center;bold:true;depth:7;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2.5)) + ";text:+2")
		width = ZestGetTextWidth(addToolsWindow.buyToolCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(addToolsWindow.buyToolCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(addToolsWindow.buyToolCount.leftHalfSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.buyButton) + ZestGetImageButtonWidth(addToolsWindow.buyButton) - PercentageToVirtualWidth(7.5)- (GetSpriteWidth(addToolsWindow.buyToolCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(addToolsWindow.buyButton) + (ZestGetImageButtonHeight(addToolsWindow.buyButton) / 2.0)))
		ZestUpdateSprite(addToolsWindow.buyToolCount.centreSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.buyButton) + ZestGetImageButtonWidth(addToolsWindow.buyButton) - PercentageToVirtualWidth(7.5)) + "," + str(ZestGetImageButtonY(addToolsWindow.buyButton) + (ZestGetImageButtonHeight(addToolsWindow.buyButton) / 2.0)))
		ZestUpdateSprite(addToolsWindow.buyToolCount.rightHalfSprite, "color:#000000;position:" + str(ZestGetImageButtonX(addToolsWindow.buyButton) + ZestGetImageButtonWidth(addToolsWindow.buyButton) - PercentageToVirtualWidth(7.5) + (GetSpriteWidth(addToolsWindow.buyToolCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(addToolsWindow.buyButton) + (ZestGetImageButtonHeight(addToolsWindow.buyButton) / 2.0)))
		ZestPinTextToCentreOfSprite(addToolsWindow.buyToolCount.counterText, addToolsWindow.buyToolCount.centreSprite, 0, 0)
	endif
endfunction

function CreateAndShuffleTiles()
	local a as integer
	local b as integer
	local id as integer
	local maxTime as integer
	local minTime as integer

	game[0].timeToComplete = 0
	for a = 0 to tileSet.length
		for b = 1 to 3
			tiles.insert(blankTile)
			id = tiles.length
			tiles[id].sortKey$ = Str(Random(10000, 99999))
			tiles[id].id = id
			tiles[id].sprite = ZestCreateSprite("image:" + str(tileSet[a].image))
			tiles[id].depth = 999
			ZestUpdateSprite(tiles[id].sprite, "depth:" + str(tiles[id].depth))
			tiles[id].image = tileSet[a].image
			if (mod(b, 3) = 0)
				remstart
				if (game[0].level >= 1 and game[0].level <= 5) then game[0].timeToComplete = game[0].timeToComplete + Random(8000 - (game[0].level * 200), 8000 - (game[0].level * 200))
				if (game[0].level >= 6 and game[0].level <= 10) then game[0].timeToComplete = game[0].timeToComplete + Random(7000 - ((game[0].level - 5) * 200), 9000 - ((game[0].level - 5) * 200))
				if (game[0].level >= 11 and game[0].level <= 20) then game[0].timeToComplete = game[0].timeToComplete + Random(6000 - ((game[0].level - 10) * 100), 10000 - ((game[0].level - 10) * 100))
				if (game[0].level >= 21 and game[0].level <= 50) then game[0].timeToComplete = game[0].timeToComplete + Random(5000 - ((game[0].level - 20) * 50), 11000 - ((game[0].level - 20) * 50))
				maxTime = 12000 - (game[0].level - 50)
				if (maxTime <= 6000) then maxTime = 6000
				if (game[0].level >= 51) then game[0].timeToComplete = game[0].timeToComplete + Random(4000, maxTime)
				remend
				maxTime = MinInt(6000 + (10000 * MinFloat(game[0].level[game[0].selectedTileSet] / 300, 1.0)), 9000)
				minTime = MinInt(3000 + (3000 * MinFloat(game[0].level[game[0].selectedTileSet] / 300, 1.0)), 6000)
				
				//game[0].timeToComplete = game[0].timeToComplete + maxTime - (maxTime - minTime) * MinFloat(game[0].level / 300.0, 1.0) - Random(0, floor((maxTime - minTime) * 0.15))
				//game[0].timeToComplete = game[0].timeToComplete + Random(minTime, maxTime) * (1 - MinFloat(game[0].level / 300.0, 1.0)) + Random(0, floor((maxTime - minTime) * 0.15))
				game[0].timeToComplete = game[0].timeToComplete + Random(minTime, maxTime)
			endif
		next
	next
	tiles.sort()
endfunction

function CreateCoinTweens(noOfCoinTweens as integer, x, y)
	local i as integer
	local id as integer
	
	for i = 1 to noOfCoinTweens
		coinTweens.insert(blankTween)
		id = coinTweens.length
		coinTweens[id].sprite = ZestCreateSprite("image:" + str(coinImage) + ";position:-9999,-9999;size:" + str(PercentageToVirtualWidth(6)) + ",-1")
		coinTweens[id].tween = CreateTweenSprite(1)
		SetTweenSpriteXByOffset(coinTweens[id].tween, x, GetSpriteXByOffset(levelScene.levelCoinSprite), TweenEaseIn1())
		SetTweenSpriteYByOffset(coinTweens[id].tween, y, GetSpriteYByOffset(levelScene.levelCoinSprite), TweenEaseIn1())
		PlayTweenSprite(coinTweens[id].tween, coinTweens[id].sprite, 0 + ((i - 1.0) * 0.1))
	next
endfunction

function CreateCompletedLevelWindow()
	local i as integer
	local width as float
	
	windowOpen = "Completed Level"
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	adReward = "Double Coins"

	completedLevelWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	
	completedLevelWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	completedLevelWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(completedLevelWindow.grid[1])))
	completedLevelWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	completedLevelWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(PercentageToVirtualHeight(37)))
	completedLevelWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(PercentageToVirtualHeight(37)))
	completedLevelWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(PercentageToVirtualHeight(37)))
	completedLevelWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	completedLevelWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(completedLevelWindow.grid[7])))
	completedLevelWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(completedLevelWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(completedLevelWindow.grid[1], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) - GetSpriteWidth(completedLevelWindow.grid[1])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) - GetSpriteHeight(completedLevelWindow.grid[1])))
	ZestUpdateSprite(completedLevelWindow.grid[2], "position:" + str(GetSpriteX(completedLevelWindow.grid[5])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) - GetSpriteHeight(completedLevelWindow.grid[2])))
	ZestUpdateSprite(completedLevelWindow.grid[3], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) + GetSpriteWidth(completedLevelWindow.grid[5])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) - GetSpriteHeight(completedLevelWindow.grid[3])))
	ZestUpdateSprite(completedLevelWindow.grid[4], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) - GetSpriteWidth(completedLevelWindow.grid[4])) + "," + str(GetSpriteY(completedLevelWindow.grid[5])))
	ZestUpdateSprite(completedLevelWindow.grid[6], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) + GetSpriteWidth(completedLevelWindow.grid[5])) + "," + str(GetSpriteY(completedLevelWindow.grid[5])))
	ZestUpdateSprite(completedLevelWindow.grid[7], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) - GetSpriteWidth(completedLevelWindow.grid[7])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) + GetSpriteHeight(completedLevelWindow.grid[5])))
	ZestUpdateSprite(completedLevelWindow.grid[8], "position:" + str(GetSpriteX(completedLevelWindow.grid[5])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) + GetSpriteHeight(completedLevelWindow.grid[5])))
	ZestUpdateSprite(completedLevelWindow.grid[9], "position:" + str(GetSpriteX(completedLevelWindow.grid[5]) + GetSpriteWidth(completedLevelWindow.grid[5])) + "," + str(GetSpriteY(completedLevelWindow.grid[5]) + GetSpriteHeight(completedLevelWindow.grid[5])))
	
	completedLevelWindow.titleText = ZestCreateText("alignment:center;color:#000000;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(completedLevelWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:" + str(game[0].levelCoins) + " COINS")
	
	//completedLevelWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(completedLevelWindow.grid[3]) - 7) + "," + str(GetSpriteY(completedLevelWindow.grid[5])) + ";size:7,-1")
	
	completedLevelWindow.coinsSprite = ZestCreateSprite("depth:9;image:" + str(coinsImage) + ";position:" + str(PercentageToVirtualX(40)) + "," + str(ZestGetTextY(completedLevelWindow.titleText) + ZestGetTextHeight(completedLevelWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	
	completedLevelWindow.claimX2Button = ZestCreateImageButton("depth:9;hoverImage:" + str(claimX2ButtonImage) + ";image:" + str(claimX2ButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(GetSpriteY(completedLevelWindow.coinsSprite) + GetSpriteHeight(completedLevelWindow.coinsSprite) + PercentageToVirtualHeight(2)))
	SetSpriteSize(zestImageButtonCollection[completedLevelWindow.claimX2Button].sprContainer, PercentageToVirtualWidth(50), -1)
	
	completedLevelWindow.claimButton = ZestCreateImageButton("depth:9;hoverImage:" + str(claimButtonHoverImage) + ";image:" + str(claimButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(completedLevelWindow.claimX2Button) + ZestGetImageButtonHeight(completedLevelWindow.claimX2Button) + PercentageToVirtualHeight(1)))
	SetSpriteSize(zestImageButtonCollection[completedLevelWindow.claimButton].sprContainer, PercentageToVirtualWidth(50), -1)
endfunction

function CreateHomeScreen()
	homeScreen.backgroundSprite = ZestCreateSprite("depth:1000;image:" + str(backgroundImage[game[0].selectedBackground]) + ";offset:center;position:" + str(PercentageToVirtualWidth(50)) + "," + str(PercentageToVirtualHeight(50)) + ";size:" + str(GetVirtualWidth() / GetDisplayAspect()) + "," + str(GetVirtualHeight() + abs(GetScreenBoundsTop() * 2)))
	homeScreen.safeSprite = ZestCreateSprite("depth:10;image:" + str(hudSafeImage) + ";position:" + str(PercentageToVirtualX(3) - abs(GetScreenBoundsLeft())) + "," + str(PercentageToVirtualY(1.25)) + ";size:" + str(PercentageToVirtualWidth(6)) + ",-1")
	homeScreen.safeCoinsText = ZestCreateText("depth:10;font:" + str(comicReliefFont) + ";position:-9999,-9999;shadow:true;shadowColor:0,0,0,100;shadowOffset:" + str(PercentageToVirtualWidth(0.2)) + "," + str(PercentageToVirtualHeight(0.2)) + ";size:" + str(PercentageToVirtualHeight(2.5)) + ";text:" + AddThousandsSeperator(game[0].safeCoins, ","))
	ZestPinTextToCentreRightOfSprite(homeScreen.safeCoinsText, homeScreen.safeSprite, ZestGetTextWidth(homeScreen.safeCoinsText) + PercentageToVirtualWidth(0.5), 0)
	homeScreen.titleSprite = ZestCreateSprite("depth:20;image:" + str(titleImage) + ";offset:centre;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(13)))
	SetSpriteSize(homeScreen.titleSprite, PercentageToVirtualWidth(60), -1)
	//homeScreen.settingsButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;hoverImage:" + str(settingsButtonHoverImage) + ";image:" + str(settingsButtonImage) + ";position:85,1.5;size:12,-1")
	
	homeScreen.shopButton = ZestCreateImageButton("depth:20;hoverImage:" + str(shopButtonHoverImage) + ";image:" + str(shopButtonImage) + ";position:" + str(PercentageToVirtualX(5) - abs(GetScreenBoundsLeft())) + "," + str(GetSpriteY(homeScreen.titleSprite) + GetSpriteHeight(homeScreen.titleSprite) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(22)) + ",-1")
	
	//homeScreen.crateButton = ZestCreateImageButton("depth:20;hoverImage:" + str(crateButtonHoverImage) + ";image:" + str(crateButtonImage) + ";position:73,22;size:22,-1")
	//homeScreen.calendarButton = ZestCreateImageButton("depth:20;hoverImage:" + str(calendarButtonHoverImage) + ";image:" + str(calendarButtonImage) + ";position:73," + str(ZestGetImageButtonY(homeScreen.crateButton) + ZestGetImageButtonHeight(homeScreen.crateButton) + 1) + ";size:22,-1")
	
	homeScreen.playButton = ZestCreateImageButton("depth:20;hoverImage:" + str(playButtonHoverImage) + ";image:" + str(playButtonImage) + ";offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(75)))
	SetSpriteSize(zestImageButtonCollection[homeScreen.playButton].sprContainer, PercentageToVirtualWidth(70), -1)
	homeScreen.levelText = ZestCreateText("alignment:centre;bold:true;depth:20;font:" + str(comicReliefFont) + ";position:-9999,-9999;shadow:true;shadowColor:0,0,0,100;shadowOffset:" + str(PercentageToVirtualWidth(0.2)) + "," + str(PercentageToVirtualHeight(0.2)) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:Level " + str(game[0].level[game[0].selectedTileSet]))
	ZestUpdateText(homeScreen.levelText, "position:" + str(PercentageToVirtualWidth(50)) + "," + str(ZestGetImageButtonY(homeScreen.playButton) - ZestGetTextHeight(homeScreen.levelText) - PercentageToVirtualHeight(0.5)))
	
	//homeScreen.scoreboardButton = ZestCreateImageButton("depth:20;hoverImage:" + str(scoreboardButtonHoverImage) + ";image:" + str(scoreboardButtonImage) + ";position:" + str(PercentageToVirtualX(31)) + "," + str(ZestGetImageButtonY(homeScreen.playButton) + ZestGetImageButtonHeight(homeScreen.playButton) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(18)) + ",-1")
	//if (GetDeviceBaseName() = "ios")
	//	homeScreen.scoreboardButton = ZestCreateImageButton("depth:20;hoverImage:" + str(scoreboardButtonHoverImage) + ";image:" + str(scoreboardButtonImage) + ";position:" + str(PercentageToVirtualX(41)) + "," + str(ZestGetImageButtonY(homeScreen.playButton) + ZestGetImageButtonHeight(homeScreen.playButton) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(18)) + ",-1")
	//endif
	//homeScreen.statisticsButton = ZestCreateImageButton("depth:20;hoverImage:" + str(statisticsButtonHoverImage) + ";image:" + str(statisticsButtonImage) + ";position:51," + str(ZestGetImageButtonY(homeScreen.playButton) + ZestGetImagebuttonHeight(homeScreen.playButton) + 2) + ";size:18,-1")
	
	homeScreen.bannerAdBackgroundSprite = ZestCreateSprite("color:0,0,0,200;depth:19;position:" + str(GetScreenBoundsLeft()) + "," + str(PercentageToVirtualY(92.5)) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(7.5)))
endfunction

function CreateLevelScene()
	levelScene.backgroundSprite = ZestCreateSprite("depth:1000;image:" + str(backgroundImage[game[0].selectedBackground]) + ";offset:center;position:" + str(PercentageToVirtualWidth(50)) + "," + str(PercentageToVirtualHeight(50)) + ";size:" + str(GetVirtualWidth() / GetDisplayAspect()) + "," + str(GetVirtualHeight() + abs(GetScreenBoundsTop() * 2)))
	levelScene.levelText = ZestCreateText("depth:20;font:" + str(comicReliefFont) + ";position:" + str(PercentageToVirtualX(3) - abs(GetScreenBoundsLeft())) + "," + str(PercentageToVirtualY(0.5)) + ";shadow:true;shadowColor:0,0,0,100;shadowOffset:" + str(PercentageToVirtualWidth(0.2)) + "," + str(PercentageToVirtualHeight(0.2)) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:Level " + str(game[0].level[game[0].selectedTileSet]))
	levelScene.safeSprite = ZestCreateSprite("depth:20;image:" + str(hudSafeImage) + ";position:" + str(PercentageToVirtualX(3) - abs(GetScreenBoundsLeft())) + "," + str(PercentageToVirtualY(3.25)) + ";size:" + str(PercentageToVirtualWidth(6)) + ",-1")
	levelScene.safeCoinsText = ZestCreateText("depth:20;font:" + str(comicReliefFont) + ";position:-9999,-9999;shadow:true;shadowColor:0,0,0,100;shadowOffset:" + str(PercentageToVirtualWidth(0.2)) + "," + str(PercentageToVirtualHeight(0.2)) + ";size:" + str(PercentageToVirtualHeight(2.5)) + ";text:" + str(game[0].safeCoins))
	levelScene.levelCoinSprite = ZestCreateSprite("depth:20;image:" + str(hudCoinImage) + ";position:" + str(PercentageToVirtualX(3) - abs(GetScreenBoundsLeft())) + "," + str(PercentageToVirtualY(6.25)) + ";size:" + str(PercentageToVirtualWidth(6)) + ",-1")
	levelScene.levelCoinsText = ZestCreateText("depth:20;font:" + str(comicReliefFont) + ";position:-9999,-9999;shadow:true;shadowColor:0,0,0,100;shadowOffset:" + str(PercentageToVirtualWidth(0.2)) + "," + str(PercentageToVirtualHeight(0.2)) + ";size:" + str(PercentageToVirtualHeight(2.5)) + ";text:" + str(game[0].levelCoins))
	levelScene.timerBackgroundSprite = ZestCreateSprite("color:#fff4e2;depth:20;image:" + str(timerTrayImage) + ";position:" + str(PercentageToVirtualX(31)) + "," + str(PercentageToVirtualY(3)) + ";size:" + str(PercentageToVirtualWidth(38)) + "," + str(PercentageToVirtualHeight(6.5)))
	levelScene.timerSprite = ZestCreateSprite("alpha:0;depth:19;image:" + str(hudTimerImage) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(4)) + ";size:-1," + str(PercentageToVirtualHeight(3.5)))
	levelScene.timerText = ZestCreateText("alpha:0;depth:19;font:" + str(comicReliefFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(2.5)) + ";size:" + str(PercentageToVirtualHeight(6)) + ";text:99[colon]99")
	levelScene.timerTotalWidth = GetSpriteWidth(levelScene.timerSprite) + PercentageToVirtualWidth(1) + ZestGetTextWidth(levelScene.timerText)
	levelScene.timerFrozenOverlaySprite = ZestCreateSprite("alpha:0;depth:18;image:" + str(timerFrozenOverlayImage) + ";position:" + str(PercentageToVirtualX(31)) + "," + str(PercentageToVirtualY(3)) + ";size:" + str(PercentageToVirtualWidth(38)) + "," + str(PercentageToVirtualHeight(6.5)))
	levelScene.pauseButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;hoverImage:" + str(pauseButtonHoverImage) + ";image:" + str(pauseButtonImage) + ";position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)) + ";size:" + str(PercentageToVirtualWidth(12)) + ",-1")
	levelScene.traySprite = ZestCreateSprite("color:#593f3e;depth:20;image:" + str(trayImage) + ";offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(88)) + ";size:" + str(PercentageToVirtualWidth(93)) + "," + str(trayTileSize.y + PercentageToVirtualHeight(1.8)))
	levelScene.rewindButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;disabledImage:" + str(rewindButtonDisabledImage) + ";enabledImage:" + str(rewindButtonImage) + ";hoverImage:" + str(rewindButtonHoverImage) + ";offset:center;position:" + str(PercentageToVirtualX(20)) + "," + str(GetSpriteY(levelScene.traySprite) - PercentageToVirtualHeight(6.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
	levelScene.rewindButtonCount.leftHalfSprite = ZestCreateSprite("depth:19;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.rewindButtonCount.centreSprite = ZestCreateSprite("depth:19;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.rewindButtonCount.rightHalfSprite = ZestCreateSprite("depth:19;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.rewindButtonCount.counterText = ZestCreateText("alignment:center;depth:18;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].rewindTools))
	levelScene.rewindButtonLoadingAdAnimation = ZestCreateSprite("depth:18;image:" + str(loadingFrame01Image) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2)))
	AddSpriteAnimationFrame(levelScene.rewindButtonLoadingAdAnimation, loadingFrame02Image)
	AddSpriteAnimationFrame(levelScene.rewindButtonLoadingAdAnimation, loadingFrame03Image)
	AddSpriteAnimationFrame(levelScene.rewindButtonLoadingAdAnimation, loadingFrame04Image)
	AddSpriteAnimationFrame(levelScene.rewindButtonLoadingAdAnimation, loadingFrame05Image)
	AddSpriteAnimationFrame(levelScene.rewindButtonLoadingAdAnimation, loadingFrame06Image)
	PlaySprite(levelScene.rewindButtonLoadingAdAnimation, 5)
	levelScene.findButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;disabledImage:" + str(findButtonDisabledImage) + ";enabledImage:" + str(findButtonImage) + ";hoverImage:" + str(findButtonHoverImage) + ";offset:center;position:" + str(PercentageToVirtualX(40)) + "," + str(GetSpriteY(levelScene.traySprite) - PercentageToVirtualHeight(6.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
	levelScene.findButtonCount.leftHalfSprite = ZestCreateSprite("depth:19;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.findButtonCount.centreSprite = ZestCreateSprite("depth:19;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.findButtonCount.rightHalfSprite = ZestCreateSprite("depth:19;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.findButtonCount.counterText = ZestCreateText("alignment:center;depth:18;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].shuffleTools))
	levelScene.findButtonLoadingAdAnimation = ZestCreateSprite("depth:18;image:" + str(loadingFrame01Image) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2)))
	AddSpriteAnimationFrame(levelScene.findButtonLoadingAdAnimation, loadingFrame02Image)
	AddSpriteAnimationFrame(levelScene.findButtonLoadingAdAnimation, loadingFrame03Image)
	AddSpriteAnimationFrame(levelScene.findButtonLoadingAdAnimation, loadingFrame04Image)
	AddSpriteAnimationFrame(levelScene.findButtonLoadingAdAnimation, loadingFrame05Image)
	AddSpriteAnimationFrame(levelScene.findButtonLoadingAdAnimation, loadingFrame06Image)
	PlaySprite(levelScene.findButtonLoadingAdAnimation, 5)
	levelScene.shuffleButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;hoverImage:" + str(shuffleButtonHoverImage) + ";image:" + str(shuffleButtonImage) + ";offset:center;position:" + str(PercentageToVirtualX(60)) + "," + str(GetSpriteY(levelScene.traySprite) - PercentageToVirtualHeight(6.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
	levelScene.shuffleButtonCount.leftHalfSprite = ZestCreateSprite("depth:19;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.shuffleButtonCount.centreSprite = ZestCreateSprite("depth:19;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.shuffleButtonCount.rightHalfSprite = ZestCreateSprite("depth:19;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.shuffleButtonCount.counterText = ZestCreateText("alignment:center;depth:18;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].shuffleTools))
	levelScene.shuffleButtonLoadingAdAnimation = ZestCreateSprite("depth:18;image:" + str(loadingFrame01Image) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2)))
	AddSpriteAnimationFrame(levelScene.shuffleButtonLoadingAdAnimation, loadingFrame02Image)
	AddSpriteAnimationFrame(levelScene.shuffleButtonLoadingAdAnimation, loadingFrame03Image)
	AddSpriteAnimationFrame(levelScene.shuffleButtonLoadingAdAnimation, loadingFrame04Image)
	AddSpriteAnimationFrame(levelScene.shuffleButtonLoadingAdAnimation, loadingFrame05Image)
	AddSpriteAnimationFrame(levelScene.shuffleButtonLoadingAdAnimation, loadingFrame06Image)
	PlaySprite(levelScene.shuffleButtonLoadingAdAnimation, 5)
	levelScene.freezeButton = ZestCreateImageButton("angle:" + str(Random(350, 370)) + ";depth:20;disabledImage:" + str(freezeButtonDisabledImage) + ";enabledImage:" + str(freezeButtonImage) + ";hoverImage:" + str(freezeButtonHoverImage) + ";offset:center;position:" + str(PercentageToVirtualX(80)) + "," + str(GetSpriteY(levelScene.traySprite) - PercentageToVirtualHeight(6.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
	levelScene.freezeButtonCount.leftHalfSprite = ZestCreateSprite("depth:19;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.freezeButtonCount.centreSprite = ZestCreateSprite("depth:19;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.freezeButtonCount.rightHalfSprite = ZestCreateSprite("depth:19;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
	levelScene.freezeButtonCount.counterText = ZestCreateText("alignment:center;depth:18;position:-9999,-9999;size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].freezeTools))
	levelScene.freezeButtonLoadingAdAnimation = ZestCreateSprite("depth:18;image:" + str(loadingFrame01Image) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2)))
	AddSpriteAnimationFrame(levelScene.freezeButtonLoadingAdAnimation, loadingFrame02Image)
	AddSpriteAnimationFrame(levelScene.freezeButtonLoadingAdAnimation, loadingFrame03Image)
	AddSpriteAnimationFrame(levelScene.freezeButtonLoadingAdAnimation, loadingFrame04Image)
	AddSpriteAnimationFrame(levelScene.freezeButtonLoadingAdAnimation, loadingFrame05Image)
	AddSpriteAnimationFrame(levelScene.freezeButtonLoadingAdAnimation, loadingFrame06Image)
	PlaySprite(levelScene.freezeButtonLoadingAdAnimation, 5)
	levelScene.multiplierTraySprite = ZestCreateSprite("color:#593f3e;depth:21;image:" + str(multiplierTrayImage) + ";offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(83)) + ";size:" + str(PercentageToVirtualWidth(55)) + "," + str(PercentageToVirtualHeight(3.5)))
	levelScene.multiplierBarSprite = ZestCreateSprite("color:#1eb100;depth:19;image:" + str(multiplierBarImage) + ";offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(83)) + ";size:" + str(PercentageToVirtualWidth(55)) + "," + str(PercentageToVirtualHeight(3.5)))
	levelScene.multiplierText = ZestCreateText("alignment:center;depth:18;font:" + str(comicReliefBoldFont) + ";size:" + str(PercentageToVirtualHeight(2.5)) + ";text:x1")
	homeScreen.bannerAdBackgroundSprite = ZestCreateSprite("color:0,0,0,200;depth:19;position:" + str(GetScreenBoundsLeft()) + "," + str(PercentageToVirtualY(92.5)) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(7.5)))
endfunction

function CreatePauseWindow()
	local i as integer
	
	windowOpen = "Pause"
	
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tileImages[game[0].selectedTileSet, 255].image))
	next
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	pauseWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	pauseWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	pauseWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(pauseWindow.grid[1])))
	pauseWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	pauseWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(PercentageToVirtualHeight(37)))
	pauseWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(PercentageToVirtualHeight(37)))
	pauseWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(PercentageToVirtualHeight(37)))
	pauseWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	pauseWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(pauseWindow.grid[7])))
	pauseWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(pauseWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(pauseWindow.grid[1], "position:" + str(GetSpriteX(pauseWindow.grid[5]) - GetSpriteWidth(pauseWindow.grid[1])) + "," + str(GetSpriteY(pauseWindow.grid[5]) - GetSpriteHeight(pauseWindow.grid[1])))
	ZestUpdateSprite(pauseWindow.grid[2], "position:" + str(GetSpriteX(pauseWindow.grid[5])) + "," + str(GetSpriteY(pauseWindow.grid[5]) - GetSpriteHeight(pauseWindow.grid[2])))
	ZestUpdateSprite(pauseWindow.grid[3], "position:" + str(GetSpriteX(pauseWindow.grid[5]) + GetSpriteWidth(pauseWindow.grid[5])) + "," + str(GetSpriteY(pauseWindow.grid[5]) - GetSpriteHeight(pauseWindow.grid[3])))
	ZestUpdateSprite(pauseWindow.grid[4], "position:" + str(GetSpriteX(pauseWindow.grid[5]) - GetSpriteWidth(pauseWindow.grid[4])) + "," + str(GetSpriteY(pauseWindow.grid[5])))
	ZestUpdateSprite(pauseWindow.grid[6], "position:" + str(GetSpriteX(pauseWindow.grid[5]) + GetSpriteWidth(pauseWindow.grid[5])) + "," + str(GetSpriteY(pauseWindow.grid[5])))
	ZestUpdateSprite(pauseWindow.grid[7], "position:" + str(GetSpriteX(pauseWindow.grid[5]) - GetSpriteWidth(pauseWindow.grid[7])) + "," + str(GetSpriteY(pauseWindow.grid[5]) + GetSpriteHeight(pauseWindow.grid[5])))
	ZestUpdateSprite(pauseWindow.grid[8], "position:" + str(GetSpriteX(pauseWindow.grid[5])) + "," + str(GetSpriteY(pauseWindow.grid[5]) + GetSpriteHeight(pauseWindow.grid[5])))
	ZestUpdateSprite(pauseWindow.grid[9], "position:" + str(GetSpriteX(pauseWindow.grid[5]) + GetSpriteWidth(pauseWindow.grid[5])) + "," + str(GetSpriteY(pauseWindow.grid[5]) + GetSpriteHeight(pauseWindow.grid[5])))
	
	pauseWindow.titleText = ZestCreateText("alignment:center;color:#000000;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(pauseWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:PAUSED!")
	
	pauseWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(pauseWindow.grid[3]) - PercentageToVirtualWidth(7)) + "," + str(GetSpriteY(pauseWindow.grid[5])) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	if (game[0].sound = 1)
		pauseWindow.soundButton = ZestCreateImageButton("hoverImage:" + str(soundOnButtonHoverImage) + ";image:" + str(soundOnButtonImage) + ";position:" + str(PercentageToVirtualX(28)) + "," + str(ZestGetTextY(pauseWindow.titleText) + ZestGetTextHeight(pauseWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	else
		pauseWindow.soundButton = ZestCreateImageButton("hoverImage:" + str(soundOffButtonHoverImage) + ";image:" + str(soundOffButtonImage) + ";position:" + str(PercentageToVirtualX(28)) + "," + str(ZestGetTextY(pauseWindow.titleText) + ZestGetTextHeight(pauseWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	endif
	if (game[0].vibrate = 1)
		pauseWindow.vibrateButton = ZestCreateImageButton("hoverImage:" + str(vibrateOnButtonHoverImage) + ";image:" + str(vibrateOnButtonImage) + ";position:" + str(PercentageToVirtualX(52)) + "," + str(ZestGetTextY(pauseWindow.titleText) + ZestGetTextHeight(pauseWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	else
		pauseWindow.vibrateButton = ZestCreateImageButton("hoverImage:" + str(vibrateOffButtonHoverImage) + ";image:" + str(vibrateOffButtonImage) + ";position:" + str(PercentageToVirtualX(52)) + "," + str(ZestGetTextY(pauseWindow.titleText) + ZestGetTextHeight(pauseWindow.titleText) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(20)) + ",-1")
	endif
	
	pauseWindow.restartButton = ZestCreateImageButton("hoverImage:" + str(greenRestartButtonHoverImage) + ";image:" + str(greenRestartButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(pauseWindow.soundButton) + ZestGetImageButtonHeight(pauseWindow.soundButton) + PercentageToVirtualHeight(2)))
	SetSpriteSize(zestImageButtonCollection[pauseWindow.restartButton].sprContainer, PercentageToVirtualWidth(50), -1)
	
	pauseWindow.homeButton = ZestCreateImageButton("hoverImage:" + str(homeButtonHoverImage) + ";image:" + str(homeButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(pauseWindow.restartButton) + ZestGetImageButtonHeight(pauseWindow.restartButton) + PercentageToVirtualHeight(1)))
	SetSpriteSize(zestImageButtonCollection[pauseWindow.homeButton].sprContainer, PercentageToVirtualWidth(50), -1)
endfunction

function CreateShopWindow(selectedTab as integer)
	local height as float
	local i as integer
	local tileSet as integer
	local tileSetDifficulty as string
	local tileSetTitle as string
	local width as float
	local x as integer
	local y as integer
	
	windowOpen = "Shop"
	shopWindow.selectedTab = selectedTab
	
	ZestUpdateImageButton(homeScreen.settingsButton, "position:-9999,-9999")
	
	height = PercentageToVirtualHeight(75)
	width = PercentageToVirtualWidth(80)
	shopWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	shopWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	shopWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(width) + "," + str(GetSpriteHeight(shopWindow.grid[1])))
	shopWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	shopWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	shopWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(width) + "," + str(height))
	shopWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	shopWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	shopWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(width) + "," + str(GetSpriteHeight(shopWindow.grid[7])))
	shopWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(shopWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(shopWindow.grid[1], "position:" + str(GetSpriteX(shopWindow.grid[5]) - GetSpriteWidth(shopWindow.grid[1])) + "," + str(GetSpriteY(shopWindow.grid[5]) - GetSpriteHeight(shopWindow.grid[1])))
	ZestUpdateSprite(shopWindow.grid[2], "position:" + str(GetSpriteX(shopWindow.grid[5])) + "," + str(GetSpriteY(shopWindow.grid[5]) - GetSpriteHeight(shopWindow.grid[2])))
	ZestUpdateSprite(shopWindow.grid[3], "position:" + str(GetSpriteX(shopWindow.grid[5]) + GetSpriteWidth(shopWindow.grid[5])) + "," + str(GetSpriteY(shopWindow.grid[5]) - GetSpriteHeight(shopWindow.grid[3])))
	ZestUpdateSprite(shopWindow.grid[4], "position:" + str(GetSpriteX(shopWindow.grid[5]) - GetSpriteWidth(shopWindow.grid[4])) + "," + str(GetSpriteY(shopWindow.grid[5])))
	ZestUpdateSprite(shopWindow.grid[6], "position:" + str(GetSpriteX(shopWindow.grid[5]) + GetSpriteWidth(shopWindow.grid[5])) + "," + str(GetSpriteY(shopWindow.grid[5])))
	ZestUpdateSprite(shopWindow.grid[7], "position:" + str(GetSpriteX(shopWindow.grid[5]) - GetSpriteWidth(shopWindow.grid[7])) + "," + str(GetSpriteY(shopWindow.grid[5]) + GetSpriteHeight(shopWindow.grid[5])))
	ZestUpdateSprite(shopWindow.grid[8], "position:" + str(GetSpriteX(shopWindow.grid[5])) + "," + str(GetSpriteY(shopWindow.grid[5]) + GetSpriteHeight(shopWindow.grid[5])))
	ZestUpdateSprite(shopWindow.grid[9], "position:" + str(GetSpriteX(shopWindow.grid[5]) + GetSpriteWidth(shopWindow.grid[5])) + "," + str(GetSpriteY(shopWindow.grid[5]) + GetSpriteHeight(shopWindow.grid[5])))
	
	if (selectedTab = 0)
		shopWindow.tabs[0] = ZestCreateImageButton("depth:9;image:" + str(toolsTabSelectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1])) + "," + str(GetSpriteY(shopWindow.grid[1])))
	else
		shopWindow.tabs[0] = ZestCreateImageButton("depth:9;image:" + str(toolsTabUnselectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1])) + "," + str(GetSpriteY(shopWindow.grid[1])))
	endif
	SetSpriteSize(zestImageButtonCollection[shopWindow.tabs[0]].sprContainer, PercentageToVirtualWidth(26), -1)
	if (selectedTab = 1)
		shopWindow.tabs[1] = ZestCreateImageButton("depth:9;image:" + str(tileSetsTabSelectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1]) + PercentageToVirtualWidth(26)) + "," + str(GetSpriteY(shopWindow.grid[1])))
	else
		shopWindow.tabs[1] = ZestCreateImageButton("depth:9;image:" + str(tileSetsTabUnselectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1]) + PercentageToVirtualWidth(26)) + "," + str(GetSpriteY(shopWindow.grid[1])))
	endif
	SetSpriteSize(zestImageButtonCollection[shopWindow.tabs[1]].sprContainer, PercentageToVirtualWidth(26), -1)
	if (selectedTab = 2)
		shopWindow.tabs[2] = ZestCreateImageButton("depth:9;image:" + str(backgroundsTabSelectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1]) + PercentageToVirtualWidth(52)) + "," + str(GetSpriteY(shopWindow.grid[1])))
	else
		shopWindow.tabs[2] = ZestCreateImageButton("depth:9;image:" + str(backgroundsTabUnselectedImage) + ";position:" + str(GetSpriteX(shopWindow.grid[1]) + PercentageToVirtualWidth(52)) + "," + str(GetSpriteY(shopWindow.grid[1])))
	endif
	SetSpriteSize(zestImageButtonCollection[shopWindow.tabs[2]].sprContainer, PercentageToVirtualWidth(26), -1)
	if (selectedTab = 0)
		ZestUpdateSprite(shopWindow.grid[1], "color:255,244,226,255")
		shopWindow.tabsRightLine[0] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0]) + ZestGetImageButtonWidth(shopWindow.tabs[0]) - PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[0])))
		shopWindow.tabsLeftShadow[1] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsRightLine[1] = ZestCreateSprite("color:0,0,0,32;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1]) + ZestGetImageButtonWidth(shopWindow.tabs[1]) - PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[1])))
		shopWindow.tabsBottomShadow[1] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1]) + ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[1])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[1] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1]) + ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[1])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
		shopWindow.tabsLeftLine[2] = ZestCreateSprite("color:0,0,0,32;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2])))
		shopWindow.tabsRightLine[2] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2]) + ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2])))
		shopWindow.tabsRightShadow[2] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2]) + ZestGetImageButtonWidth(shopWindow.tabs[2]) - PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsBottomShadow[2] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2]) + ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[2] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2]) + ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
	endif
	if (selectedTab = 1)
		ZestUpdateSprite(shopWindow.grid[1], "color:146,146,146,255")
		shopWindow.tabsRightShadow[0] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0]) + ZestGetImageButtonWidth(shopWindow.tabs[0]) - PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[0]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsBottomShadow[0] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[0])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[0] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[0])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
		shopWindow.tabsLeftLine[1] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[1])))
		shopWindow.tabsRightLine[1] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1]) + ZestGetImageButtonWidth(shopWindow.tabs[1]) - PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[1])))
		shopWindow.tabsLeftShadow[2] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsRightLine[2] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2]) + ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2])))
		shopWindow.tabsRightShadow[2] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2]) + ZestGetImageButtonWidth(shopWindow.tabs[2]) - PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsBottomShadow[2] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2]) + ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[2] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2]) + ZestGetImageButtonHeight(shopWindow.tabs[2]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[2])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
	endif
	if (selectedTab = 2)
		ZestUpdateSprite(shopWindow.grid[1], "color:146,146,146,255")
		shopWindow.tabsBottomShadow[0] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[0])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[0] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[0])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
		shopWindow.tabsRightLine[0] = ZestCreateSprite("color:0,0,0,32;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[0]) + ZestGetImageButtonWidth(shopWindow.tabs[0]) - PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[0])))
		shopWindow.tabsLeftLine[1] = ZestCreateSprite("color:0,0,0,32;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2])))
		shopWindow.tabsBottomShadow[1] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1]) + ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[1])) + "," + str(PercentageToVirtualHeight(0.8) * GetDisplayAspect()))
		shopWindow.tabsBottomLine[1] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1]) + ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.2) * GetDisplayAspect())) + ";size:" + str(ZestGetImageButtonWidth(shopWindow.tabs[1])) + "," + str(PercentageToVirtualHeight(0.2) * GetDisplayAspect()))
		shopWindow.tabsRightShadow[1] = ZestCreateSprite("color:0,0,0,64;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[1]) + ZestGetImageButtonWidth(shopWindow.tabs[1]) - PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[1])) + ";size:" + str(PercentageToVirtualWidth(0.6)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[1]) - (PercentageToVirtualHeight(0.8) * GetDisplayAspect())))
		shopWindow.tabsLeftLine[2] = ZestCreateSprite("color:0,0,0,255;depth:8;position:" + str(ZestGetImageButtonX(shopWindow.tabs[2])) + "," + str(ZestGetImageButtonY(shopWindow.tabs[2])) + ";size:" + str(PercentageToVirtualWidth(0.2)) + "," + str(ZestGetImageButtonHeight(shopWindow.tabs[2])))
	endif
	
	shopWindow.closeButton = ZestCreateImageButton("depth:9;image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(shopWindow.grid[3]) - PercentageToVirtualWidth(5)) + "," + str(GetSpriteY(shopWindow.grid[5]) - PercentageToVirtualHeight(1)) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	// TOOLS
	if (selectedTab = 0)
		shopWindow.rewindIcon = ZestCreateSprite("depth:9;image:" + str(rewindIconImage) + ";position:" + str(GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(3)) + "," + str(ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
		shopWindow.rewindTitle = ZestCreateText("bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.rewindIcon) + GetSpriteWidth(shopWindow.rewindIcon) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.rewindIcon)) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:Rewind Tool")
		shopWindow.rewindDescription = ZestCreateText("color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.rewindIcon) + GetSpriteWidth(shopWindow.rewindIcon) + PercentageToVirtualWidth(3)) + "," + str(ZestGetTextY(shopWindow.rewindTitle) + ZestGetTextHeight(shopWindow.rewindTitle) + PercentageToVirtualHeight(0.25)) + ";size:" + str(PercentageToVirtualHeight(2.2)) + ";text:" + ZestWrapText("Undo and remove the last tile added to the tile tray.", PercentageToVirtualHeight(2.2), PercentageToVirtualWidth(65)))
		shopWindow.rewindOwnedSprite = ZestCreateSprite("depth:9;image:" + str(rewindIconImage) + ";offset:center;position:" + str(PercentageToVirtualX(20)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(4.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
		shopWindow.rewindOwnedCount.leftHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.rewindOwnedCount.centreSprite = ZestCreateSprite("color:#000000;depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.rewindOwnedCount.rightHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.rewindOwnedCount.counterText = ZestCreateText("alignment:center;depth:8;position:-9999,-9999;size:2;text:" + str(game[0].rewindTools))
		shopWindow.rewindBuyFreeButton = ZestCreateImageButton("depth:9;disabledImage:" + str(shopFreeX1ButtonHoverImage) + ";hoverImage:" + str(shopFreeX1ButtonHoverImage) + ";image:" + str(shopFreeX1ButtonImage) + ";position:" + str(ZestGetTextX(shopWindow.rewindTitle)) + "," + str(GetSpriteY(shopWindow.rewindIcon) + GetSpriteHeight(shopWindow.rewindIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.rewindBuyFreeButton].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.rewindBuy2Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop200X2ButtonHoverImage) + ";hoverImage:" + str(shop200X2ButtonHoverImage) + ";image:" + str(shop200X2ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.rewindBuyFreeButton) + ZestGetImageButtonWidth(shopWindow.rewindBuyFreeButton) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.rewindIcon) + GetSpriteHeight(shopWindow.rewindIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.rewindBuy2Button].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.rewindBuy5Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop400X5ButtonHoverImage) + ";hoverImage:" + str(shop400X5ButtonHoverImage) + ";image:" + str(shop400X5ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.rewindBuy2Button) + ZestGetImageButtonWidth(shopWindow.rewindBuy2Button) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.rewindIcon) + GetSpriteHeight(shopWindow.rewindIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.rewindBuy5Button].sprContainer, PercentageToVirtualWidth(20), -1)
	
		shopWindow.findIcon = ZestCreateSprite("depth:9;image:" + str(findIconImage) + ";position:" + str(GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.rewindIcon) + GetSpriteHeight(shopWindow.rewindIcon) + PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
		shopWindow.findTitle = ZestCreateText("bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.findIcon) + GetSpriteWidth(shopWindow.findIcon) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.findIcon)) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:Find Tool")
		shopWindow.findDescription = ZestCreateText("color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.findIcon) + GetSpriteWidth(shopWindow.findIcon) + PercentageToVirtualWidth(3)) + "," + str(ZestGetTextY(shopWindow.findTitle) + ZestGetTextHeight(shopWindow.findTitle) + 0.25) + ";size:" + str(PercentageToVirtualHeight(2.2)) + ";text:" + ZestWrapText("Automatically find up to 3 of the same tiles to complete a match.", PercentageToVirtualHeight(2.2), PercentageToVirtualWidth(65)))
		shopWindow.findOwnedSprite = ZestCreateSprite("depth:9;image:" + str(findIconImage) + ";offset:center;position:" + str(PercentageToVirtualX(40)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(4.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
		shopWindow.findOwnedCount.leftHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.findOwnedCount.centreSprite = ZestCreateSprite("color:#000000;depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.findOwnedCount.rightHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.findOwnedCount.counterText = ZestCreateText("alignment:center;depth:8;position:-9999,-9999;size:2;text:" + str(game[0].shuffleTools))
		shopWindow.findBuyFreeButton = ZestCreateImageButton("depth:9;disabledImage:" + str(shopFreeX1ButtonHoverImage) + ";hoverImage:" + str(shopFreeX1ButtonHoverImage) + ";image:" + str(shopFreeX1ButtonImage) + ";position:" + str(ZestGetTextX(shopWindow.findTitle)) + "," + str(GetSpriteY(shopWindow.findIcon) + GetSpriteHeight(shopWindow.findIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.findBuyFreeButton].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.findBuy2Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop200X2ButtonHoverImage) + ";hoverImage:" + str(shop200X2ButtonHoverImage) + ";image:" + str(shop200X2ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.findBuyFreeButton) + ZestGetImageButtonWidth(shopWindow.findBuyFreeButton) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.findIcon) + GetSpriteHeight(shopWindow.findIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.findBuy2Button].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.findBuy5Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop400X5ButtonHoverImage) + ";hoverImage:" + str(shop400X5ButtonHoverImage) + ";image:" + str(shop400X5ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.findBuy2Button) + ZestGetImageButtonWidth(shopWindow.findBuy2Button) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.findIcon) + GetSpriteHeight(shopWindow.findIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.findBuy5Button].sprContainer, PercentageToVirtualWidth(20), -1)
	
		shopWindow.shuffleIcon = ZestCreateSprite("depth:9;image:" + str(shuffleIconImage) + ";position:" + str(GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.findIcon) + GetSpriteHeight(shopWindow.findIcon) + PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
		shopWindow.shuffleTitle = ZestCreateText("bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.shuffleIcon) + GetSpriteWidth(shopWindow.shuffleIcon) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.shuffleIcon)) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:Shuffle Tool")
		shopWindow.shuffleDescription = ZestCreateText("color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.shuffleIcon) + GetSpriteWidth(shopWindow.shuffleIcon) + PercentageToVirtualWidth(3)) + "," + str(ZestGetTextY(shopWindow.shuffleTitle) + ZestGetTextHeight(shopWindow.shuffleTitle) + 0.25) + ";size:" + str(PercentageToVirtualHeight(2.2)) + ";text:" + ZestWrapText("Shuffle the tiles in play.", PercentageToVirtualHeight(2.2), PercentageToVirtualWidth(65)))
		shopWindow.shuffleOwnedSprite = ZestCreateSprite("depth:9;image:" + str(shuffleIconImage) + ";offset:center;position:" + str(PercentageToVirtualX(60)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(4.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
		shopWindow.shuffleOwnedCount.leftHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.shuffleOwnedCount.centreSprite = ZestCreateSprite("color:#000000;depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.shuffleOwnedCount.rightHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.shuffleOwnedCount.counterText = ZestCreateText("alignment:center;depth:8;position:-9999,-9999;size:2;text:" + str(game[0].shuffleTools))
		shopWindow.shuffleBuyFreeButton = ZestCreateImageButton("depth:9;disabledImage:" + str(shopFreeX1ButtonHoverImage) + ";hoverImage:" + str(shopFreeX1ButtonHoverImage) + ";image:" + str(shopFreeX1ButtonImage) + ";position:" + str(ZestGetTextX(shopWindow.shuffleTitle)) + "," + str(GetSpriteY(shopWindow.shuffleIcon) + GetSpriteHeight(shopWindow.shuffleIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.shuffleBuyFreeButton].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.shuffleBuy2Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop200X2ButtonHoverImage) + ";hoverImage:" + str(shop200X2ButtonHoverImage) + ";image:" + str(shop200X2ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.shuffleBuyFreeButton) + ZestGetImageButtonWidth(shopWindow.shuffleBuyFreeButton) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.shuffleIcon) + GetSpriteHeight(shopWindow.shuffleIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.shuffleBuy2Button].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.shuffleBuy5Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop400X5ButtonHoverImage) + ";hoverImage:" + str(shop400X5ButtonHoverImage) + ";image:" + str(shop400X5ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.shuffleBuy2Button) + ZestGetImageButtonWidth(shopWindow.shuffleBuy2Button) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.shuffleIcon) + GetSpriteHeight(shopWindow.shuffleIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.shuffleBuy5Button].sprContainer, PercentageToVirtualWidth(20), -1)
	
		shopWindow.freezeIcon = ZestCreateSprite("depth:9;image:" + str(freezeIconImage) + ";position:" + str(GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.shuffleIcon) + GetSpriteHeight(shopWindow.shuffleIcon) + PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
		shopWindow.freezeTitle = ZestCreateText("bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.freezeIcon) + GetSpriteWidth(shopWindow.freezeIcon) + PercentageToVirtualWidth(3)) + "," + str(GetSpriteY(shopWindow.freezeIcon)) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:Freeze Tool")
		shopWindow.freezeDescription = ZestCreateText("color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(GetSpriteX(shopWindow.freezeIcon) + GetSpriteWidth(shopWindow.freezeIcon) + PercentageToVirtualWidth(3)) + "," + str(ZestGetTextY(shopWindow.freezeTitle) + ZestGetTextHeight(shopWindow.freezeTitle) + 0.25) + ";size:" + str(PercentageToVirtualHeight(2.2)) + ";text:" + ZestWrapText("Freeze time for 15 seconds.", PercentageToVirtualHeight(2.2), PercentageToVirtualWidth(65)))
		shopWindow.freezeOwnedSprite = ZestCreateSprite("depth:9;image:" + str(freezeIconImage) + ";offset:center;position:" + str(PercentageToVirtualX(80)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(4.5)) + ";size:" + str(PercentageToVirtualWidth(15)) + ",-1")
		shopWindow.freezeOwnedCount.leftHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(leftHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.freezeOwnedCount.centreSprite = ZestCreateSprite("color:#000000;depth:8;offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.freezeOwnedCount.rightHalfSprite = ZestCreateSprite("color:#000000;depth:8;image:" + str(rightHalfCircleImage) + ";offset:center;position:-9999,-9999;size:-1," + str(PercentageToVirtualHeight(2.5)))
		shopWindow.freezeOwnedCount.counterText = ZestCreateText("alignment:center;depth:8;position:-9999,-9999;size:2;text:" + str(game[0].freezeTools))
		shopWindow.freezeBuyFreeButton = ZestCreateImageButton("depth:9;disabledImage:" + str(shopFreeX1ButtonHoverImage) + ";hoverImage:" + str(shopFreeX1ButtonHoverImage) + ";image:" + str(shopFreeX1ButtonImage) + ";position:" + str(ZestGetTextX(shopWindow.freezeTitle)) + "," + str(GetSpriteY(shopWindow.freezeIcon) + GetSpriteHeight(shopWindow.freezeIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.freezeBuyFreeButton].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.freezeBuy2Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop200X2ButtonHoverImage) + ";hoverImage:" + str(shop200X2ButtonHoverImage) + ";image:" + str(shop200X2ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.freezeBuyFreeButton) + ZestGetImageButtonWidth(shopWindow.freezeBuyFreeButton) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.freezeIcon) + GetSpriteHeight(shopWindow.freezeIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.freezeBuy2Button].sprContainer, PercentageToVirtualWidth(20), -1)
		shopWindow.freezeBuy5Button = ZestCreateImageButton("depth:9;disabledImage:" + str(shop400X5ButtonHoverImage) + ";hoverImage:" + str(shop400X5ButtonHoverImage) + ";image:" + str(shop400X5ButtonImage) + ";position:" + str(ZestGetImageButtonX(shopWindow.freezeBuy2Button) + ZestGetImageButtonWidth(shopWindow.freezeBuy2Button) + PercentageToVirtualWidth(1.5)) + "," + str(GetSpriteY(shopWindow.freezeIcon) + GetSpriteHeight(shopWindow.freezeIcon) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[shopWindow.freezeBuy5Button].sprContainer, PercentageToVirtualWidth(20), -1)
	endif
	
	// TILE SETS
	if (selectedTab = 1)
		shopWindow.pageNumber = 1
		for i = 1 to 2
			tileSet = ((shopWindow.pageNumber - 1) * 2) + i
			if (tileSet = 1)
				tileSetTitle = "Original Tiles"
				tileSetDifficulty = "Normal"
			endif
			if (tileSet = 2)
				tileSetTitle = "Priceless AI Art"
				tileSetDifficulty = "Hard"
			endif
			if (i = 1)
				x = PercentageToVirtualX(50)
				y = ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) + PercentageToVirtualHeight(2)
			elseif (i = 2)
				x = PercentageToVirtualX(50)
				y = ZestGetImageButtonY(shopWindow.tileSetBuyButton[1]) + ZestGetImageButtonHeight(shopWindow.tileSetBuyButton[1]) + PercentageToVirtualHeight(4)
			endif
			shopWindow.tileSetTitle[i] = ZestCreateText("alignment:center;bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(x) + "," + str(y) + ";size:" + str(PercentageToVirtualHeight(3)) + ";text:" + tileSetTitle)
			shopWindow.tileSetSprite[i] = ZestCreateSprite("depth:9;image:" + str(shopTileSetImage[tileSet]) + ";offset:topCentre;position:" + str(x) + "," + str(ZestGetTextY(shopWindow.tileSetTitle[i]) + ZestGetTextHeight(shopWindow.tileSetTitle[i]) + PercentageToVirtualHeight(2)) + ";size:" + str(PercentageToVirtualWidth(50)) + ",-1")
			SetSpriteSize(shopWindow.tileSetSprite[i], PercentageToVirtualWidth(50), -1)
			shopWindow.tileSetDifficulty[i] = ZestCreateText("alignment:center;bold:true;color:#000000;depth:9;font:" + str(comicReliefFont) + ";position:" + str(x) + "," + str(GetSpriteY(shopWindow.tileSetSprite[i]) + GetSpriteHeight(shopWindow.tileSetSprite[i]) + PercentageToVirtualHeight(1)) + ";size:" + str(PercentageToVirtualHeight(2.2)) + ";text:Difficulty[colon] " + tileSetDifficulty)
			if (game[0].selectedTileSet = tileSet)
				shopWindow.tileSetBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(selectedButtonHoverImage) + ";hoverImage:" + str(selectedButtonHoverImage) + ";image:" + str(selectedButtonImage))
			elseif (game[0].tileSetsUnlocked[tileSet] = 1)
				shopWindow.tileSetBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(selectButtonHoverImage) + ";hoverImage:" + str(selectButtonHoverImage) + ";image:" + str(selectButtonImage))
			else
				shopWindow.tileSetBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(shop1500ButtonHoverImage) + ";hoverImage:" + str(shop1500ButtonHoverImage) + ";image:" + str(shop1500ButtonImage))
			endif
			SetSpriteSize(zestImageButtonCollection[shopWindow.tileSetBuyButton[i]].sprContainer, PercentageToVirtualWidth(30), -1)
			ZestUpdateImageButton(shopWindow.tileSetBuyButton[i], "offset:topCenter;position:" + str(x) + "," + str(ZestGetTextY(shopWindow.tileSetDifficulty[i]) + ZestGetTextHeight(shopWindow.tileSetDifficulty[i]) + PercentageToVirtualHeight(1)))
		next
	endif
	
	// BACKGROUNDS
	if (selectedTab = 2)
		shopWindow.pageNumber = 1
		for i = 1 to 4
			if (i = 1)
				x = GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(10)
				y = ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) + PercentageToVirtualHeight(3)
			elseif (i = 2)
				x = GetSpriteX(shopWindow.grid[6]) + GetSpriteWidth(shopWindow.grid[6]) - PercentageToVirtualWidth(40)
				y = ZestGetImageButtonY(shopWindow.tabs[0]) + ZestGetImageButtonHeight(shopWindow.tabs[0]) + PercentageToVirtualHeight(3)
			elseif (i = 3)
				x = GetSpriteX(shopWindow.grid[4]) + PercentageToVirtualWidth(10)
				y = ZestGetImageButtonY(shopWindow.backgroundBuyButton[1]) + ZestGetImageButtonHeight(shopWindow.backgroundBuyButton[1]) + PercentageToVirtualHeight(4)
			elseif (i = 4)
				x = GetSpriteX(shopWindow.grid[6]) + GetSpriteWidth(shopWindow.grid[6]) - PercentageToVirtualWidth(40)
				y = ZestGetImageButtonY(shopWindow.backgroundBuyButton[2]) + ZestGetImageButtonHeight(shopWindow.backgroundBuyButton[2]) + PercentageToVirtualHeight(4)
			endif
			shopWindow.backgroundBorder[i] = ZestCreateSprite("color:0,0,0,255;depth:9;position:" + str(x) + "," + str(y))
			shopWindow.background[i] = ZestCreateSprite("depth:8;image:" + str(backgroundImage[((shopWindow.pageNumber - 1) * 4) + i]))
			SetSpriteSize(shopWindow.background[i], PercentageToVirtualWidth(29), -1)
			SetSpriteSize(shopWindow.backgroundBorder[i], PercentageToVirtualWidth(30), GetSpriteHeight(shopWindow.background[i]) + PercentageToVirtualWidth(1) * GetDisplayAspect())
			ZestPinSpriteToTopLeftOfSprite(shopWindow.background[i], shopWindow.backgroundBorder[i], PercentageToVirtualWidth(0.5), PercentageToVirtualWidth(0.5) * GetDisplayAspect())
			if (game[0].selectedBackground = ((shopWindow.pageNumber - 1) * 4) + i)
				shopWindow.backgroundBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(selectedButtonHoverImage) + ";hoverImage:" + str(selectedButtonHoverImage) + ";image:" + str(selectedButtonImage))
			elseif (game[0].backgroundsUnlocked[((shopWindow.pageNumber - 1) * 4) + i] = 1)
				shopWindow.backgroundBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(selectButtonHoverImage) + ";hoverImage:" + str(selectButtonHoverImage) + ";image:" + str(selectButtonImage))
			else
				shopWindow.backgroundBuyButton[i] = ZestCreateImageButton("depth:7;disabledImage:" + str(shop500ButtonHoverImage) + ";hoverImage:" + str(shop500ButtonHoverImage) + ";image:" + str(shop500ButtonImage))
			endif
			SetSpriteSize(zestImageButtonCollection[shopWindow.backgroundBuyButton[i]].sprContainer, PercentageToVirtualWidth(30), -1)
			ZestUpdateImageButton(shopWindow.backgroundBuyButton[i], "position:" + str(x) + "," + str(GetSpriteY(shopWindow.background[i]) + GetSpriteHeight(shopWindow.background[i]) + PercentageToVirtualHeight(1)))
		next
		shopWindow.pageTitle = ZestCreateText("alignment:center;color:0,0,0,255;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(7)) + ";size:" + str(PercentageToVirtualHeight(2.5)) + ";text:PAGES")
		shopWindow.pageButtonText[1] = ZestCreateText("alignment:center;color:0,0,255,255;depth:6;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(40)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualHeight(5)) + ";text:1")
		shopWindow.pageButtonText[2] = ZestCreateText("alignment:center;color:0,0,255,255;depth:6;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualHeight(5)) + ";text:2")
		shopWindow.pageButtonText[3] = ZestCreateText("alignment:center;color:0,0,255,255;depth:6;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(60)) + "," + str(GetSpriteY(shopWindow.grid[8]) - PercentageToVirtualHeight(5)) + ";size:" + str(PercentageToVirtualHeight(5)) + ";text:3")
		shopWindow.pageButton[1] = ZestCreateImageButton("depth:7;hoverImage:" + str(shopPageButtonHoverImage) + ";image:" + str(shopPageButtonImage) + ";offset:centre;position:" + str(PercentageToVirtualX(40)) + "," + str(GetTextY(zestTextCollection[shopWindow.pageButtonText[1]].text) + (GetTextTotalHeight(zestTextCollection[shopWindow.pageButtonText[1]].text) / 2.0) + PercentageToVirtualHeight(0.25)) + ";size:-1," + str(PercentageToVirtualHeight(4.5)))
		shopWindow.pageButton[2] = ZestCreateImageButton("depth:7;hoverImage:" + str(shopPageButtonHoverImage) + ";image:" + str(shopPageButtonImage) + ";offset:centre;position:" + str(PercentageToVirtualX(50)) + "," + str(GetTextY(zestTextCollection[shopWindow.pageButtonText[2]].text) + (GetTextTotalHeight(zestTextCollection[shopWindow.pageButtonText[2]].text) / 2.0) + PercentageToVirtualHeight(0.25)) + ";size:-1," + str(PercentageToVirtualHeight(4.5)))
		shopWindow.pageButton[3] = ZestCreateImageButton("depth:7;hoverImage:" + str(shopPageButtonHoverImage) + ";image:" + str(shopPageButtonImage) + ";offset:centre;position:" + str(PercentageToVirtualX(60)) + "," + str(GetTextY(zestTextCollection[shopWindow.pageButtonText[3]].text) + (GetTextTotalHeight(zestTextCollection[shopWindow.pageButtonText[3]].text) / 2.0) + PercentageToVirtualHeight(0.25)) + ";size:-1," + str(PercentageToVirtualHeight(4.5)))
	endif
		
	UpdateShopWindow()
endfunction

function CreateTileSet()
	local i as integer
	local maxSets as integer
	local minSets as integer
	local sets as integer
	
	if (game[0].level[game[0].selectedTileSet] = 1) then sets = 5
	if (game[0].level[game[0].selectedTileSet] = 2) then sets = 10
	if (game[0].level[game[0].selectedTileSet] = 3) then sets = 15
	if (game[0].level[game[0].selectedTileSet] = 4) then sets = 20
	remstart
	if (game[0].level = 5) then sets = Random(20, 30)
	if (game[0].level >= 6 and game[0].level <= 10) then sets = Random(30, 40)
	if (game[0].level >= 11 and game[0].level <= 20) then sets = Random(35, 45)
	if (game[0].level >= 21 and game[0].level <= 50) then sets = Random(40, 50)
	if (game[0].level >= 51 and game[0].level <= 100) then sets = Random(45, 60)
	if (game[0].level >= 101) then sets = Random(50, 65)
	remend
	minSets = 20
	maxSets = 70
	if (game[0].level[game[0].selectedTileSet] >= 5) then sets = floor(minSets + (maxSets - minSets) * MinFloat(game[0].level[game[0].selectedTileSet] / 300.0, 1.0) + random(0, 5))
	game[0].levelSets = sets
	
	tileSet.length = -1
	for i = 0 to sets - 1
		tileSet.insert(blankTileSet)
		tileSet[i].sortKey$ = Str(Random(10000, 99999))
		tileSet[i].id = i
		tileSetsChosen = Random(0, tileSetsList.length - 1)
		tileSet[i].image = tileImages[game[0].selectedTileSet, tileSetsList[tileSetsChosen]].image
		tileSetsList.remove(tileSetsChosen)
	next
	tileSet.sort()
endfunction

function CreateTileSetsList()
	local a as integer
	local b as integer
	local multiplier as integer
	
	filteredTileImages = tileImages[game[0].selectedTileSet]
	//filteredTileImages.length = MinInt(floor(40 + (256 - 40) * (game[0].level / 1000.0)), 256)
	if (game[0].level[game[0].selectedTileSet] < 20)
		filteredTileImages.length = MinInt(21 + (floor(game[0].level[game[0].selectedTileSet] / 5) * 6), 255)
	else
		filteredTileImages.length = MinInt(33 + (floor(game[0].level[game[0].selectedTileSet] / 10) * 6), 255)
	endif
	
	tileSetsList.length = -1
	for a = 0 to filteredTileImages.length - 1
		if (game[0].level[game[0].selectedTileSet] = 1) then multiplier = 1
		if (game[0].level[game[0].selectedTileSet] >= 2 and game[0].level[game[0].selectedTileSet] <= 5) then multiplier = Random(2, 5)
		if (game[0].level[game[0].selectedTileSet] >= 6 and game[0].level[game[0].selectedTileSet] <= 20) then multiplier = Random(2, 4)
		if (game[0].level[game[0].selectedTileSet] >= 21 and game[0].level[game[0].selectedTileSet] <= 50) then multiplier = Random(2, 3)
		if (game[0].level[game[0].selectedTileSet] >= 51 and game[0].level[game[0].selectedTileSet] <= 100) then multiplier = Random(1, 3)
		if (game[0].level[game[0].selectedTileSet] >= 101) then multiplier = Random(1, 2)
		for b = 1 to multiplier
			tileSetsList.insert(a)
		next
	next
endfunction

function CreateTilesUnlockedWindow(unlockedMinTile as integer, unlockedMaxTile as integer)
	local i as integer
	local height as float
	local tileCounter as integer
	local width as float
	local x as float
	local y as float
	
	windowOpen = "Tiles Unlocked"
	
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tileImages[game[0].selectedTileSet, 255].image))
	next
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	tilesUnlockedWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	
	height = PercentageToVirtualHeight(34.5)
	tilesUnlockedWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	tilesUnlockedWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(tilesUnlockedWindow.grid[1])))
	tilesUnlockedWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	tilesUnlockedWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	tilesUnlockedWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(height))
	tilesUnlockedWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	tilesUnlockedWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	tilesUnlockedWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(tilesUnlockedWindow.grid[7])))
	tilesUnlockedWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(tilesUnlockedWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(tilesUnlockedWindow.grid[1], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) - GetSpriteWidth(tilesUnlockedWindow.grid[1])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) - GetSpriteHeight(tilesUnlockedWindow.grid[1])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[2], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) - GetSpriteHeight(tilesUnlockedWindow.grid[2])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[3], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) + GetSpriteWidth(tilesUnlockedWindow.grid[5])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) - GetSpriteHeight(tilesUnlockedWindow.grid[3])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[4], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) - GetSpriteWidth(tilesUnlockedWindow.grid[4])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[6], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) + GetSpriteWidth(tilesUnlockedWindow.grid[5])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[7], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) - GetSpriteWidth(tilesUnlockedWindow.grid[7])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) + GetSpriteHeight(tilesUnlockedWindow.grid[5])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[8], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) + GetSpriteHeight(tilesUnlockedWindow.grid[5])))
	ZestUpdateSprite(tilesUnlockedWindow.grid[9], "position:" + str(GetSpriteX(tilesUnlockedWindow.grid[5]) + GetSpriteWidth(tilesUnlockedWindow.grid[5])) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5]) + GetSpriteHeight(tilesUnlockedWindow.grid[5])))
	
	tilesUnlockedWindow.titleText = ZestCreateText("alignment:center;color:#000000;depth:9;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:NEW TILES!")
	
	tilesUnlockedWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(tilesUnlockedWindow.grid[3]) - PercentageToVirtualWidth(7)) + "," + str(GetSpriteY(tilesUnlockedWindow.grid[5])) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	x = 20
	y = ZestGetTextY(tilesUnlockedWindow.titleText) + ZestGetTextHeight(tilesUnlockedWindow.titleText) + PercentageToVirtualHeight(2)
	tileCounter = 0
	for i = unlockedMinTile to unlockedMaxTile - 1
		inc tileCounter
		if (tileCounter = 1 or tileCounter = 4) then x = PercentageToVirtualWidth(20)
		if (tileCounter = 2 or tileCounter = 5) then x = PercentageToVirtualWidth(42)
		if (tileCounter = 3 or tileCounter = 6) then x = PercentageToVirtualWidth(64)
		if (tileCounter = 1)
			y = ZestGetTextY(tilesUnlockedWindow.titleText) + ZestGetTextHeight(tilesUnlockedWindow.titleText) + PercentageToVirtualHeight(2)
		elseif (tileCounter = 4)
			y = GetSpriteY(tilesUnlockedWindow.tilesUnlocked[tileCounter - 2]) + GetSpriteHeight(tilesUnlockedWindow.tilesUnlocked[tileCounter - 2]) + PercentageToVirtualHeight(1)
		endif
		tilesUnlockedWindow.tilesUnlocked[tileCounter] = ZestCreateSprite("image:" + str(tileUnlockedImages[game[0].selectedTileSet, i].image) + ";position:" + str(x) + "," + str(y) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
	next
	
	tilesUnlockedWindow.claimButton = ZestCreateImageButton("depth:9;hoverImage:" + str(claimButtonHoverImage) + ";image:" + str(claimButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(GetSpriteY(tilesUnlockedWindow.tilesUnlocked[5]) + GetSpriteHeight(tilesUnlockedWindow.tilesUnlocked[5]) + PercentageToVirtualHeight(2)))
	SetSpriteSize(zestImageButtonCollection[tilesUnlockedWindow.claimButton].sprContainer, PercentageToVirtualWidth(50), -1)
endfunction

function CreateTimesUpWindow()
	local i as integer
	local height as float
	local width as float
	
	windowOpen = "Time's Up"
	
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tileImages[game[0].selectedTileSet, 255].image))
	next
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	adReward = "Add Time"

	timesUpWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	
	if (game[0].safeCoins + game[0].levelCoins >= 200)
		height = PercentageToVirtualHeight(48.5)
	else
		height = PercentageToVirtualHeight(39.5)
	endif
	timesUpWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	timesUpWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(timesUpWindow.grid[1])))
	timesUpWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	timesUpWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	timesUpWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(height))
	timesUpWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	timesUpWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	timesUpWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(timesUpWindow.grid[7])))
	timesUpWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(timesUpWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(timesUpWindow.grid[1], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) - GetSpriteWidth(timesUpWindow.grid[1])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) - GetSpriteHeight(timesUpWindow.grid[1])))
	ZestUpdateSprite(timesUpWindow.grid[2], "position:" + str(GetSpriteX(timesUpWindow.grid[5])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) - GetSpriteHeight(timesUpWindow.grid[2])))
	ZestUpdateSprite(timesUpWindow.grid[3], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) + GetSpriteWidth(timesUpWindow.grid[5])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) - GetSpriteHeight(timesUpWindow.grid[3])))
	ZestUpdateSprite(timesUpWindow.grid[4], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) - GetSpriteWidth(timesUpWindow.grid[4])) + "," + str(GetSpriteY(timesUpWindow.grid[5])))
	ZestUpdateSprite(timesUpWindow.grid[6], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) + GetSpriteWidth(timesUpWindow.grid[5])) + "," + str(GetSpriteY(timesUpWindow.grid[5])))
	ZestUpdateSprite(timesUpWindow.grid[7], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) - GetSpriteWidth(timesUpWindow.grid[7])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) + GetSpriteHeight(timesUpWindow.grid[5])))
	ZestUpdateSprite(timesUpWindow.grid[8], "position:" + str(GetSpriteX(timesUpWindow.grid[5])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) + GetSpriteHeight(timesUpWindow.grid[5])))
	ZestUpdateSprite(timesUpWindow.grid[9], "position:" + str(GetSpriteX(timesUpWindow.grid[5]) + GetSpriteWidth(timesUpWindow.grid[5])) + "," + str(GetSpriteY(timesUpWindow.grid[5]) + GetSpriteHeight(timesUpWindow.grid[5])))
	
	timesUpWindow.titleText = ZestCreateText("alignment:center;color:#000000;depth:9;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(timesUpWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:TIME'S UP!")
	
	timesUpWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(timesUpWindow.grid[3]) - PercentageToVirtualWidth(7)) + "," + str(GetSpriteY(timesUpWindow.grid[5])) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	timesUpWindow.bodyText = ZestCreateText("alignment:center;color:#000000;depth:9;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(ZestGetTextY(timesUpWindow.titleText) + ZestGetTextHeight(timesUpWindow.titleText) + 2) + ";size:" + str(PercentageToVirtualHeight(6)) + ";text:ADD" + chr(10) + "60 SECONDS?")
	
	timesUpWindow.watchAdButton = ZestCreateImageButton("depth:9;hoverImage:" + str(watchAdButtonHoverImage) + ";image:" + str(watchAdButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetTextY(timesUpWindow.bodyText) + ZestGetTextHeight(timesUpWindow.bodyText) + PercentageToVirtualHeight(2)))
	SetSpriteSize(zestImageButtonCollection[timesUpWindow.watchAdButton].sprContainer, PercentageToVirtualWidth(50), -1)

	if (game[0].safeCoins + game[0].levelCoins >= 200)
		timesUpWindow.buyButton = ZestCreateImageButton("depth:9;hoverImage:" + str(buyButtonHoverImage) + ";image:" + str(buyButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(timesUpWindow.watchAdButton) + ZestGetImageButtonHeight(timesUpWindow.watchAdButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[timesUpWindow.buyButton].sprContainer, PercentageToVirtualWidth(50), -1)
	
		timesUpWindow.restartButton = ZestCreateImageButton("hoverImage:" + str(orangeRestartButtonHoverImage) + ";image:" + str(orangeRestartButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(timesUpWindow.buyButton) + ZestGetImageButtonHeight(timesUpWindow.buyButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[timesUpWindow.restartButton].sprContainer, PercentageToVirtualWidth(50), -1)
	else
		timesUpWindow.restartButton = ZestCreateImageButton("hoverImage:" + str(orangeRestartButtonHoverImage) + ";image:" + str(orangeRestartButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(timesUpWindow.watchAdButton) + ZestGetImageButtonHeight(timesUpWindow.watchAdButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[timesUpWindow.restartButton].sprContainer, PercentageToVirtualWidth(50), -1)
	endif
endfunction

function CreateTrayFullWindow()
	local i as integer
	local height as float
	local width as float
	
	windowOpen = "Tray Full"
	
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tileImages[game[0].selectedTileSet, 255].image))
	next
	
	ZestUpdateImageButton(levelScene.pauseButton, "position:-9999,-9999")
	
	adReward = "Clear Tray"

	trayFullWindow.scrimSprite = ZestCreateSprite("color:0,0,0,200;depth:11;position:" + str(GetScreenBoundsLeft()) + "," + str(GetScreenBoundsTop()) + ";size:" + str(PercentageToVirtualWidth(100) + (abs(GetScreenBoundsLeft()) * 2)) + "," + str(PercentageToVirtualHeight(100) + (abs(GetScreenBoundsTop()) * 2)))
	
	if (game[0].safeCoins + game[0].levelCoins >= 200)
		height = PercentageToVirtualHeight(48.5)
	else
		height = PercentageToVirtualHeight(39.5)
	endif
	trayFullWindow.grid[1] = ZestCreateSprite("depth:10;image:" + str(windowTopLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	trayFullWindow.grid[2] = ZestCreateSprite("depth:10;image:" + str(windowTopImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(trayFullWindow.grid[1])))
	trayFullWindow.grid[3] = ZestCreateSprite("depth:10;image:" + str(windowTopRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	trayFullWindow.grid[4] = ZestCreateSprite("depth:10;image:" + str(windowLeftImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	trayFullWindow.grid[5] = ZestCreateSprite("depth:10;image:" + str(windowCentreImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(height))
	trayFullWindow.grid[6] = ZestCreateSprite("depth:10;image:" + str(windowRightImage) + ";size:" + str(PercentageToVirtualWidth(5)) + "," + str(height))
	trayFullWindow.grid[7] = ZestCreateSprite("depth:10;image:" + str(windowBottomLeftCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	trayFullWindow.grid[8] = ZestCreateSprite("depth:10;image:" + str(windowBottomImage) + ";size:" + str(PercentageToVirtualWidth(70)) + "," + str(GetSpriteHeight(trayFullWindow.grid[7])))
	trayFullWindow.grid[9] = ZestCreateSprite("depth:10;image:" + str(windowBottomRightCornerImage) + ";size:" + str(PercentageToVirtualWidth(5)) + ",-1")
	ZestUpdateSprite(trayFullWindow.grid[5], "offset:center;position:" + str(PercentageToVirtualX(50)) + "," + str(PercentageToVirtualY(50)))
	ZestUpdateSprite(trayFullWindow.grid[1], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) - GetSpriteWidth(trayFullWindow.grid[1])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) - GetSpriteHeight(trayFullWindow.grid[1])))
	ZestUpdateSprite(trayFullWindow.grid[2], "position:" + str(GetSpriteX(trayFullWindow.grid[5])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) - GetSpriteHeight(trayFullWindow.grid[2])))
	ZestUpdateSprite(trayFullWindow.grid[3], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) + GetSpriteWidth(trayFullWindow.grid[5])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) - GetSpriteHeight(trayFullWindow.grid[3])))
	ZestUpdateSprite(trayFullWindow.grid[4], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) - GetSpriteWidth(trayFullWindow.grid[4])) + "," + str(GetSpriteY(trayFullWindow.grid[5])))
	ZestUpdateSprite(trayFullWindow.grid[6], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) + GetSpriteWidth(trayFullWindow.grid[5])) + "," + str(GetSpriteY(trayFullWindow.grid[5])))
	ZestUpdateSprite(trayFullWindow.grid[7], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) - GetSpriteWidth(trayFullWindow.grid[7])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) + GetSpriteHeight(trayFullWindow.grid[5])))
	ZestUpdateSprite(trayFullWindow.grid[8], "position:" + str(GetSpriteX(trayFullWindow.grid[5])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) + GetSpriteHeight(trayFullWindow.grid[5])))
	ZestUpdateSprite(trayFullWindow.grid[9], "position:" + str(GetSpriteX(trayFullWindow.grid[5]) + GetSpriteWidth(trayFullWindow.grid[5])) + "," + str(GetSpriteY(trayFullWindow.grid[5]) + GetSpriteHeight(trayFullWindow.grid[5])))
	
	trayFullWindow.titleText = ZestCreateText("alignment:center;color:#000000;depth:9;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(GetSpriteY(trayFullWindow.grid[5])) + ";size:" + str(PercentageToVirtualHeight(4)) + ";text:TILE TRAY FULL!")
	
	trayFullWindow.closeButton = ZestCreateImageButton("image:" + str(windowCloseImage) + ";position:" + str(GetSpriteX(trayFullWindow.grid[3]) - PercentageToVirtualWidth(7)) + "," + str(GetSpriteY(trayFullWindow.grid[5])) + ";size:" + str(PercentageToVirtualWidth(7)) + ",-1")
	
	trayFullWindow.bodyText = ZestCreateText("alignment:center;color:#000000;depth:9;font:" + str(comicReliefBoldFont) + ";position:" + str(PercentageToVirtualX(50)) + "," + str(ZestGetTextY(trayFullWindow.titleText) + ZestGetTextHeight(trayFullWindow.titleText) + 2) + ";size:" + str(PercentageToVirtualHeight(6)) + ";text:CLEAR TILE" + chr(10) + "TRAY?")
	
	trayFullWindow.watchAdButton = ZestCreateImageButton("depth:9;hoverImage:" + str(watchAdButtonHoverImage) + ";image:" + str(watchAdButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetTextY(trayFullWindow.bodyText) + ZestGetTextHeight(trayFullWindow.bodyText) + PercentageToVirtualHeight(2)))
	SetSpriteSize(zestImageButtonCollection[trayFullWindow.watchAdButton].sprContainer, PercentageToVirtualWidth(50), -1)
	
	if (game[0].safeCoins + game[0].levelCoins >= 200)
		trayFullWindow.buyButton = ZestCreateImageButton("depth:9;hoverImage:" + str(buyButtonHoverImage) + ";image:" + str(buyButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(trayFullWindow.watchAdButton) + ZestGetImageButtonHeight(trayFullWindow.watchAdButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[trayFullWindow.buyButton].sprContainer, PercentageToVirtualWidth(50), -1)
	
		trayFullWindow.restartButton = ZestCreateImageButton("hoverImage:" + str(orangeRestartButtonHoverImage) + ";image:" + str(orangeRestartButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(trayFullWindow.buyButton) + ZestGetImageButtonHeight(trayFullWindow.buyButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[trayFullWindow.restartButton].sprContainer, PercentageToVirtualWidth(50), -1)
	else
		trayFullWindow.restartButton = ZestCreateImageButton("hoverImage:" + str(orangeRestartButtonHoverImage) + ";image:" + str(orangeRestartButtonImage) + ";position:" + str(PercentageToVirtualX(25)) + "," + str(ZestGetImageButtonY(trayFullWindow.watchAdButton) + ZestGetImageButtonHeight(trayFullWindow.watchAdButton) + PercentageToVirtualHeight(1)))
		SetSpriteSize(zestImageButtonCollection[trayFullWindow.restartButton].sprContainer, PercentageToVirtualWidth(50), -1)
	endif
endfunction

function DeleteAddToolsWindow()
	local i as integer
	
	if (lower(windowOpen) = "add rewind" or lower(windowOpen) = "add find" or lower(windowOpen) = "add shuffle" or lower(windowOpen) = "add freeze") then windowOpen = ""
		
	DeleteSprite(addToolsWindow.scrimSprite)
	DeleteSprite(addToolsWindow.grid[1])
	DeleteSprite(addToolsWindow.grid[2])
	DeleteSprite(addToolsWindow.grid[3])
	DeleteSprite(addToolsWindow.grid[4])
	DeleteSprite(addToolsWindow.grid[5])
	DeleteSprite(addToolsWindow.grid[6])
	DeleteSprite(addToolsWindow.grid[7])
	DeleteSprite(addToolsWindow.grid[8])
	DeleteSprite(addToolsWindow.grid[9])
	ZestDeleteImageButton(addToolsWindow.closeButton)
	ZestDeleteText(addToolsWindow.titleText)
	DeleteSprite(addToolsWindow.toolSprite)
	ZestDeleteImageButton(addToolsWindow.watchAdButton)
	DeleteSprite(addToolsWindow.watchAdToolCount.leftHalfSprite)
	DeleteSprite(addToolsWindow.watchAdToolCount.centreSprite)
	DeleteSprite(addToolsWindow.watchAdToolCount.rightHalfSprite)
	ZestDeleteText(addToolsWindow.watchAdToolCount.counterText)
	ZestDeleteImageButton(addToolsWindow.buyButton)
	DeleteSprite(addToolsWindow.buyToolCount.leftHalfSprite)
	DeleteSprite(addToolsWindow.buyToolCount.centreSprite)
	DeleteSprite(addToolsWindow.buyToolCount.rightHalfSprite)
	ZestDeleteText(addToolsWindow.buyToolCount.counterText)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tiles[i].image))
	next
endfunction

function DeleteAllTiles()
	local i as integer
		
	for i = 0 to tiles.length
		DeleteSprite(tiles[i].sprite)
		DeleteTween(tiles[i].tween)
	next
	tiles.length = -1
endfunction

function DeleteCoinTweens()
	local i as integer
	
	for i = coinTweens.length to 0 step -1
		if (GetTweenSpritePlaying(coinTweens[i].tween, coinTweens[i].sprite) = 0)
			game[0].levelCoins = game[0].levelCoins + 1
			DeleteSprite(coinTweens[i].sprite)
			DeleteTween(coinTweens[i].tween)
			coinTweens.remove(i)
		endif
	next
endfunction

function DeleteCompletedLevelWindow()
	local i as integer
	
	if (lower(windowOpen) = "completed level") then windowOpen = ""
		
	DeleteSprite(completedLevelWindow.scrimSprite)
	DeleteSprite(completedLevelWindow.grid[1])
	DeleteSprite(completedLevelWindow.grid[2])
	DeleteSprite(completedLevelWindow.grid[3])
	DeleteSprite(completedLevelWindow.grid[4])
	DeleteSprite(completedLevelWindow.grid[5])
	DeleteSprite(completedLevelWindow.grid[6])
	DeleteSprite(completedLevelWindow.grid[7])
	DeleteSprite(completedLevelWindow.grid[8])
	DeleteSprite(completedLevelWindow.grid[9])
	//ZestDeleteImageButton(completedLevelWindow.closeButton)
	ZestDeleteText(completedLevelWindow.titleText)
	DeleteSprite(completedLevelWindow.coinsSprite)
	ZestDeleteImageButton(completedLevelWindow.claimX2Button)
	ZestDeleteImageButton(completedLevelWindow.claimButton)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
endfunction

function DeleteHomeScreen()
	DeleteSprite(homeScreen.backgroundSprite)
	DeleteSprite(homeScreen.bannerAdBackgroundSprite)
	ZestDeleteImageButton(homeScreen.calendarButton)
	ZestDeleteText(homeScreen.levelText)
	ZestDeleteImageButton(homeScreen.playButton)
	DeleteSprite(homeScreen.safeSprite)
	ZestDeleteText(homeScreen.safeCoinsText)
	ZestDeleteImageButton(homeScreen.scoreboardButton)
	ZestDeleteImageButton(homeScreen.crateButton)
	ZestDeleteImageButton(homeScreen.settingsButton)
	ZestDeleteImageButton(homeScreen.shopButton)
	ZestDeleteImageButton(homeScreen.statisticsButton)
	DeleteSprite(homeScreen.titleSprite)
endfunction

function DeleteLevelScene()
	DeleteSprite(levelScene.backgroundSprite)
	ZestDeleteText(levelScene.levelText)
	DeleteSprite(levelScene.safeSprite)
	ZestDeleteText(levelScene.safeCoinsText)
	DeleteSprite(levelScene.levelCoinSprite)
	ZestDeleteText(levelScene.levelCoinsText)
	DeleteSprite(levelScene.timerBackgroundSprite)
	DeleteSprite(levelScene.timerSprite)
	ZestDeleteText(levelScene.timerText)
	DeleteSprite(levelScene.timerFrozenOverlaySprite)
	ZestDeleteImageButton(levelScene.pauseButton)
	DeleteSprite(levelScene.traySprite)
	ZestDeleteImageButton(levelScene.rewindButton)
	DeleteSprite(levelScene.rewindButtonCount.leftHalfSprite)
	DeleteSprite(levelScene.rewindButtonCount.centreSprite)
	DeleteSprite(levelScene.rewindButtonCount.rightHalfSprite)
	ZestDeleteText(levelScene.rewindButtonCount.counterText)
	DeleteSprite(levelScene.rewindButtonLoadingAdAnimation)
	ZestDeleteImageButton(levelScene.findButton)
	DeleteSprite(levelScene.findButtonCount.leftHalfSprite)
	DeleteSprite(levelScene.findButtonCount.centreSprite)
	DeleteSprite(levelScene.findButtonCount.rightHalfSprite)
	ZestDeleteText(levelScene.findButtonCount.counterText)
	DeleteSprite(levelScene.findButtonLoadingAdAnimation)
	ZestDeleteImageButton(levelScene.shuffleButton)
	DeleteSprite(levelScene.shuffleButtonCount.leftHalfSprite)
	DeleteSprite(levelScene.shuffleButtonCount.centreSprite)
	DeleteSprite(levelScene.shuffleButtonCount.rightHalfSprite)
	ZestDeleteText(levelScene.shuffleButtonCount.counterText)
	DeleteSprite(levelScene.shuffleButtonLoadingAdAnimation)
	ZestDeleteImageButton(levelScene.freezeButton)
	DeleteSprite(levelScene.freezeButtonCount.leftHalfSprite)
	DeleteSprite(levelScene.freezeButtonCount.centreSprite)
	DeleteSprite(levelScene.freezeButtonCount.rightHalfSprite)
	ZestDeleteText(levelScene.freezeButtonCount.counterText)
	DeleteSprite(levelScene.freezeButtonLoadingAdAnimation)
	DeleteSprite(levelScene.multiplierTraySprite)
	DeleteSprite(levelScene.multiplierBarSprite)
	ZestDeleteText(levelScene.multiplierText)
	DeleteSprite(levelScene.bannerAdBackgroundSprite)
endfunction

function DeletePauseWindow()
	local i as integer
	
	if (lower(windowOpen) = "pause") then windowOpen = ""
	
	DeleteSprite(pauseWindow.scrimSprite)
	DeleteSprite(pauseWindow.grid[1])
	DeleteSprite(pauseWindow.grid[2])
	DeleteSprite(pauseWindow.grid[3])
	DeleteSprite(pauseWindow.grid[4])
	DeleteSprite(pauseWindow.grid[5])
	DeleteSprite(pauseWindow.grid[6])
	DeleteSprite(pauseWindow.grid[7])
	DeleteSprite(pauseWindow.grid[8])
	DeleteSprite(pauseWindow.grid[9])
	ZestDeleteImageButton(pauseWindow.closeButton)
	ZestDeleteText(pauseWindow.titleText)
	ZestDeleteImageButton(pauseWindow.soundButton)
	ZestDeleteImageButton(pauseWindow.vibrateButton)
	ZestDeleteImageButton(pauseWindow.restartButton)
	ZestDeleteImageButton(pauseWindow.homeButton)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tiles[i].image))
	next
endfunction

function DeleteShopWindow()
	local i as integer
	
	if (lower(windowOpen) = "shop") then windowOpen = ""
	
	DeleteSprite(shopWindow.scrimSprite)
	DeleteSprite(shopWindow.grid[1])
	DeleteSprite(shopWindow.grid[2])
	DeleteSprite(shopWindow.grid[3])
	DeleteSprite(shopWindow.grid[4])
	DeleteSprite(shopWindow.grid[5])
	DeleteSprite(shopWindow.grid[6])
	DeleteSprite(shopWindow.grid[7])
	DeleteSprite(shopWindow.grid[8])
	DeleteSprite(shopWindow.grid[9])
	for i = 0 to 2
		ZestDeleteImageButton(shopWindow.tabs[i])
		DeleteSprite(shopWindow.tabsBottomLine[i])
		DeleteSprite(shopWindow.tabsBottomShadow[i])
		DeleteSprite(shopWindow.tabsLeftLine[i])
		DeleteSprite(shopWindow.tabsLeftShadow[i])
		DeleteSprite(shopWindow.tabsRightLine[i])
		DeleteSprite(shopWindow.tabsRightShadow[i])
	next
	ZestDeleteImageButton(shopWindow.closeButton)
	DeleteSprite(shopWindow.rewindIcon)
	ZestDeleteText(shopWindow.rewindTitle)
	ZestDeleteText(shopWindow.rewindDescription)
	ZestDeleteImageButton(shopWindow.rewindBuyFreeButton)
	ZestDeleteImageButton(shopWindow.rewindBuy2Button)
	ZestDeleteImageButton(shopWindow.rewindBuy5Button)
	DeleteSprite(shopWindow.findIcon)
	ZestDeleteText(shopWindow.findTitle)
	ZestDeleteText(shopWindow.findDescription)
	ZestDeleteImageButton(shopWindow.findBuyFreeButton)
	ZestDeleteImageButton(shopWindow.findBuy2Button)
	ZestDeleteImageButton(shopWindow.findBuy5Button)
	DeleteSprite(shopWindow.shuffleIcon)
	ZestDeleteText(shopWindow.shuffleTitle)
	ZestDeleteText(shopWindow.shuffleDescription)
	ZestDeleteImageButton(shopWindow.shuffleBuyFreeButton)
	ZestDeleteImageButton(shopWindow.shuffleBuy2Button)
	ZestDeleteImageButton(shopWindow.shuffleBuy5Button)
	DeleteSprite(shopWindow.freezeIcon)
	ZestDeleteText(shopWindow.freezeTitle)
	ZestDeleteText(shopWindow.freezeDescription)
	ZestDeleteImageButton(shopWindow.freezeBuyFreeButton)
	ZestDeleteImageButton(shopWindow.freezeBuy2Button)
	ZestDeleteImageButton(shopWindow.freezeBuy5Button)
	DeleteSprite(shopWindow.rewindOwnedSprite)
	DeleteSprite(shopWindow.rewindOwnedCount.leftHalfSprite)
	DeleteSprite(shopWindow.rewindOwnedCount.centreSprite)
	DeleteSprite(shopWindow.rewindOwnedCount.rightHalfSprite)
	ZestDeleteText(shopWindow.rewindOwnedCount.counterText)
	DeleteSprite(shopWindow.findOwnedSprite)
	DeleteSprite(shopWindow.findOwnedCount.leftHalfSprite)
	DeleteSprite(shopWindow.findOwnedCount.centreSprite)
	DeleteSprite(shopWindow.findOwnedCount.rightHalfSprite)
	ZestDeleteText(shopWindow.findOwnedCount.counterText)
	DeleteSprite(shopWindow.shuffleOwnedSprite)
	DeleteSprite(shopWindow.shuffleOwnedCount.leftHalfSprite)
	DeleteSprite(shopWindow.shuffleOwnedCount.centreSprite)
	DeleteSprite(shopWindow.shuffleOwnedCount.rightHalfSprite)
	ZestDeleteText(shopWindow.shuffleOwnedCount.counterText)
	DeleteSprite(shopWindow.freezeOwnedSprite)
	DeleteSprite(shopWindow.freezeOwnedCount.leftHalfSprite)
	DeleteSprite(shopWindow.freezeOwnedCount.centreSprite)
	DeleteSprite(shopWindow.freezeOwnedCount.rightHalfSprite)
	ZestDeleteText(shopWindow.freezeOwnedCount.counterText)
	for i = 1 to 2
		ZestDeleteText(shopWindow.tileSetTitle[i])
		DeleteSprite(shopWindow.tileSetSprite[i])
		ZestDeleteText(shopWindow.tileSetDifficulty[i])
		ZestDeleteImageButton(shopWindow.tileSetBuyButton[i])
	next
	for i = 1 to 4
		DeleteSprite(shopWindow.backgroundBorder[i])
		DeleteSprite(shopWindow.background[i])
		ZestDeleteImageButton(shopWindow.backgroundBuyButton[i])
	next
	ZestDeleteText(shopWindow.pageTitle)
	ZestDeleteImageButton(shopWindow.pageButton[1])
	ZestDeleteImageButton(shopWindow.pageButton[2])
	ZestDeleteImageButton(shopWindow.pageButton[3])
	ZestDeleteText(shopWindow.pageButtonText[1])
	ZestDeleteText(shopWindow.pageButtonText[2])
	ZestDeleteText(shopWindow.pageButtonText[3])
endfunction

function DeleteTilesUnlockedWindow()
	local i as integer
	
	if (lower(windowOpen) = "tiles unlocked") then windowOpen = ""
		
	DeleteSprite(tilesUnlockedWindow.scrimSprite)
	DeleteSprite(tilesUnlockedWindow.grid[1])
	DeleteSprite(tilesUnlockedWindow.grid[2])
	DeleteSprite(tilesUnlockedWindow.grid[3])
	DeleteSprite(tilesUnlockedWindow.grid[4])
	DeleteSprite(tilesUnlockedWindow.grid[5])
	DeleteSprite(tilesUnlockedWindow.grid[6])
	DeleteSprite(tilesUnlockedWindow.grid[7])
	DeleteSprite(tilesUnlockedWindow.grid[8])
	DeleteSprite(tilesUnlockedWindow.grid[9])
	ZestDeleteImageButton(tilesUnlockedWindow.closeButton)
	ZestDeleteText(tilesUnlockedWindow.titleText)
	for i = 0 to 10
		DeleteSprite(tilesUnlockedWindow.tilesUnlocked[i])
	next
	ZestDeleteImageButton(tilesUnlockedWindow.claimButton)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tiles[i].image))
	next
endfunction

function DeleteTimesUpWindow()
	local i as integer
	
	if (lower(windowOpen) = "tray full") then windowOpen = ""
		
	DeleteSprite(timesUpWindow.scrimSprite)
	DeleteSprite(timesUpWindow.grid[1])
	DeleteSprite(timesUpWindow.grid[2])
	DeleteSprite(timesUpWindow.grid[3])
	DeleteSprite(timesUpWindow.grid[4])
	DeleteSprite(timesUpWindow.grid[5])
	DeleteSprite(timesUpWindow.grid[6])
	DeleteSprite(timesUpWindow.grid[7])
	DeleteSprite(timesUpWindow.grid[8])
	DeleteSprite(timesUpWindow.grid[9])
	ZestDeleteImageButton(timesUpWindow.closeButton)
	ZestDeleteText(timesUpWindow.titleText)
	ZestDeleteText(timesUpWindow.bodyText)
	ZestDeleteImageButton(timesUpWindow.watchAdButton)
	ZestDeleteImageButton(timesUpWindow.buyButton)
	ZestDeleteImageButton(timesUpWindow.restartButton)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tiles[i].image))
	next
endfunction

function DeleteTrayFullWindow()
	local i as integer
	
	if (lower(windowOpen) = "tray full") then windowOpen = ""
		
	DeleteSprite(trayFullWindow.scrimSprite)
	DeleteSprite(trayFullWindow.grid[1])
	DeleteSprite(trayFullWindow.grid[2])
	DeleteSprite(trayFullWindow.grid[3])
	DeleteSprite(trayFullWindow.grid[4])
	DeleteSprite(trayFullWindow.grid[5])
	DeleteSprite(trayFullWindow.grid[6])
	DeleteSprite(trayFullWindow.grid[7])
	DeleteSprite(trayFullWindow.grid[8])
	DeleteSprite(trayFullWindow.grid[9])
	ZestDeleteImageButton(trayFullWindow.closeButton)
	ZestDeleteText(trayFullWindow.titleText)
	ZestDeleteText(trayFullWindow.bodyText)
	ZestDeleteImageButton(trayFullWindow.watchAdButton)
	ZestDeleteImageButton(trayFullWindow.buyButton)
	ZestDeleteImageButton(trayFullWindow.restartButton)
	ZestUpdateImageButton(levelScene.pauseButton, "position:" + str(abs(GetScreenBoundsLeft()) + PercentageToVirtualX(85)) + "," + str(PercentageToVirtualY(1.5)))
	for i = 0 to tiles.length
		ZestUpdateSprite(tiles[i].sprite, "image:" + str(tiles[i].image))
	next
endfunction

function IncreaseCoinsMultiplier()
	game[0].timeStartedCoinsMultiplier = GetMilliseconds()
	inc game[0].levelCoinsMultiplier
	if (game[0].levelCoinsMultiplier > stats[0].highestCoinsMultiplier)
		stats[0].highestCoinsMultiplier = game[0].levelCoinsMultiplier
		stats.save("stats.json")
	endif
endfunction

function InitiateHomeScreen()
	DeleteLevelScene()
	DeleteAllTiles()
	ClearTray()
	ClearRewindHistory()
	CreateHomeScreen()
endfunction

function InitiateLevel()
	game[0].freezeDuration = 0
	game[0].freezeTimer = 0
	game[0].minimisedDuration = 0
	game[0].paused = 0
	game[0].pausedDuration = 0
	game[0].levelCoins = 0
	game[0].levelCoinsMultiplier = 1
	game[0].tilesInTray = 0
	game[0].timeAdded = 0
	game[0].timeElapsed = 0
	game[0].timeFrozen = 0
	game[0].timeLastUsedFindTool = 0
	game[0].timeLevelStarted = GetMilliseconds()
	game[0].timePaused = 0
	game[0].timeRemoved = 0
	game[0].timeSinceRemoved = 0
	game[0].timeStartedCoinsMultiplier = 0
	
	DeleteLevelScene()
	DeleteAllTiles()
	ClearTray()
	ClearRewindHistory()
	CreateLevelScene()
	CreateTileSetsList()
	CreateTileSet()
	CreateAndShuffleTiles()
	PlaceTiles()
endfunction

function LoadTileImages()
	local a as integer
	local b as integer
	local id as integer
	local sets as integer[10, 4]
	local unlockedSets as integer[10, 4]
	
	for a = 1 to 2
		for b = 1 to 4
			sets[a, b] = LoadImage("Tile Sets/Set-" + AddLeadingZeros(str(a), 2) + "-Tiles-" + AddLeadingZeros(str(b), 2) + ".png")
			unlockedSets[a, b] = LoadImage("Tile Sets/Set-" + AddLeadingZeros(str(a), 2) + "-Unlocked-Tiles-" + AddLeadingZeros(str(b), 2) + ".png")
		next
	next
	
	remstart
	sets[1, 1] = LoadImage("Tile Sets/Set-01-Tiles-01.png")
	sets[1, 2] = LoadImage("Tile Sets/Set-01-Tiles-02.png")
	sets[1, 3] = LoadImage("Tile Sets/Set-01-Tiles-03.png")
	sets[1, 4] = LoadImage("Tile Sets/Set-01-Tiles-04.png")
	unlockedSets[1, 1] = LoadImage("Tile Sets/Set-01-Unlocked-Tiles-01.png")
	unlockedSets[1, 2] = LoadImage("Tile Sets/Set-01-Unlocked-Tiles-02.png")
	unlockedSets[1, 3] = LoadImage("Tile Sets/Set-01-Unlocked-Tiles-03.png")
	unlockedSets[1, 4] = LoadImage("Tile Sets/Set-01-Unlocked-Tiles-04.png")
	remend
	
	for a = 1 to 2
		for b = 0 to 255
			setPart = floor(b / 64) + 1
			//tileImages.insert(blankTileImage)
			//tileUnlockedImages.insert(blankTileImage)
			//id = tileImages.length
			id = b
			tileImages[a, id].id = id
			tileImages[a, id].image = LoadSubImage(sets[a, setPart], "tile" + str(b + 1))
			tileUnlockedImages[a, id].id = id
			tileUnlockedImages[a, id].image = LoadSubImage(unlockedSets[a, setPart], "tile" + str(b + 1))
		next
	next
endfunction

function MaxFloat(a# as float, b# as float)
	local maxValue# as float
	
	if (a# > b#)
		maxValue# = a#
	else
		maxValue# = b#
	endif
endfunction maxValue#

function MaxInt(a as integer, b as integer)
	local maxValue as integer
	
	if (a > b)
		maxValue = a
	else
		maxValue = b
	endif
endfunction maxValue

function MinFloat(a# as float, b# as float)
	local minValue# as float
	
	if (a# < b#)
		minValue# = a#
	else
		minValue# = b#
	endif
endfunction minValue#

function MinInt(a as integer, b as integer)
	local minValue as integer
	
	if (a < b)
		minValue = a
	else
		minValue = b
	endif
endfunction minValue

function PauseTimer()
	game[0].paused = 1
	game[0].timePaused = GetMilliseconds()
endfunction

function PercentageToVirtualHeight(percentage as float)
	local virtualHeight as float
	
	virtualHeight = (GetVirtualHeight() / 100.0) * percentage
endfunction virtualHeight

function PercentageToVirtualWidth(percentage as float)
	local virtualWidth as float
	
	virtualWidth = (GetVirtualWidth() / 100.0) * percentage
endfunction virtualWidth

function PercentageToVirtualX(percentage as float)
	local virtualX as float
	
	virtualX = ((GetVirtualWidth() / 100.0) * percentage)
endfunction virtualX

function PercentageToVirtualY(percentage as float)
	local virtualY as float

	virtualY = ((GetVirtualHeight() / 100.0) * percentage)
endfunction virtualY

function PlaceTiles()
	local a as integer
	local b as integer

	game[0].lowestTileDepth = 999
	for a = 0 to tiles.length
		tiles[a].position.x = GetScreenBoundsLeft() + Random(PercentageToVirtualX(4), PercentageToVirtualX(80) + abs(GetScreenBoundsLeft() * 2))
		tiles[a].position.y = Random(PercentageToVirtualY(11), PercentageToVirtualY(64))
		tiles[a].angle = Random(345, 375)
		ZestUpdateSprite(tiles[a].sprite, "angle:" + str(tiles[a].angle) + ";position:" + str(tiles[a].position.x) + "," + str(tiles[a].position.y) + ";size:" + str(PercentageToVirtualWidth(16)) + ",-1")
		for b = 0 to tiles.length 
			if (a <> b and GetSpriteCollision(tiles[a].sprite, tiles[b].sprite))
				if (tiles[a].depth >= GetSpriteDepth(tiles[b].sprite))
					tiles[a].depth = GetSpriteDepth(tiles[b].sprite) - 1
					ZestUpdateSprite(tiles[a].sprite, "depth:" + str(tiles[a].depth))
					if (tiles[a].depth < game[0].lowestTileDepth) then game[0].lowestTileDepth = tiles[a].depth
				endif
			endif
		next
	next
endfunction

function ResetData()
	local i as integer
	
	DeleteFile("game.json")
	DeleteFile("stats.json")
	game.length = -1
	game.length = 0
	game[0].backgroundsUnlocked[1] = 1
	game[0].findTools = 3
	game[0].freezeTools = 3
	game[0].safeCoins = 0
	for i = 1 to 19
		game[0].level[i] = 1
		game[0].levelLastUnlockedTiles[i] = 0
	next
	game[0].rewindTools = 3
	game[0].selectedBackground = 1
	game[0].selectedTileSet = 1
	game[0].shuffleTools = 3
	game[0].sound = 1
	game[0].tileSetsUnlocked[1] = 1
	for i = 2 to 20
		game[0].tileSetsUnlocked[i] = 0
	next
	game[0].vibrate = 1
	stats[0].bestTimeBySetsCount.length = 100
	stats[0].highestCoinsMultiplier = 0
	stats[0].mostCoinsCollectedInALevel = 0
	//GameCenterSubmitScore(game[0].level[1], "CgkIno6a1dkeEAIQAg")
	//GameCenterSubmitScore(game[0].level[2], "CgkIno6a1dkeEAIQAw")
	//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
	game.save("game.json")
	stats.save("stats.json")
endfunction

function RewardAdListener()
	if (GetRewardAdRewardedAdMob() and watchingRewardAd = 1)
		if (lower(windowOpen) = "add rewind" or lower(windowOpen) = "add find" or lower(windowOpen) = "add shuffle" or lower(windowOpen) = "add freeze")
			if (lower(adReward) = "free rewind") then inc game[0].rewindTools
			if (lower(adReward) = "free find") then inc game[0].findTools
			if (lower(adReward) = "free shuffle") then inc game[0].shuffleTools
			if (lower(adReward) = "free freeze") then inc game[0].freezeTools
			game.save("game.json")
			DeleteAddToolsWindow()
		endif
		if (lower(windowOpen) = "completed level")
			if (lower(adReward) = "double coins")
				game[0].safeCoins = game[0].safeCoins + (game[0].levelCoins * 2)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				if ((game[0].levelCoins * 2) > stats[0].mostCoinsCollectedInALevel)
					stats[0].mostCoinsCollectedInALevel = game[0].levelCoins * 2
					stats.save("stats.json")
				endif
				inc game[0].level[game[0].selectedTileSet]
				if (game[0].selectedTileSet = 1)
					//GameCenterSubmitScore(game[0].level[1], "CgkIno6a1dkeEAIQAg")
				elseif (game[0].selectedTileSet = 2)
					//GameCenterSubmitScore(game[0].level[2], "CgkIno6a1dkeEAIQAw")
				endif	
			endif
			game.save("game.json")
			game[0].phase = GAME_PHASE_INITIATE_LEVEL
			DeleteCompletedLevelWindow()
		endif
		if (lower(windowOpen) = "shop")
			if (lower(adReward) = "free shop rewind") then inc game[0].rewindTools
			if (lower(adReward) = "free shop find") then inc game[0].findTools
			if (lower(adReward) = "free shop shuffle") then inc game[0].shuffleTools
			if (lower(adReward) = "free shop freeze") then inc game[0].freezeTools
			game.save("game.json")
			UpdateShopWindow()
		endif
		if (lower(windowOpen) = "time's up")
			if (lower(adReward) = "add time")
				DeleteTimesUpWindow()
				game[0].timeAdded = game[0].timeAdded + 60000
				UnpauseTimer()
				game[0].phase = GAME_PHASE_PLAYING
			endif
		endif
		if (lower(windowOpen) = "tray full")
			if (lower(adReward) = "clear tray")
				DeleteTrayFullWindow()
				Rewind(game[0].tilesInTray)
				UnpauseTimer()
				game[0].phase = GAME_PHASE_PLAYING
			endif
		endif
		watchingRewardAd = 0
		adReward = ""
		ResetRewardAdMob()
		if (game[0].paused = 1)
			UnpauseTimer()
		endif
	endif
endfunction

function Rewind(steps as integer)
	local i as integer
	local j as integer
	local k as integer
	
	for i = 1 to steps
		stepCompleted = 0
		for j = rewindHistory.length to 0 step -1
			for k = tray.length to 1 step -1
				if (rewindHistory[j] = tray[k].id)
					if (GetSpriteExists(tray[k].sprite))
						tiles.insert(blankTile)
						id = tiles.length
						tiles[id].id = tray[k].id
						tiles[id].angle = tray[k].angle
						dec game[0].lowestTileDepth
						tiles[id].depth = game[0].lowestTileDepth
						tiles[id].group = tray[k].group
						tiles[id].image = tray[k].image
						tiles[id].position.x = tray[k].position.x
						tiles[id].position.y = tray[k].position.y
						tiles[id].sprite = tray[k].sprite
						tiles[id].tween = tray[k].tween
						SetTweenSpriteX(tiles[id].tween, GetSpriteX(tiles[id].sprite), tiles[id].position.x, TweenLinear())
						SetTweenSpriteY(tiles[id].tween, GetSpriteY(tiles[id].sprite), tiles[id].position.y, TweenLinear())
						SetTweenSpriteSizeX(tiles[id].tween, GetSpriteWidth(tray[k].sprite), tileSize.x, TweenLinear())
						SetTweenSpriteSizeY(tiles[id].tween, GetSpriteHeight(tray[k].sprite), tileSize.y, TweenLinear())
						SetSpriteDepth(tiles[id].sprite, tiles[id].depth)
						if (tiles[id].angle > 360)
							SetTweenSpriteAngle(tiles[id].tween, GetSpriteAngle(tiles[id].sprite), tiles[id].angle - 360, TweenLinear())
						else
							SetTweenSpriteAngle(tiles[id].tween, GetSpriteAngle(tiles[id].sprite), -(360 - tiles[id].angle), TweenLinear())
						endif
						PlayTweenSprite(tiles[id].tween, tiles[id].sprite, 0)
						tray.remove(k)
						dec game[0].tilesInTray
						rewindHistory.remove(j)
						inc stepCompleted
						exit
					endif
				endif
			next
			if (stepCompleted > 0) then exit
		next
	next
endfunction

function ShuffleTiles()
	local i as integer
	
	for i = 0 to tileSet.length
		tileSet[i].sortKey$ = Str(Random(10000, 99999))
	next
	tileSet.sort()
endfunction

function UnpauseTimer()
	game[0].paused = 0
	game[0].pausedDuration = game[0].pausedDuration + GetMilliseconds() - game[0].timePaused
	if (game[0].freezeTimer = 1)
		game[0].timeFrozen = GetMilliseconds() - (game[0].timePaused - game[0].timeFrozen)
	endif
endfunction

function UpdateHomeScreen()
	// UPDATE SAFE COINS TEXT
	ZestUpdateText(homeScreen.safeCoinsText, "text:" + AddThousandsSeperator(game[0].safeCoins, ","))
	ZestPinTextToCentreRightOfSprite(homeScreen.safeCoinsText, homeScreen.safeSprite, ZestGetTextWidth(homeScreen.safeCoinsText) + PercentageToVirtualWidth(0.5), 0)
	
	// UPDATE LEVEL TEXT
	ZestUpdateText(homeScreen.levelText, "text:Level " + AddThousandsSeperator(game[0].level[game[0].selectedTileSet], ","))
endfunction

function UpdateLevelScene()
	local maxLevelCoinsMultiplierTime as integer
	local minutes as integer
	local pausedDuration as integer
	local percentage as float
	local seconds as integer
	local width as float
	
	// UPDATE LEVEL TEXT
	ZestUpdateText(levelScene.levelText, "text:LEVEL " + AddThousandsSeperator(game[0].level[game[0].selectedTileSet], ","))
	
	// UPDATE SAFE COINS TEXT
	ZestUpdateText(levelScene.safeCoinsText, "text:" + AddThousandsSeperator(game[0].safeCoins, ","))
	ZestPinTextToCentreRightOfSprite(levelScene.safeCoinsText, levelScene.safeSprite, ZestGetTextWidth(levelScene.safeCoinsText) + PercentageToVirtualWidth(0.5), 0)

	// UPDATE LEVEL COINS TEXT
	ZestUpdateText(levelScene.levelCoinsText, "text:" + AddThousandsSeperator(game[0].levelCoins, ","))
	ZestPinTextToCentreRightOfSprite(levelScene.levelCoinsText, levelScene.levelCoinSprite, ZestGetTextWidth(levelScene.levelCoinsText) + PercentageToVirtualWidth(0.5), 0)

	// UPDATE TIMER
	ZestUpdateSprite(levelScene.timerSprite, "alpha:255;position:" + str(PercentageToVirtualX(50) - (levelScene.timerTotalWidth / 2.0)) + "," + str(GetSpriteY(levelScene.timerSprite)))
	ZestUpdateText(levelScene.timerText, "position:" + str(GetSpriteX(levelScene.timerSprite) + GetSpriteWidth(levelScene.timerSprite) + PercentageToVirtualWidth(1)) + "," + str(ZestGetTextY(levelScene.timerText)))
	if (game[0].freezeTimer = 1 or game[0].paused = 1)
		if (game[0].freezeTimer = 1 and GetMilliseconds() - game[0].timeFrozen >= 15000 and game[0].paused = 0)
			game[0].freezeTimer = 0
			game[0].freezeDuration = game[0].freezeDuration + 15000
		endif
	else
		game[0].timeElapsed = (GetMilliseconds() - game[0].freezeDuration - game[0].minimisedDuration - game[0].pausedDuration - game[0].timeAdded - game[0].timeRemoved) - game[0].timeLevelStarted
	endif
	seconds = floor(mod(((game[0].timeToComplete - game[0].timeElapsed) / 1000), 60))
	minutes = floor(mod(((game[0].timeToComplete - game[0].timeElapsed) / (1000 * 60)), 60))
	if (seconds < 0) then seconds = 0
    if (seconds > 10) then lastPlayedDing = 11
    if (seconds > 0 and seconds <= 10 and seconds < lastPlayedDing and minutes = 0)
    	if (game[0].sound = 1 and tiles.length >= 0) then PlaySound(dingSound, 30)
    	lastPlayedDing = seconds
    endif
	ZestUpdateText(levelScene.timerText, "alpha:255;text:" + AddLeadingZeros(str(minutes), 2) + "[colon]" + AddLeadingZeros(str(seconds), 2))
	if (game[0].freezeTimer = 1)
		ZestUpdateSprite(levelScene.timerFrozenOverlaySprite, "color:200,233,233,150")
	else
		ZestUpdateSprite(levelScene.timerFrozenOverlaySprite, "alpha:0")
	endif
	
	// UPDATE REWIND TOOLS COUNT
	if (game[0].rewindTools > 0 and rewindHistory.length = -1)
		ZestDisableImageButton(levelScene.rewindButton)
	else
		ZestEnableImageButton(levelScene.rewindButton)
	endif
	if (game[0].rewindTools > 0)
		ZestUpdateText(levelScene.rewindButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].rewindTools))
		ZestUpdateSprite(levelScene.rewindButtonLoadingAdAnimation, "position:-9999,-9999")
	else
		if (game[0].safeCoins + game[0].levelCoins >= 200 or GetRewardAdLoadedAdMob() = 1)	
			ZestUpdateText(levelScene.rewindButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(3)) + ";text:+")
			ZestUpdateSprite(levelScene.rewindButtonLoadingAdAnimation, "position:-9999,-9999")
		else
			ZestUpdateText(levelScene.rewindButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text: ")
			ZestUpdateSprite(levelScene.rewindButtonLoadingAdAnimation, "position:" + str(GetSpriteXByOffset(levelScene.rewindButtonCount.centreSprite)) + "," + str(GetSpriteYByOffset(levelScene.rewindButtonCount.centreSprite)))
			ZestDisableImageButton(levelScene.rewindButton)
		endif
	endif
	width = ZestGetTextWidth(levelScene.rewindButtonCount.counterText) - 2
	if (width < 0) then width = 0
	ZestUpdateSprite(levelScene.rewindButtonCount.centreSprite, "width:" + str(width))
	ZestUpdateSprite(levelScene.rewindButtonCount.leftHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.rewindButton) - (GetSpriteWidth(levelScene.rewindButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.rewindButton)))
	ZestUpdateSprite(levelScene.rewindButtonCount.centreSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.rewindButton)) + "," + str(ZestGetImageButtonY(levelScene.rewindButton)))
	ZestUpdateSprite(levelScene.rewindButtonCount.rightHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.rewindButton) + (GetSpriteWidth(levelScene.rewindButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.rewindButton)))
	if (game[0].rewindTools > 0)
		ZestUpdateSprite(levelScene.rewindButtonCount.leftHalfSprite, "color:#000000")
		ZestUpdateSprite(levelScene.rewindButtonCount.centreSprite, "color:#000000")
		ZestUpdateSprite(levelScene.rewindButtonCount.rightHalfSprite, "color:#000000")
	else
		ZestUpdateSprite(levelScene.rewindButtonCount.leftHalfSprite, "color:#047101")
		ZestUpdateSprite(levelScene.rewindButtonCount.centreSprite, "color:#047101")
		ZestUpdateSprite(levelScene.rewindButtonCount.rightHalfSprite, "color:#047101")
	endif
	ZestPinTextToCentreOfSprite(levelScene.rewindButtonCount.counterText, levelScene.rewindButtonCount.centreSprite, 0, 0)
	
	// UPDATE FIND TOOLS COUNT
	if (game[0].timeLastUsedFindTool > 0 and GetMilliseconds() < game[0].timeLastUsedFindTool + 1000 and game[0].findTools > 0)
		ZestDisableImageButton(levelScene.findButton)
	else
		ZestEnableImageButton(levelScene.findButton)
	endif
	if (game[0].findTools > 0)
		ZestUpdateText(levelScene.findButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].findTools))
		ZestUpdateSprite(levelScene.findButtonLoadingAdAnimation, "position:-9999,-9999")
	else
		if (game[0].safeCoins + game[0].levelCoins >= 200 or GetRewardAdLoadedAdMob() = 1)	
			ZestUpdateText(levelScene.findButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(3)) + ";text:+")
			ZestUpdateSprite(levelScene.findButtonLoadingAdAnimation, "position:-9999,-9999")
		else
			ZestUpdateText(levelScene.findButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text: ")
			ZestUpdateSprite(levelScene.findButtonLoadingAdAnimation, "position:" + str(GetSpriteXByOffset(levelScene.findButtonCount.centreSprite)) + "," + str(GetSpriteYByOffset(levelScene.rewindButtonCount.centreSprite)))
			ZestDisableImageButton(levelScene.findButton)
		endif
	endif
	width = ZestGetTextWidth(levelScene.findButtonCount.counterText) - 2
	if (width < 0) then width = 0
	ZestUpdateSprite(levelScene.findButtonCount.centreSprite, "width:" + str(width))
	ZestUpdateSprite(levelScene.findButtonCount.leftHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.findButton) - (GetSpriteWidth(levelScene.findButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.findButton)))
	ZestUpdateSprite(levelScene.findButtonCount.centreSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.findButton)) + "," + str(ZestGetImageButtonY(levelScene.findButton)))
	ZestUpdateSprite(levelScene.findButtonCount.rightHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.findButton) + (GetSpriteWidth(levelScene.findButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.findButton)))
	if (game[0].findTools > 0)
		ZestUpdateSprite(levelScene.findButtonCount.leftHalfSprite, "color:#000000")
		ZestUpdateSprite(levelScene.findButtonCount.centreSprite, "color:#000000")
		ZestUpdateSprite(levelScene.findButtonCount.rightHalfSprite, "color:#000000")
	else
		ZestUpdateSprite(levelScene.findButtonCount.leftHalfSprite, "color:#047101")
		ZestUpdateSprite(levelScene.findButtonCount.centreSprite, "color:#047101")
		ZestUpdateSprite(levelScene.findButtonCount.rightHalfSprite, "color:#047101")
	endif
	ZestPinTextToCentreOfSprite(levelScene.findButtonCount.counterText, levelScene.findButtonCount.centreSprite, 0, 0)
	
	// UPDATE SHUFFLE TOOLS COUNT
	if (game[0].shuffleTools > 0)
		ZestUpdateText(levelScene.shuffleButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].shuffleTools))
		ZestUpdateSprite(levelScene.shuffleButtonLoadingAdAnimation, "position:-9999,-9999")
	else
		if (game[0].safeCoins + game[0].levelCoins >= 200 or GetRewardAdLoadedAdMob() = 1)	
			ZestUpdateText(levelScene.shuffleButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(3)) + ";text:+")
			ZestUpdateSprite(levelScene.shuffleButtonLoadingAdAnimation, "position:-9999,-9999")
		else
			ZestUpdateText(levelScene.shuffleButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text: ")
			ZestUpdateSprite(levelScene.shuffleButtonLoadingAdAnimation, "position:" + str(GetSpriteXByOffset(levelScene.shuffleButtonCount.centreSprite)) + "," + str(GetSpriteYByOffset(levelScene.rewindButtonCount.centreSprite)))
			ZestDisableImageButton(levelScene.shuffleButton)
		endif
	endif
	width = ZestGetTextWidth(levelScene.shuffleButtonCount.counterText) - 2
	if (width < 0) then width = 0
	ZestUpdateSprite(levelScene.shuffleButtonCount.centreSprite, "width:" + str(width))
	ZestUpdateSprite(levelScene.shuffleButtonCount.leftHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.shuffleButton) - (GetSpriteWidth(levelScene.shuffleButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.shuffleButton)))
	ZestUpdateSprite(levelScene.shuffleButtonCount.centreSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.shuffleButton)) + "," + str(ZestGetImageButtonY(levelScene.shuffleButton)))
	ZestUpdateSprite(levelScene.shuffleButtonCount.rightHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.shuffleButton) + (GetSpriteWidth(levelScene.shuffleButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.shuffleButton)))
	if (game[0].shuffleTools > 0)
		ZestUpdateSprite(levelScene.shuffleButtonCount.leftHalfSprite, "color:#000000")
		ZestUpdateSprite(levelScene.shuffleButtonCount.centreSprite, "color:#000000")
		ZestUpdateSprite(levelScene.shuffleButtonCount.rightHalfSprite, "color:#000000")
	else
		ZestUpdateSprite(levelScene.shuffleButtonCount.leftHalfSprite, "color:#047101")
		ZestUpdateSprite(levelScene.shuffleButtonCount.centreSprite, "color:#047101")
		ZestUpdateSprite(levelScene.shuffleButtonCount.rightHalfSprite, "color:#047101")
	endif
	ZestPinTextToCentreOfSprite(levelScene.shuffleButtonCount.counterText, levelScene.shuffleButtonCount.centreSprite, 0, 0)
	
	// UPDATE FREEZE TOOLS COUNT
	if (game[0].freezeTimer = 1 and game[0].freezeTools > 0)
		ZestDisableImageButton(levelScene.freezeButton)
	else
		ZestEnableImageButton(levelScene.freezeButton)
	endif
	if (game[0].freezeTools > 0)
		ZestUpdateText(levelScene.freezeButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].freezeTools))
		ZestUpdateSprite(levelScene.freezeButtonLoadingAdAnimation, "position:-9999,-9999")
	else
		if (game[0].safeCoins + game[0].levelCoins >= 200 or GetRewardAdLoadedAdMob() = 1)	
			ZestUpdateText(levelScene.freezeButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(3)) + ";text:+")
			ZestUpdateSprite(levelScene.freezeButtonLoadingAdAnimation, "position:-9999,-9999")
		else
			ZestUpdateText(levelScene.freezeButtonCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text: ")
			ZestUpdateSprite(levelScene.freezeButtonLoadingAdAnimation, "position:" + str(GetSpriteXByOffset(levelScene.freezeButtonCount.centreSprite)) + "," + str(GetSpriteYByOffset(levelScene.rewindButtonCount.centreSprite)))
			ZestDisableImageButton(levelScene.freezeButton)
		endif
	endif
	width = ZestGetTextWidth(levelScene.freezeButtonCount.counterText) - 2
	if (width < 0) then width = 0
	ZestUpdateSprite(levelScene.freezeButtonCount.centreSprite, "width:" + str(width))
	ZestUpdateSprite(levelScene.freezeButtonCount.leftHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.freezeButton) - (GetSpriteWidth(levelScene.freezeButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.freezeButton)))
	ZestUpdateSprite(levelScene.freezeButtonCount.centreSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.freezeButton)) + "," + str(ZestGetImageButtonY(levelScene.freezeButton)))
	ZestUpdateSprite(levelScene.freezeButtonCount.rightHalfSprite, "position:" + str(ZestGetImageButtonXByOffset(levelScene.freezeButton) + (GetSpriteWidth(levelScene.freezeButtonCount.centreSprite) / 2.0)) + "," + str(ZestGetImageButtonY(levelScene.freezeButton)))
	if (game[0].freezeTools > 0)
		ZestUpdateSprite(levelScene.freezeButtonCount.leftHalfSprite, "color:#000000")
		ZestUpdateSprite(levelScene.freezeButtonCount.centreSprite, "color:#000000")
		ZestUpdateSprite(levelScene.freezeButtonCount.rightHalfSprite, "color:#000000")
	else
		ZestUpdateSprite(levelScene.freezeButtonCount.leftHalfSprite, "color:#047101")
		ZestUpdateSprite(levelScene.freezeButtonCount.centreSprite, "color:#047101")
		ZestUpdateSprite(levelScene.freezeButtonCount.rightHalfSprite, "color:#047101")
	endif
	ZestPinTextToCentreOfSprite(levelScene.freezeButtonCount.counterText, levelScene.freezeButtonCount.centreSprite, 0, 0)
	
	// UPDATE COINS MULTIPLIER BAR AND TEXT
	if (game[0].levelCoinsMultiplier = 2) then maxLevelCoinsMultiplierTime = 8000
	if (game[0].levelCoinsMultiplier = 3) then maxLevelCoinsMultiplierTime = 7000
	if (game[0].levelCoinsMultiplier = 4) then maxLevelCoinsMultiplierTime = 6000
	if (game[0].levelCoinsMultiplier = 5) then maxLevelCoinsMultiplierTime = 5000
	if (game[0].levelCoinsMultiplier >= 6) then maxLevelCoinsMultiplierTime = 4000
	//if (game[0].coinsMultiplier = 7) then maxLevelCoinsMultiplierTime = 5000
	//if (game[0].coinsMultiplier >= 8) then maxLevelCoinsMultiplierTime = 4000
	pausedDuration = 0
	if (game[0].timePaused >= game[0].timeStartedCoinsMultiplier) then pausedDuration = game[0].pausedDuration
	if (game[0].levelCoinsMultiplier > 1 and game[0].paused = 0 and GetMilliseconds() - pausedDuration - game[0].timeStartedCoinsMultiplier >= maxLevelCoinsMultiplierTime) then game[0].levelCoinsMultiplier = 1
	if (game[0].paused = 0)
		if (maxLevelCoinsMultiplierTime > 0)
			percentage = 1.0 - ((GetMilliseconds() - pausedDuration - game[0].timeStartedCoinsMultiplier) / (maxLevelCoinsMultiplierTime * 1.0))
			SetSpriteScissor(levelScene.multiplierBarSprite, GetSpriteX(levelScene.multiplierBarSprite), GetSpriteY(levelScene.multiplierBarSprite), GetSpriteX(levelScene.multiplierBarSprite) + (GetSpriteWidth(levelScene.multiplierBarSprite) * percentage), GetSpriteY(levelScene.multiplierBarSprite) + GetSpriteHeight(levelScene.multiplierBarSprite))
		else
			SetSpriteScissor(levelScene.multiplierBarSprite, GetSpriteX(levelScene.multiplierBarSprite), GetSpriteY(levelScene.multiplierBarSprite), GetSpriteX(levelScene.multiplierBarSprite), GetSpriteY(levelScene.multiplierBarSprite))
		endif
	endif
	ZestUpdateText(levelScene.multiplierText, "text:x" + str(game[0].levelCoinsMultiplier))
	ZestPinTextToCentreOfSprite(levelScene.multiplierText, levelScene.multiplierBarSprite, 0, -PercentageToVirtualY(0.35))
endfunction

function UpdateShopWindow()
	local i as integer
	local tileSet as integer
	local tileSetDifficulty as string
	local tileSetTitle as string
	local width as float
	
	if (shopWindow.selectedTab = 0)
		// UPDATE BUY REWIND BUTTONS
		if (game[0].safeCoins < 200)
			ZestDisableImageButton(shopWindow.rewindBuy2Button)
		else
			ZestEnableImageButton(shopWindow.rewindBuy2Button)
		endif
		if (game[0].safeCoins < 400)
			ZestDisableImageButton(shopWindow.rewindBuy5Button)
		else
			ZestEnableImageButton(shopWindow.rewindBuy5Button)
		endif
		
		// UPDATE BUY FIND BUTTONS
		if (game[0].safeCoins < 200)
			ZestDisableImageButton(shopWindow.findBuy2Button)
		else
			ZestEnableImageButton(shopWindow.findBuy2Button)
		endif
		if (game[0].safeCoins < 400)
			ZestDisableImageButton(shopWindow.findBuy5Button)
		else
			ZestEnableImageButton(shopWindow.findBuy5Button)
		endif
		
		// UPDATE BUY SHUFFLE BUTTONS
		if (game[0].safeCoins < 200)
			ZestDisableImageButton(shopWindow.shuffleBuy2Button)
		else
			ZestEnableImageButton(shopWindow.shuffleBuy2Button)
		endif
		if (game[0].safeCoins < 400)
			ZestDisableImageButton(shopWindow.shuffleBuy5Button)
		else
			ZestEnableImageButton(shopWindow.shuffleBuy5Button)
		endif
		
		// UPDATE BUY FREEZE BUTTONS
		if (game[0].safeCoins < 200)
			ZestDisableImageButton(shopWindow.freezeBuy2Button)
		else
			ZestEnableImageButton(shopWindow.freezeBuy2Button)
		endif
		if (game[0].safeCoins < 400)
			ZestDisableImageButton(shopWindow.freezeBuy5Button)
		else
			ZestEnableImageButton(shopWindow.freezeBuy5Button)
		endif
		
		// UPDATE REWIND TOOLS COUNT
		ZestUpdateText(shopWindow.rewindOwnedCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].rewindTools))
		width = ZestGetTextWidth(shopWindow.rewindOwnedCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(shopWindow.rewindOwnedCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(shopWindow.rewindOwnedCount.leftHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.rewindOwnedSprite) - (GetSpriteWidth(shopWindow.rewindOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.rewindOwnedSprite)))
		ZestUpdateSprite(shopWindow.rewindOwnedCount.centreSprite, "position:" + str(GetSpriteXByOffset(shopWindow.rewindOwnedSprite)) + "," + str(GetSpriteY(shopWindow.rewindOwnedSprite)))
		ZestUpdateSprite(shopWindow.rewindOwnedCount.rightHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.rewindOwnedSprite) + (GetSpriteWidth(shopWindow.rewindOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.rewindOwnedSprite)))
		ZestPinTextToCentreOfSprite(shopWindow.rewindOwnedCount.counterText, shopWindow.rewindOwnedCount.centreSprite, 0, 0)
		
		// UPDATE FIND TOOLS COUNT
		ZestUpdateText(shopWindow.findOwnedCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].findTools))
		width = ZestGetTextWidth(shopWindow.findOwnedCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(shopWindow.findOwnedCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(shopWindow.findOwnedCount.leftHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.findOwnedSprite) - (GetSpriteWidth(shopWindow.findOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.findOwnedSprite)))
		ZestUpdateSprite(shopWindow.findOwnedCount.centreSprite, "position:" + str(GetSpriteXByOffset(shopWindow.findOwnedSprite)) + "," + str(GetSpriteY(shopWindow.findOwnedSprite)))
		ZestUpdateSprite(shopWindow.findOwnedCount.rightHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.findOwnedSprite) + (GetSpriteWidth(shopWindow.findOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.findOwnedSprite)))
		ZestPinTextToCentreOfSprite(shopWindow.findOwnedCount.counterText, shopWindow.findOwnedCount.centreSprite, 0, 0)
		
		// UPDATE SHUFFLE TOOLS COUNT
		ZestUpdateText(shopWindow.shuffleOwnedCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].shuffleTools))
		width = ZestGetTextWidth(shopWindow.shuffleOwnedCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(shopWindow.shuffleOwnedCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(shopWindow.shuffleOwnedCount.leftHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.shuffleOwnedSprite) - (GetSpriteWidth(shopWindow.shuffleOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.shuffleOwnedSprite)))
		ZestUpdateSprite(shopWindow.shuffleOwnedCount.centreSprite, "position:" + str(GetSpriteXByOffset(shopWindow.shuffleOwnedSprite)) + "," + str(GetSpriteY(shopWindow.shuffleOwnedSprite)))
		ZestUpdateSprite(shopWindow.shuffleOwnedCount.rightHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.shuffleOwnedSprite) + (GetSpriteWidth(shopWindow.shuffleOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.shuffleOwnedSprite)))
		ZestPinTextToCentreOfSprite(shopWindow.shuffleOwnedCount.counterText, shopWindow.shuffleOwnedCount.centreSprite, 0, 0)
		
		// UPDATE FREEZE TOOLS COUNT
		ZestUpdateText(shopWindow.freezeOwnedCount.counterText, "size:" + str(PercentageToVirtualHeight(2)) + ";text:" + str(game[0].freezeTools))
		width = ZestGetTextWidth(shopWindow.freezeOwnedCount.counterText) - PercentageToVirtualWidth(2)
		if (width < 0) then width = 0
		ZestUpdateSprite(shopWindow.freezeOwnedCount.centreSprite, "width:" + str(width))
		ZestUpdateSprite(shopWindow.freezeOwnedCount.leftHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.freezeOwnedSprite) - (GetSpriteWidth(shopWindow.freezeOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.freezeOwnedSprite)))
		ZestUpdateSprite(shopWindow.freezeOwnedCount.centreSprite, "position:" + str(GetSpriteXByOffset(shopWindow.freezeOwnedSprite)) + "," + str(GetSpriteY(shopWindow.freezeOwnedSprite)))
		ZestUpdateSprite(shopWindow.freezeOwnedCount.rightHalfSprite, "position:" + str(GetSpriteXByOffset(shopWindow.freezeOwnedSprite) + (GetSpriteWidth(shopWindow.freezeOwnedCount.centreSprite) / 2.0)) + "," + str(GetSpriteY(shopWindow.freezeOwnedSprite)))
		ZestPinTextToCentreOfSprite(shopWindow.freezeOwnedCount.counterText, shopWindow.freezeOwnedCount.centreSprite, 0, 0)
	endif
	
	if (shopWindow.selectedTab = 1)
		// UPDATE BUY BUTTONS
		for i = 1 to 2
			tileSet = ((shopWindow.pageNumber - 1) * 2) + i
			if (tileSet = 1)
				tileSetTitle = "Original Tiles"
				tileSetDifficulty = "Normal"
			endif
			if (tileSet = 2)
				tileSetTitle = "Priceless AI Art"
				tileSetDifficulty = "Hard"
			endif
			ZestUpdateText(shopWindow.tileSetTitle[i], "text:" + tileSetTitle)
			ZestUpdateSprite(shopWindow.tileSetSprite[i], "image:" + str(shopTileSetImage[tileSet]))
			ZestUpdateText(shopWindow.tileSetDifficulty[i], "text:Difficulty[colon] " + tileSetDifficulty)
			if (game[0].selectedTileSet = tileSet)
				ZestUpdateImageButton(shopWindow.tileSetBuyButton[i], "disabledImage:" + str(selectedButtonHoverImage) + ";hoverImage:" + str(selectedButtonHoverImage) + ";image:" + str(selectedButtonImage))
			elseif (game[0].tileSetsUnlocked[tileSet] = 1)
				ZestUpdateImageButton(shopWindow.tileSetBuyButton[i], "disabledImage:" + str(selectButtonHoverImage) + ";hoverImage:" + str(selectButtonHoverImage) + ";image:" + str(selectButtonImage))
			else
				ZestUpdateImageButton(shopWindow.tileSetBuyButton[i], "disabledImage:" + str(shop1500ButtonHoverImage) + ";hoverImage:" + str(shop1500ButtonHoverImage) + ";image:" + str(shop1500ButtonImage))
				if (game[0].safeCoins < 1500)
					ZestDisableImageButton(shopWindow.tileSetBuyButton[i])
				else
					ZestEnableImageButton(shopWindow.tileSetBuyButton[i])
				endif
			endif
		next
		remstart
		for i = 1 to 3
			if (shopWindow.pageNumber = i)
				ZestUpdateText(shopWindow.pageButtonText[i], "color:0,0,0,255")
			else
				ZestUpdateText(shopWindow.pageButtonText[i], "color:0,0,255,255")
			endif
		next
		remend
	endif
	
	if (shopWindow.selectedTab = 2)
		// UPDATE BUY BUTTONS
		for i = 1 to 4
			ZestUpdateSprite(shopWindow.background[i], "image:" + str(backgroundImage[((shopWindow.pageNumber - 1) * 4) + i]))
			
			if (game[0].selectedBackground = ((shopWindow.pageNumber - 1) * 4) + i)
				ZestUpdateImageButton(shopWindow.backgroundBuyButton[i], "disabledImage:" + str(selectedButtonHoverImage) + ";hoverImage:" + str(selectedButtonHoverImage) + ";image:" + str(selectedButtonImage))
			elseif (game[0].backgroundsUnlocked[((shopWindow.pageNumber - 1) * 4) + i] = 1)
				ZestUpdateImageButton(shopWindow.backgroundBuyButton[i], "disabledImage:" + str(selectButtonHoverImage) + ";hoverImage:" + str(selectButtonHoverImage) + ";image:" + str(selectButtonImage))
			else
				ZestUpdateImageButton(shopWindow.backgroundBuyButton[i], "disabledImage:" + str(shop500ButtonHoverImage) + ";hoverImage:" + str(shop500ButtonHoverImage) + ";image:" + str(shop500ButtonImage))
				if (game[0].safeCoins < 500)
					ZestDisableImageButton(shopWindow.backgroundBuyButton[i])
				else
					ZestEnableImageButton(shopWindow.backgroundBuyButton[i])
				endif
			endif
		next
		for i = 1 to 3
			if (shopWindow.pageNumber = i)
				ZestUpdateText(shopWindow.pageButtonText[i], "color:0,0,0,255")
			else
				ZestUpdateText(shopWindow.pageButtonText[i], "color:0,0,255,255")
			endif
		next
	endif
endfunction

function UpdateTray()
	local i as integer
	local id as integer
	//local matchFound as integer

	game[0].tweensRunning = 0
	for i = tray.length to 1 step -1
		if (GetSpriteExists(tray[i].sprite))
			if (floor(GetSpriteY(tray[i].sprite)) >= floor(GetSpriteY(levelScene.traySprite)))
				SetSpriteX(tray[i].sprite, GetSpriteX(levelScene.traySprite) + PercentageToVirtualWidth(1.3) + ((i - 1) * PercentageToVirtualWidth(13)))
			endif
			if (GetTweenSpritePlaying(tray[i].tween, tray[i].sprite))
				game[0].tweensRunning = 1
			else
				if (tray[i].delete = 1)
					tray.remove(i)
					dec game[0].tilesInTray
				endif
			endif
		endif
	next
	matchFound = 0
	if (game[0].tweensRunning = 0)
		for i = 1 to tray.length
			if (i > 1 and i < 7)
				if (tray[i].image > 0)
					if (tray[i].image = tray[i - 1].image and tray[i].image = tray[i + 1].image)
						if (floor(GetSpriteY(tray[i - 1].sprite)) >= floor(GetSpriteY(levelScene.traySprite)) and floor(GetSpriteY(tray[i].sprite)) >= floor(GetSpriteY(levelScene.traySprite)) and floor(GetSpriteY(tray[i + 1].sprite)) >= floor(GetSpriteY(levelScene.traySprite)))
							if (game[0].vibrate = 1) then VibrateDevice(0.25)
							CreateCoinTweens(game[0].levelCoinsMultiplier, GetSpriteXByOffset(tray[i].sprite), GetSpriteYByOffset(tray[i].sprite))
							if (game[0].sound = 1) then PlaySound(coinSound)
							DeleteTween(tray[i - 1].tween)
							DeleteTween(tray[i].tween)
							DeleteTween(tray[i + 1].tween)
							for j = rewindHistory.length to 0 step -1
								if (rewindHistory[j] = tray[i - 1].id or rewindHistory[j] = tray[i].id or rewindHistory[j] = tray[i + 1].id) then rewindHistory.remove(j)
							next
							tray[i - 1].delete = 1
							tray[i].delete = 1
							tray[i + 1].delete = 1
							CreateTweenSprite(tray[i - 1].tween, 0.1)
							CreateTweenSprite(tray[i].tween, 0.1)
							CreateTweenSprite(tray[i + 1].tween, 0.1)
							SetTweenSpriteSizeX(tray[i - 1].tween, GetSpriteWidth(tray[i - 1].sprite), 0, TweenLinear())
							SetTweenSpriteSizeX(tray[i].tween, GetSpriteWidth(tray[i].sprite), 0, TweenLinear())
							SetTweenSpriteSizeX(tray[i + 1].tween, GetSpriteWidth(tray[i + 1].sprite), 0, TweenLinear())
							SetTweenSpriteSizeY(tray[i - 1].tween, GetSpriteHeight(tray[i - 1].sprite), 0, TweenLinear())
							SetTweenSpriteSizeY(tray[i].tween, GetSpriteHeight(tray[i].sprite), 0, TweenLinear())
							SetTweenSpriteSizeY(tray[i + 1].tween, GetSpriteHeight(tray[i + 1].sprite), 0, TweenLinear())
							SetTweenSpriteX(tray[i - 1].tween, GetSpriteX(tray[i - 1].sprite), GetSpriteXByOffset(tray[i - 1].sprite), TweenLinear())
							SetTweenSpriteX(tray[i].tween, GetSpriteX(tray[i].sprite), GetSpriteXByOffset(tray[i].sprite), TweenLinear())
							SetTweenSpriteX(tray[i + 1].tween, GetSpriteX(tray[i + 1].sprite), GetSpriteXByOffset(tray[i + 1].sprite), TweenLinear())
							SetTweenSpriteY(tray[i - 1].tween, GetSpriteY(tray[i - 1].sprite), GetSpriteYByOffset(tray[i - 1].sprite), TweenLinear())
							SetTweenSpriteY(tray[i].tween, GetSpriteY(tray[i].sprite), GetSpriteYByOffset(tray[i].sprite), TweenLinear())
							SetTweenSpriteY(tray[i + 1].tween, GetSpriteY(tray[i + 1].sprite), GetSpriteYByOffset(tray[i + 1].sprite), TweenLinear())
							PlayTweenSprite(tray[i - 1].tween, tray[i - 1].sprite, 0)
							PlayTweenSprite(tray[i].tween, tray[i].sprite, 0)
							PlayTweenSprite(tray[i + 1].tween, tray[i + 1].sprite, 0)
							matchFound = 1
							IncreaseCoinsMultiplier()
							exit
						endif
					endif
				endif
			endif
		next
	endif
endfunction
