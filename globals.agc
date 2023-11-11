
global addToolsWindow as typeAddToolsWindow
global adReward as string
global blankTile as typeTile
global blankTileImage as typeTileImage
global blankTileSet as typeTileImage
global blankTileTray as typeTileTray
global blankTween as typeTweens
global coinTweens as typeTweens[]
global completedLevelWindow as typeCompletedLevelWindow
global filteredTileImages as typeTileImage[]
global game as typeGame[0]
if (GetFileExists("game.json"))
	game.load("game.json")
else
	game[0].backgroundsUnlocked[1] = 1
	game[0].findTools = 3
	game[0].freezeTools = 3
	game[0].safeCoins = 0
	for i = 1 to 20
		game[0].level[i] = 1
		game[0].levelLastUnlockedTiles[i] = 1
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
	game.save("game.json")
endif
global homeScreen as typeHomeScreen
global lastPlayedDing as integer
global levelScene as typeLevelScene
global matchFound as integer
global pauseWindow as typePauseWindow
global rewindHistory as integer[]
global scene as typeScene
global shopWindow as typeShopWindow
global stats as typeStats[0]
if (GetFileExists("stats.json"))
	stats.load("stats.json")
else
	stats[0].bestTimeBySetsCount.length = 100
endif
global tileImages as typeTileImage[3, 256]
global tiles as typeTile[]
global tileSet as typeTileImage[]
global tileSetsList as integer[]
global tilesInTray as integer
global tileSize as typeVector2
global tilesUnlockedWindow as typeTilesUnlockedWindow
global timesUpWindow as typeTimesUpWindow
global tileUnlockedImages as typeTileImage[3, 256]
global tray as typeTile[1]
global trayFullWindow as typeTrayFullWindow
global trayTileSize as typeVector2
global watchingRewardAd as integer
global windowOpen as string

