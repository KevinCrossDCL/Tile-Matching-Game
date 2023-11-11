
// Project: Tile Matching Game
// Created: 23-01-22

#renderer "Basic"

#insert "resolutions.agc"

//SetDisplayAspect(-1)
SetErrorMode(2)
SetGenerateMipmaps(0)
SetImmersiveMode(1)
SetOrientationAllowed(1, 1, 0, 0)
SetPrintColor(255, 0, 0, 255)
SetRandomSeed(GetUnixTime())
SetScissor(0, 0, 0, 0)
SetSyncRate(60, 0)
SetVirtualResolution(1080, 2400)
SetWindowAllowResize(1)
SetWindowSize(FindResolutionWidth("Samsung S9") * 0.26, FindResolutionHeight("Samsung S9") * 0.26, 0)
//SetWindowSize(FindResolutionWidth("iPad 7th Gen") * 0.33, FindResolutionHeight("iPad 7th Gen") * 0.33, 0)
//SetWindowSize(640, 960, 0)
SetWindowTitle("")
UseNewDefaultFonts(1)
Sync()

#constant GAME_PHASE_INITIATE_HOME_SCREEN 1
#constant GAME_PHASE_HOME_SCREEN 2
#constant GAME_PHASE_INITIATE_LEVEL 3
#constant GAME_PHASE_PLAYING 4
#constant GAME_PHASE_TILES_UNLOCKED 5
#constant GAME_PHASE_PAUSED 6
#constant GAME_PHASE_TILE_TRAY_FULL 7
#constant GAME_PHASE_TIMES_UP 8
#constant GAME_PHASE_LEVEL_FAILED 9
#constant GAME_PHASE_COMPLETED_LEVEL 10

#insert "..\Zest-Framework\Zest.agc"
#insert "..\Zest-Framework\ZestImageButton.agc"
#insert "..\Zest-Framework\ZestSprite.agc"
#insert "..\Zest-Framework\ZestText.agc"
#insert "..\Zest-Framework\ZestTouch.agc"

#insert "types.agc"
#insert "globals.agc"
#insert "images.agc"
#insert "sounds.agc"
#insert "fonts.agc"

LoadConsentStatusAdMob("pub-xxxxxxxxxxxxxxxx", "https://yourdomain.com/privacy-policy.htm")
while (GetConsentStatusAdMob() < 0)
	Sync()
