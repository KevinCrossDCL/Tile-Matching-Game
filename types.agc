// File: types.agc

type typeAddToolsWindow
	id as integer
	buyButton as integer
	buyToolCount as typeToolCount
	closeButton as integer
	grid as integer[9]
	scrimSprite as integer
	titleText as integer
	toolShown as string
	toolSprite as integer
	watchAdButton as integer
	watchAdToolCount as typeToolCount
endtype

type typeChip
	id as integer
	centre as integer
	counter as integer
	leftHalf as integer
	rightHalf as integer
endtype

type typeCompletedLevelWindow
	id as integer
	claimButton as integer
	claimX2Button as integer
	//closeButton as integer
	coinsSprite as integer
	grid as integer[9]
	scrimSprite as integer
	titleText as integer
endtype

type typeGame
	backgroundsUnlocked as integer[20]
	findTools as integer
	freezeDuration as integer
	freezeTimer as integer
	freezeTools as integer
	lastFrameTime as integer
	level as integer[20] // level for each tileset
	levelCoins as integer
	levelCoinsMultiplier as integer
	levelLastUnlockedTiles as integer[20] // level for each tileset
	levelSets as integer
	lowestTileDepth as integer
	minimisedDuration as integer
	paused as integer
	pausedDuration as integer
	phase as integer
	rewindTools as integer
	safeCoins as integer
	selectedBackground as integer
	selectedTileSet as integer
	shuffleChip as typeChip
	shuffleTools as integer
	sound as integer
	tileSetsUnlocked as integer[20]
	tilesInTray as integer
	timeAdded as integer
	timeElapsed as integer
	timeFrozen as integer
	timeLastUsedFindTool as integer
	timeLevelStarted as integer
	timePaused as integer
	timeRemoved as integer
	timeSinceRemoved as integer
	timeStartedCoinsMultiplier as integer
	timeToComplete as integer
	tweensRunning as integer
	vibrate as integer
endtype

type typeHomeScreen
	backgroundSprite as integer
	bannerAdBackgroundSprite as integer
	calendarButton as integer
	crateButton as integer
	levelText as integer
	playButton as integer
	safeSprite as integer
	safeCoinsText as integer
	scoreboardButton as integer
	settingsButton as integer
	shopButton as integer
	statisticsButton as integer
	titleSprite as integer
endtype

type typeLevelScene
	backgroundSprite as integer
	bannerAdBackgroundSprite as integer
	findButton as integer
	findButtonCount as typeToolCount
	findButtonLoadingAdAnimation as integer
	freezeButton as integer
	freezeButtonCount as typeToolCount
	freezeButtonLoadingAdAnimation as integer
	levelCoinsMultiplierText as integer
	levelCoinSprite as integer
	levelCoinsText as integer
	levelText as integer
	multiplierBarSprite as integer
	multiplierText as integer
	multiplierTraySprite as integer
	pauseButton as integer
	rewindButton as integer
	rewindButtonCount as typeToolCount
	rewindButtonLoadingAdAnimation as integer
	safeCoinsText as integer
	safeSprite as integer
	shuffleButton as integer
	shuffleButtonCount as typeToolCount
	shuffleButtonLoadingAdAnimation as integer
	timerBackgroundSprite as integer
	timerFrozenOverlaySprite as integer
	timerSprite as integer
	timerText as integer
	timerTotalWidth as float
	traySprite as integer
endtype

type typePauseWindow
	id as integer
	closeButton as integer
	grid as integer[9]
	homeButton as integer
	restartButton as integer
	scrimSprite as integer
	soundButton as integer
	titleText as integer
	vibrateButton as integer
endtype

type typeScene
	background as integer
	tray as integer
endtype

type typeShopWindow
	id as integer
	background as integer[4]
	backgroundBorder as integer[4]
	backgroundBuyButton as integer[4]
	backgroundsTab as integer
	closeButton as integer
	findBuy2Button as integer
	findBuy5Button as integer
	findBuyFreeButton as integer
	findDescription as integer
	findIcon as integer
	findIconTitle as integer
	findIconDescription as integer
	findOwnedSprite as integer
	findOwnedCount as typeToolCount
	findTitle as integer
	freezeBuy2Button as integer
	freezeBuy5Button as integer
	freezeBuyFreeButton as integer
	freezeDescription
	freezeIcon as integer
	freezeIconTitle as integer
	freezeIconDescription as integer
	freezeOwnedSprite as integer
	freezeOwnedCount as typeToolCount
	freezeTitle as integer
	grid as integer[9]
	pageButton as integer[10]
	pageButtonText as integer[10]
	pageNumber as integer
	pageTitle as integer
	rewindBuy2Button as integer
	rewindBuy5Button as integer
	rewindBuyFreeButton as integer
	rewindDescription as integer
	rewindIcon as integer
	rewindIconTitle as integer
	rewindIconDescription as integer
	rewindOwnedSprite as integer
	rewindOwnedCount as typeToolCount
	rewindTitle as integer
	scrimSprite as integer
	selectedTab as integer
	shuffleBuy2Button as integer
	shuffleBuy5Button as integer
	shuffleBuyFreeButton as integer
	shuffleDescription as integer
	shuffleIcon as integer
	shuffleIconTitle as integer
	shuffleIconDescription as integer
	shuffleOwnedSprite as integer
	shuffleOwnedCount as typeToolCount
	shuffleTitle as integer
	tabs as integer[3]
	tabsBottomLine as integer[3]
	tabsBottomShadow as integer[3]
	tabsLeftLine as integer[3]
	tabsLeftShadow as integer[3]
	tabsRightLine as integer[3]
	tabsRightShadow as integer[3]
	tileSetBuyButton as integer[2]
	tileSetDifficulty as integer[2]
	tileSetSprite as integer[2]
	tileSetTitle as integer[2]
endtype

type typeStats
	bestTimeBySetsCount as integer[100]
	highestCoinsMultiplier as integer
	mostCoinsCollectedInALevel as integer
endtype

type typeTile
	sortKey$ as string
	id as integer
	angle as integer
	delete as integer
	depth as integer
	group as integer
	image as integer
	position as typeVector2
	sprite as integer
	tween as integer
endtype

type typeTileImage
	sortKey$ as string
	id as integer
	image as integer
endtype

type typeTilesUnlockedWindow
	id as integer
	claimButton as integer
	closeButton as integer
	grid as integer[9]
	scrimSprite as integer
	tilesUnlocked as integer[10]
	titleText as integer
endtype

type typeTileTray
	image as integer
	index as integer
endtype

type typeTimesUpWindow
	id as integer
	bodyText as integer
	buyButton as integer
	closeButton as integer
	grid as integer[9]
	restartButton as integer
	scrimSprite as integer
	titleText as integer
	watchAdButton as integer
endtype

type typeToolCount
	id as integer
	centreSprite as integer
	counterText as integer
	leftHalfSprite as integer
	rightHalfSprite as integer
endtype

type typeTrayFullWindow
	id as integer
	bodyText as integer
	buyButton as integer
	closeButton as integer
	grid as integer[9]
	restartButton as integer
	scrimSprite as integer
	titleText as integer
	watchAdButton as integer
endtype

type typeTweens
	sprite as integer
	tween as integer
endtype

type typeVector2
	x as float
	y as float
endtype

	