endwhile
if (GetConsentStatusAdMob() = 0) 
	RequestConsentAdMob()
	local timeout# as float : timeout# = Timer() + 1
	while (GetConsentStatusAdMob() < 0 and Timer() < timeout#)
		Sync()
	endwhile
endif
	
SetAdMobDetails("ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx")
SetAdMobRewardAdDetails("ca-app-pub-xxxxxxxxxxxxxxxx/xxxxxxxxxx")
//SetAdMobTesting(1)
SetAdvertVisible(0)
CreateAdvert(0, 1, 2, 1)
RequestAdvertRefresh()

//ResetData()

CalculateTileSize()
LoadTileImages()

//GameCenterSetup() 
//GameCenterLogin()

game[0].phase = GAME_PHASE_INITIATE_HOME_SCREEN
do
	print("")

	if (GetResumed() and game[0].paused = 0)
		game[0].minimisedDuration = game[0].minimisedDuration + (GetMilliseconds() - game[0].lastFrameTime)
	endif
	
	RewardAdListener()

	select game[0].phase
		case GAME_PHASE_INITIATE_HOME_SCREEN
			InitiateHomeScreen()
			game[0].phase = GAME_PHASE_HOME_SCREEN
		endcase
		
		case GAME_PHASE_HOME_SCREEN
			UpdateHomeScreen()
			
			ZestImageButtonListener(homeScreen.shopButton)
			if (ZestGetImageButtonReleased(homeScreen.shopButton))
				CreateShopWindow(0)
			endif
			
			ZestImageButtonListener(homeScreen.playButton)
			if (ZestGetImageButtonReleased(homeScreen.playButton))
				DeleteHomeScreen()
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
			endif
			
			ZestImageButtonListener(homeScreen.scoreboardButton)
			if (ZestGetImageButtonReleased(homeScreen.scoreboardButton))
				//GameCenterShowLeaderBoard("CgkIno6a1dkeEAIQAQ")
			endif
			
			// SHOP
			// TOOLS
			ZestImageButtonListener(shopWindow.tabs[0])
			if (ZestGetImageButtonReleased(shopWindow.tabs[0]) and shopWindow.selectedTab <> 0)
				DeleteShopWindow()
				CreateShopWindow(0)
			endif
			ZestImageButtonListener(shopWindow.rewindBuyFreeButton)
			if (ZestGetImageButtonReleased(shopWindow.rewindBuyFreeButton))
				adReward = "Free Shop Rewind"
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			ZestImageButtonListener(shopWindow.rewindBuy2Button)
			if (ZestGetImageButtonReleased(shopWindow.rewindBuy2Button))
				game[0].rewindTools = game[0].rewindTools + 2
				game[0].safeCoins = game[0].safeCoins - 200
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.rewindBuy5Button)
			if (ZestGetImageButtonReleased(shopWindow.rewindBuy5Button))
				game[0].rewindTools = game[0].rewindTools + 5
				game[0].safeCoins = game[0].safeCoins - 400
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.findBuyFreeButton)
			if (ZestGetImageButtonReleased(shopWindow.findBuyFreeButton))
				adReward = "Free Shop Find"
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			ZestImageButtonListener(shopWindow.findBuy2Button)
			if (ZestGetImageButtonReleased(shopWindow.findBuy2Button))
				game[0].findTools = game[0].findTools + 2
				game[0].safeCoins = game[0].safeCoins - 200
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.findBuy5Button)
			if (ZestGetImageButtonReleased(shopWindow.findBuy5Button))
				game[0].findTools = game[0].findTools + 5
				game[0].safeCoins = game[0].safeCoins - 400
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.shuffleBuyFreeButton)
			if (ZestGetImageButtonReleased(shopWindow.shuffleBuyFreeButton))
				adReward = "Free Shop Shuffle"
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			ZestImageButtonListener(shopWindow.shuffleBuy2Button)
			if (ZestGetImageButtonReleased(shopWindow.shuffleBuy2Button))
				game[0].shuffleTools = game[0].shuffleTools + 2
				game[0].safeCoins = game[0].safeCoins - 200
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.shuffleBuy5Button)
			if (ZestGetImageButtonReleased(shopWindow.shuffleBuy5Button))
				game[0].shuffleTools = game[0].shuffleTools + 5
				game[0].safeCoins = game[0].safeCoins - 400
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.freezeBuyFreeButton)
			if (ZestGetImageButtonReleased(shopWindow.freezeBuyFreeButton))
				adReward = "Free Shop Freeze"
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			ZestImageButtonListener(shopWindow.freezeBuy2Button)
			if (ZestGetImageButtonReleased(shopWindow.freezeBuy2Button))
				game[0].freezeTools = game[0].freezeTools + 2
				game[0].safeCoins = game[0].safeCoins - 200
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			ZestImageButtonListener(shopWindow.freezeBuy5Button)
			if (ZestGetImageButtonReleased(shopWindow.freezeBuy5Button))
				game[0].freezeTools = game[0].freezeTools + 5
				game[0].safeCoins = game[0].safeCoins - 400
				PlaySound(coinSound)
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				game.save("game.json")
				UpdateShopWindow()
			endif
			
			// TILE SETS
			ZestImageButtonListener(shopWindow.tabs[1])
			if (ZestGetImageButtonReleased(shopWindow.tabs[1]) and shopWindow.selectedTab <> 1)
				DeleteShopWindow()
				CreateShopWindow(1)
			endif
			for i = 1 to 2
				ZestImageButtonListener(shopWindow.tileSetBuyButton[i])
				if (ZestGetImageButtonReleased(shopWindow.tileSetBuyButton[i]))
					if (game[0].selectedTileSet = ((shopWindow.pageNumber - 1) * 2) + i)
					
					elseif (game[0].tileSetsUnlocked[((shopWindow.pageNumber - 1) * 2) + i] = 1)
						game[0].selectedTileSet = ((shopWindow.pageNumber - 1) * 2) + i
						game.save("game.json")
						UpdateShopWindow()
					else
						if (game[0].safeCoins >= 1500)
							game[0].safeCoins = game[0].safeCoins - 1500
							PlaySound(coinSound)
							game[0].selectedTileSet = ((shopWindow.pageNumber - 1) * 2) + i
							game[0].tileSetsUnlocked[((shopWindow.pageNumber - 1) * 2) + i] = 1
							//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
							game.save("game.json")
							UpdateShopWindow()
						endif
					endif
				endif
			next
			
			// BACKDROPS
			ZestImageButtonListener(shopWindow.tabs[2])
			if (ZestGetImageButtonReleased(shopWindow.tabs[2]) and shopWindow.selectedTab <> 2)
				DeleteShopWindow()
				CreateShopWindow(2)
			endif
			for i = 1 to 4
				ZestImageButtonListener(shopWindow.backgroundBuyButton[i])
				if (ZestGetImageButtonReleased(shopWindow.backgroundBuyButton[i]))
					if (game[0].selectedBackground = ((shopWindow.pageNumber - 1) * 4) + i)
					
					elseif (game[0].backgroundsUnlocked[((shopWindow.pageNumber - 1) * 4) + i] = 1)
						game[0].selectedBackground = ((shopWindow.pageNumber - 1) * 4) + i
						ZestUpdateSprite(homeScreen.backgroundSprite, "image:" + str(backgroundImage[game[0].selectedBackground]))
						game.save("game.json")
						UpdateShopWindow()
					else
						if (game[0].safeCoins >= 500)
							game[0].safeCoins = game[0].safeCoins - 500
							PlaySound(coinSound)
							game[0].selectedBackground = ((shopWindow.pageNumber - 1) * 4) + i
							game[0].backgroundsUnlocked[((shopWindow.pageNumber - 1) * 4) + i] = 1
							ZestUpdateSprite(homeScreen.backgroundSprite, "image:" + str(backgroundImage[game[0].selectedBackground]))
							//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
							game.save("game.json")
							UpdateShopWindow()
						endif
					endif
				endif
			next
			for i = 1 to 3
				ZestImageButtonListener(shopWindow.pageButton[i])
				if (ZestGetImageButtonReleased(shopWindow.pageButton[i]))
					shopWindow.pageNumber = i
					UpdateShopWindow()
				endif
			next
			
			// CLOSE BUTTON
			ZestImageButtonListener(shopWindow.closeButton)
			if (ZestGetImageButtonReleased(shopWindow.closeButton))
				DeleteShopWindow()
			endif
		endcase
		
		case GAME_PHASE_INITIATE_LEVEL
			InitiateLevel()
			game[0].phase = GAME_PHASE_PLAYING
			RequestAdvertRefresh()
		endcase
		
		case GAME_PHASE_PLAYING
			UpdateLevelScene()
			CheckIfUnlockedTiles()
			
			// PAUSE BUTTON
			ZestImageButtonListener(levelScene.pauseButton)
			if (ZestGetImageButtonReleased(levelScene.pauseButton))
				PauseTimer()
				CreatePauseWindow()
				game[0].phase = GAME_PHASE_PAUSED
			endif
			
			// REWIND BUTTON
			ZestImageButtonListener(levelScene.rewindButton)
			if (ZestGetImageButtonReleased(levelScene.rewindButton))
				if (game[0].rewindTools > 0)
					if (rewindHistory.length >= 0)
						dec game[0].rewindTools
						game.save("game.json")
						Rewind(1)
					endif
				else
					PauseTimer()
					CreateAddToolsWindow("Rewind")
				endif
			endif
			
			// FIND BUTTON
			ZestImageButtonListener(levelScene.findButton)
			if (ZestGetImageButtonReleased(levelScene.findButton))
				if (game[0].findTools > 0)
					game[0].timeLastUsedFindTool = GetMilliseconds()
					dec game[0].findTools
					game.save("game.json")
					tilesToFind = 0
					if (tray.length > 1)
						tileImageToFind = 0
						pairInTray = 0
						for i = tray.length to 1 step -1
							if (pairInTray = 0)
								tileImageToFind = tray[i].image
							endif
							if (tray[i - 1].image = tray[i].image)
								pairInTray = 1
								tileImageToFind = tray[i].image
							endif
						next
						tilesToFind = 2
						if (pairInTray = 1) then tilesToFind = 1
					elseif (tiles.length > 0)
						tileImageToFind = tiles[Random(0, tiles.length)].image
						tilesToFind = 3
					endif
					for a = 1 to tilesToFind
						for b = 0 to tiles.length
							if (tiles[b].image = tileImageToFind)
								trayIndex = tray.length
								for i = tray.length to 1 step - 1
									if (tray[i].image = tiles[b].image)
										trayIndex = i + 1
										exit
									endif
								next
								SetSpriteDepth(tiles[b].sprite, 19)
								inc game[0].tilesInTray
								tray.insert(blankTile, trayIndex)
								tray[trayIndex].id = tiles[b].id
								tray[trayIndex].angle = tiles[b].angle
								tray[trayIndex].depth = tiles[b].depth
								tray[trayIndex].group = tiles[b].group
								tray[trayIndex].image = tiles[b].image
								tray[trayIndex].position.x = tiles[b].position.x
								tray[trayIndex].position.y = tiles[b].position.y
								tray[trayIndex].sprite = tiles[b].sprite
								tray[trayIndex].tween = tiles[b].tween
								tray[trayIndex].tween = CreateTweenSprite(0.2)
								SetTweenSpriteX(tray[trayIndex].tween, GetSpriteX(tray[trayIndex].sprite), GetSpriteX(levelScene.traySprite) + PercentageToVirtualWidth(1.3) + ((trayIndex - 1) * PercentageToVirtualWidth(13)), TweenLinear())
								SetTweenSpriteY(tray[trayIndex].tween, GetSpriteY(tray[trayIndex].sprite), GetSpriteY(levelScene.traySprite) + PercentageToVirtualHeight(0.4), TweenLinear())
								SetTweenSpriteSizeX(tray[trayIndex].tween, GetSpriteWidth(tray[trayIndex].sprite), trayTileSize.x, TweenLinear())
								SetTweenSpriteSizeY(tray[trayIndex].tween, GetSpriteHeight(tray[trayIndex].sprite), trayTileSize.y, TweenLinear())
								if (GetSpriteAngle(tray[trayIndex].sprite) <= 180)
									SetTweenSpriteAngle(tray[trayIndex].tween, GetSpriteAngle(tray[trayIndex].sprite), 0, TweenLinear())
								else
									SetTweenSpriteAngle(tray[trayIndex].tween, GetSpriteAngle(tray[trayIndex].sprite), 360, TweenLinear())
								endif
								if (a = 1)
									PlayTweenSprite(tray[trayIndex].tween, tray[trayIndex].sprite, 0)
								elseif (a = 2)
									PlayTweenSprite(tray[trayIndex].tween, tray[trayIndex].sprite, 0.2)
								else
									PlayTweenSprite(tray[trayIndex].tween, tray[trayIndex].sprite, 0.4)
								endif
								tiles.remove(b)
								exit
							endif
						next
					next
				else
					PauseTimer()
					CreateAddToolsWindow("Find")
				endif
			endif
			
			// SHUFFLE BUTTON
			ZestImageButtonListener(levelScene.shuffleButton)
			if (ZestGetImageButtonReleased(levelScene.shuffleButton))
				if (game[0].shuffleTools > 0)
					dec game[0].shuffleTools
					game.save("game.json")
					ShuffleTiles()
					PlaceTiles()
				else
					PauseTimer()
					CreateAddToolsWindow("Shuffle")
				endif
			endif
			
			// FREEZE BUTTON
			ZestImageButtonListener(levelScene.freezeButton)
			if (ZestGetImageButtonReleased(levelScene.freezeButton))
				if (game[0].freezeTools > 0)
					//if (game[0].freezeTimer = 0)
						if (game[0].paused = 0)
							dec game[0].freezeTools
							game.save("game.json")
							game[0].freezeTimer = 1
							game[0].timeFrozen = GetMilliseconds()
						endif
					//endif
				else
					PauseTimer()
					CreateAddToolsWindow("Freeze")
				endif
			endif
			
			// WATCH AD BUTTON (ADD TOOLS)
			ZestImageButtonListener(addToolsWindow.watchAdButton)
			if (ZestGetImageButtonReleased(addToolsWindow.watchAdButton))
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			
			// BUY TOOL BUTTON
			ZestImageButtonListener(addToolsWindow.buyButton)
			if (ZestGetImageButtonReleased(addToolsWindow.buyButton))
				if (game[0].safeCoins + game[0].levelCoins >= 200)
					game[0].levelCoins = game[0].levelCoins - 200
					if (game[0].levelCoins < 0)
						game[0].safeCoins = game[0].safeCoins - abs(game[0].levelCoins)
						game[0].levelCoins = 0
					endif
					if (lower(addToolsWindow.toolShown) = "rewind") then game[0].rewindTools = game[0].rewindTools + 2
					if (lower(addToolsWindow.toolShown) = "find") then game[0].findTools = game[0].findTools + 2
					if (lower(addToolsWindow.toolShown) = "shuffle") then game[0].shuffleTools = game[0].shuffleTools + 2
					if (lower(addToolsWindow.toolShown) = "freeze") then game[0].freezeTools = game[0].freezeTools + 2
					game.save("game.json")
					UnpauseTimer()
					DeleteAddToolsWindow()
				endif
			endif
			
			// CLOSE ADD MORE TOOLS WINDOW BUTTON
			ZestImageButtonListener(addToolsWindow.closeButton)
			if (ZestGetImageButtonReleased(addToolsWindow.closeButton))
				UnpauseTimer()
				DeleteAddToolsWindow()
			endif
			
			// TOUCH ACTIONS
			if (GetPointerPressed() = 1)
				spriteHit = GetSpriteHit(GetPointerX(), GetPointerY())
			else
				if (GetPointerState() = 1)
					
				endif
				if (GetPointerReleased() = 1)
					spriteReleased = GetSpriteHit(GetPointerX(), GetPointerY())
					if (spriteHit > 0 and spriteReleased > 0)
						if (spriteReleased = spriteHit)
							// TILES RELEASED
							if (game[0].phase = GAME_PHASE_PLAYING and game[0].paused = 0)
								tileHit = 0
								for i = 0 to tiles.length
									if (tiles[i].sprite > 0)
										if (tiles[i].sprite = spriteHit)
											tileHitIndex = i
											tileHit = 1
											SetSpriteDepth(tiles[tileHitIndex].sprite, 19)
											if (game[0].sound = 1) then PlaySound(popSound)
											inc game[0].tilesInTray
											exit
										endif
									endif
								next
								if (tileHit = 1)
									trayIndex = tray.length
									for i = tray.length to 1 step - 1
										if (tray[i].image = tiles[tileHitIndex].image)
											trayIndex = i + 1
											exit
										endif
									next
									tray.insert(blankTile, trayIndex)
									tray[trayIndex].id = tiles[tileHitIndex].id
									tray[trayIndex].angle = tiles[tileHitIndex].angle
									tray[trayIndex].depth = tiles[tileHitIndex].depth
									tray[trayIndex].group = tiles[tileHitIndex].group
									tray[trayIndex].image = tiles[tileHitIndex].image
									tray[trayIndex].position.x = tiles[tileHitIndex].position.x
									tray[trayIndex].position.y = tiles[tileHitIndex].position.y
									tray[trayIndex].sprite = tiles[tileHitIndex].sprite
									tray[trayIndex].tween = tiles[tileHitIndex].tween
									tray[trayIndex].tween = CreateTweenSprite(0.2)
									SetTweenSpriteX(tray[trayIndex].tween, GetSpriteX(tray[trayIndex].sprite), GetSpriteX(levelScene.traySprite) + PercentageToVirtualWidth(1.3) + ((trayIndex - 1) * PercentageToVirtualWidth(13)), TweenLinear())
									SetTweenSpriteY(tray[trayIndex].tween, GetSpriteY(tray[trayIndex].sprite), GetSpriteY(levelScene.traySprite) + PercentageToVirtualHeight(0.4), TweenLinear())
									SetTweenSpriteSizeX(tray[trayIndex].tween, GetSpriteWidth(tray[trayIndex].sprite), trayTileSize.x, TweenLinear())
									SetTweenSpriteSizeY(tray[trayIndex].tween, GetSpriteHeight(tray[trayIndex].sprite), trayTileSize.y, TweenLinear())
									if (GetSpriteAngle(tray[trayIndex].sprite) <= 180)
										SetTweenSpriteAngle(tray[trayIndex].tween, GetSpriteAngle(tray[trayIndex].sprite), 0, TweenLinear())
									else
										SetTweenSpriteAngle(tray[trayIndex].tween, GetSpriteAngle(tray[trayIndex].sprite), 360, TweenLinear())
									endif
									PlayTweenSprite(tray[trayIndex].tween, tray[trayIndex].sprite, 0)
									tiles.remove(tileHitIndex)
									rewindHistory.insert(tray[trayIndex].id)
								endif
							endif
						endif
					endif
					spriteHit = 0
					spriteOver = 0
					spriteReleased = 0
				endif
			endif
			UpdateTray()
			
			// TIME RAN OUT
			if (game[0].phase = GAME_PHASE_PLAYING and game[0].timeToComplete - game[0].timeElapsed <= 0 and tiles.length >= 0)
				game[0].phase = GAME_PHASE_TIMES_UP
				PauseTimer()
				CreateTimesUpWindow()
			endif
			
			// TILE TRAY FULL
			if (game[0].phase = GAME_PHASE_PLAYING and game[0].tweensRunning = 0 and game[0].tilesInTray >= 7 and matchFound = 0)
				game[0].phase = GAME_PHASE_TILE_TRAY_FULL
				PauseTimer()
				CreateTrayFullWindow()
			endif
	
			// LEVEL COMPLETED
			if (game[0].phase = GAME_PHASE_PLAYING and tiles.length = -1 and game[0].tilesInTray = 0)
				//PauseTimer()
				if (game[0].timeToComplete - game[0].timeElapsed > 0 and GetMilliseconds() >= game[0].timeSinceRemoved + 150)
					game[0].timeRemoved = game[0].timeRemoved - 10000
					game[0].timeSinceRemoved = GetMilliseconds()
					CreateCoinTweens(1, GetSpriteX(levelScene.timerSprite) + PercentageToVirtualWidth(1), GetSpriteY(levelScene.timerSprite) + PercentageToVirtualHeight(0.75))
					PlaySound(clockTickSound)
				endif
			endif
			if (game[0].phase = GAME_PHASE_PLAYING and game[0].tweensRunning = 0 and coinTweens.length = -1 and tiles.length = -1 and game[0].tilesInTray = 0)
				game[0].phase = GAME_PHASE_COMPLETED_LEVEL
				if (game[0].timeElapsed < stats[0].bestTimeBySetsCount[game[0].levelSets] or stats[0].bestTimeBySetsCount[game[0].levelSets] = 0)
					stats[0].bestTimeBySetsCount[game[0].levelSets] = game[0].timeElapsed
					stats.save("stats.json")
				endif
				PauseTimer()
				DeleteSprite(levelScene.multiplierBarSprite)
				DeleteText(levelScene.multiplierText)
				CreateCompletedLevelWindow()
			endif						
		endcase
		
		case GAME_PHASE_TILES_UNLOCKED
			// CLOSE TILES UNLOCKED WINDOW BUTTON
			ZestImageButtonListener(tilesUnlockedWindow.closeButton)
			if (ZestGetImageButtonReleased(tilesUnlockedWindow.closeButton))
				UnpauseTimer()
				DeleteTilesUnlockedWindow()
				game[0].phase = GAME_PHASE_PLAYING
			endif
			
			// CLAIM TILES BUTTON
			ZestImageButtonListener(tilesUnlockedWindow.claimButton)
			if (ZestGetImageButtonReleased(tilesUnlockedWindow.claimButton))
				UnpauseTimer()
				DeleteTilesUnlockedWindow()
				game[0].phase = GAME_PHASE_PLAYING
			endif
		endcase
		
		case GAME_PHASE_PAUSED
			// CLOSE PAUSE WINDOW BUTTON
			ZestImageButtonListener(pauseWindow.closeButton)
			if (ZestGetImageButtonReleased(pauseWindow.closeButton))
				UnpauseTimer()
				DeletePauseWindow()
				game[0].phase = GAME_PHASE_PLAYING
			endif
			
			// SOUND ON/OFF
			ZestImageButtonListener(pauseWindow.soundButton)
			if (ZestGetImageButtonReleased(pauseWindow.soundButton))
				if (game[0].sound = 0)
					game[0].sound = 1
					ZestUpdateImageButton(pauseWindow.soundButton, "image:" + str(soundOnButtonImage) + ";hoverImage:" + str(soundOnButtonHoverImage))
				else
					game[0].sound = 0
					ZestUpdateImageButton(pauseWindow.soundButton, "image:" + str(soundOffButtonImage) + ";hoverImage:" + str(soundOffButtonHoverImage))
				endif
				game.save("game.json")
			endif
			
			// VIBRATE ON/OFF
			ZestImageButtonListener(pauseWindow.vibrateButton)
			if (ZestGetImageButtonReleased(pauseWindow.vibrateButton))
				if (game[0].vibrate = 0)
					game[0].vibrate = 1
					ZestUpdateImageButton(pauseWindow.vibrateButton, "image:" + str(vibrateOnButtonImage) + ";hoverImage:" + str(vibrateOnButtonHoverImage))
				else
					game[0].vibrate = 0
					ZestUpdateImageButton(pauseWindow.vibrateButton, "image:" + str(vibrateOffButtonImage) + ";hoverImage:" + str(vibrateOffButtonHoverImage))
				endif
				game.save("game.json")
			endif
			
			// RESTART BUTTON
			ZestImageButtonListener(pauseWindow.restartButton)
			if (ZestGetImageButtonReleased(pauseWindow.restartButton))
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
				game[0].paused = 0
				DeletePauseWindow()
			endif
			
			// HOME BUTTON
			ZestImageButtonListener(pauseWindow.homeButton)
			if (ZestGetImageButtonReleased(pauseWindow.homeButton))
				game[0].phase = GAME_PHASE_INITIATE_HOME_SCREEN
				game[0].paused = 0
				DeletePauseWindow()
			endif
		endcase
		
		case GAME_PHASE_TILE_TRAY_FULL
			// CLOSE TILE TRAY FULL WINDOW BUTTON
			ZestImageButtonListener(trayFullWindow.closeButton)
			if (ZestGetImageButtonReleased(trayFullWindow.closeButton))
				DeleteTrayFullWindow()
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
			endif
			
			// WATCH AD BUTTON (CLEAR TILE TRAY)
			ZestImageButtonListener(trayFullWindow.watchAdButton)
			if (ZestGetImageButtonReleased(trayFullWindow.watchAdButton))
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			
			// BUY BUTTON
			ZestImageButtonListener(trayFullWindow.buyButton)
			if (ZestGetImageButtonReleased(trayFullWindow.buyButton))
				if (game[0].safeCoins + game[0].levelCoins >= 200)
					game[0].levelCoins = game[0].levelCoins - 200
					if (game[0].levelCoins < 0)
						game[0].safeCoins = game[0].safeCoins - abs(game[0].levelCoins)
						game[0].levelCoins = 0
					endif
					//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
					game.save("game.json")
					DeleteTrayFullWindow()
					Rewind(game[0].tilesInTray)
					UnpauseTimer()
					game[0].phase = GAME_PHASE_PLAYING
				endif
			endif
			
			// RESTART BUTTON
			ZestImageButtonListener(trayFullWindow.restartButton)
			if (ZestGetImageButtonReleased(trayFullWindow.restartButton))
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
				DeleteTrayFullWindow()
			endif
		endcase
		
		case GAME_PHASE_TIMES_UP
			// CLOSE TIMES UP WINDOW BUTTON
			ZestImageButtonListener(timesUpWindow.closeButton)
			if (ZestGetImageButtonReleased(timesUpWindow.closeButton))
				DeleteTimesUpWindow()
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
			endif
			
			// WATCH AD BUTTON (ADD 60 SECONDS)
			ZestImageButtonListener(timesUpWindow.watchAdButton)
			if (ZestGetImageButtonReleased(timesUpWindow.watchAdButton))
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			
			// BUY BUTTON
			ZestImageButtonListener(timesUpWindow.buyButton)
			if (ZestGetImageButtonReleased(timesUpWindow.buyButton))
				if (game[0].safeCoins + game[0].levelCoins >= 200)
					game[0].levelCoins = game[0].levelCoins - 200
					if (game[0].levelCoins < 0)
						game[0].safeCoins = game[0].safeCoins - abs(game[0].levelCoins)
						game[0].levelCoins = 0
					endif
					//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
					game.save("game.json")
					DeleteTimesUpWindow()
					game[0].timeAdded = game[0].timeAdded + 60000
					UnpauseTimer()
					game[0].phase = GAME_PHASE_PLAYING
				endif
			endif
			
			// RESTART BUTTON
			ZestImageButtonListener(timesUpWindow.restartButton)
			if (ZestGetImageButtonReleased(timesUpWindow.restartButton))
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
				DeleteTimesUpWindow()
			endif
		endcase
		
		case GAME_PHASE_LEVEL_FAILED
			
		endcase
		
		case GAME_PHASE_COMPLETED_LEVEL
			// CLAIM X2 BUTTON
			ZestImageButtonListener(completedLevelWindow.claimX2Button)
			if (ZestGetImageButtonReleased(completedLevelWindow.claimX2Button))
				watchingRewardAd = 1
				ShowRewardAdAdMob()
			endif
			
			// CLAIM BUTTON
			ZestImageButtonListener(completedLevelWindow.claimButton)
			if (ZestGetImageButtonReleased(completedLevelWindow.claimButton))
				game[0].safeCoins = game[0].safeCoins + game[0].levelCoins
				//GameCenterSubmitScore(game[0].safeCoins, "CgkIno6a1dkeEAIQAQ")
				if (game[0].levelCoins > stats[0].mostCoinsCollectedInALevel)
					stats[0].mostCoinsCollectedInALevel = game[0].levelCoins
					stats.save("stats.json")
				endif
				inc game[0].level[game[0].selectedTileSet]
				if (game[0].selectedTileSet = 1)
					//GameCenterSubmitScore(game[0].level[1], "CgkIno6a1dkeEAIQAg")
				elseif (game[0].selectedTileSet = 2)
					//GameCenterSubmitScore(game[0].level[2], "CgkIno6a1dkeEAIQAw")
				endif	
				game.save("game.json")
				game[0].phase = GAME_PHASE_INITIATE_LEVEL
				DeleteCompletedLevelWindow()
			endif
		endcase
	endselect	
	
	DeleteCoinTweens()

	game[0].lastFrameTime = GetMilliseconds()
	ZestSync()
loop

#include "functions.agc"