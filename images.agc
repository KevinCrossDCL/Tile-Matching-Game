
global addButtonHoverImage as integer : addButtonHoverImage = LoadImage("add-button-hover.png")
global addButtonImage as integer : addButtonImage = LoadImage("add-button.png")
global backgroundImage as integer[20]
for i = 1 to 12
	backgroundImage[i] = LoadImage("Backgrounds/background-" + AddLeadingZeros(str(i), 3) + ".png")
next
global backgroundsTabSelectedImage as integer : backgroundsTabSelectedImage = LoadImage("backgrounds-tab-selected.png")
global backgroundsTabUnselectedImage as integer : backgroundsTabUnselectedImage = LoadImage("backgrounds-tab-unselected.png")
global buyButtonHoverImage as integer : buyButtonHoverImage = LoadImage("buy-button-hover.png")
global buyButtonImage as integer : buyButtonImage = LoadImage("buy-button.png")
global calendarButtonHoverImage as integer : calendarButtonHoverImage = LoadImage("calendar-button-hover.png")
global calendarButtonImage as integer : calendarButtonImage = LoadImage("calendar-button.png")
global claimButtonHoverImage as integer : claimButtonHoverImage = LoadImage("claim-button-hover.png")
global claimButtonImage as integer : claimButtonImage = LoadImage("claim-button.png")
global claimX2ButtonHoverImage as integer : claimX2ButtonHoverImage = LoadImage("claim-x2-button-hover.png")
global claimX2ButtonImage as integer : claimX2ButtonImage = LoadImage("claim-x2-button.png")
global coinImage as integer : coinImage = LoadImage("coin.png")
global coinsImage as integer : coinsImage = LoadImage("coins.png")
global crateButtonHoverImage as integer : crateButtonHoverImage = LoadImage("crate-button-hover.png")
global crateButtonImage as integer : crateButtonImage = LoadImage("crate-button.png")
global findButtonDisabledImage as integer : findButtonDisabledImage = LoadImage("find-button-disabled.png")
global findButtonHoverImage as integer : findButtonHoverImage = LoadImage("find-button-hover.png")
global findButtonImage as integer : findButtonImage = LoadImage("find-button.png")
global findIconImage as integer : findIconImage = LoadImage("find-icon.png")
global freezeButtonDisabledImage as integer : freezeButtonDisabledImage = LoadImage("freeze-button-disabled.png")
global freezeButtonHoverImage as integer : freezeButtonHoverImage = LoadImage("freeze-button-hover.png")
global freezeButtonImage as integer : freezeButtonImage = LoadImage("freeze-button.png")
global freezeIconImage as integer : freezeIconImage = LoadImage("freeze-icon.png")
global greenRestartButtonHoverImage as integer : greenRestartButtonHoverImage = LoadImage("green-restart-button-hover.png")
global greenRestartButtonImage as integer : greenRestartButtonImage = LoadImage("green-restart-button.png")
global homeButtonHoverImage as integer : homeButtonHoverImage = LoadImage("home-button-hover.png")
global homeButtonImage as integer : homeButtonImage = LoadImage("home-button.png")
global hudCoinImage as integer : hudCoinImage = LoadImage("hud-coin.png")
global hudSafeImage as integer : hudSafeImage = LoadImage("hud-safe.png")
global hudTimerImage as integer : hudTimerImage = LoadImage("hud-timer.png")
global leftHalfCircleImage as integer : leftHalfCircleImage = LoadImage("left-half-circle.png")
global loadingFrame01Image as integer : loadingFrame01Image = LoadImage("loading-frame-01.png")
global loadingFrame02Image as integer : loadingFrame02Image = LoadImage("loading-frame-02.png")
global loadingFrame03Image as integer : loadingFrame03Image = LoadImage("loading-frame-03.png")
global loadingFrame04Image as integer : loadingFrame04Image = LoadImage("loading-frame-04.png")
global loadingFrame05Image as integer : loadingFrame05Image = LoadImage("loading-frame-05.png")
global loadingFrame06Image as integer : loadingFrame06Image = LoadImage("loading-frame-06.png")
global multiplierTrayImage as integer : multiplierTrayImage = LoadImage("multiplier-tray.png")
global multiplierBarImage as integer : multiplierBarImage = LoadImage("multiplier-bar.png")
global orangeRestartButtonHoverImage as integer : orangeRestartButtonHoverImage = LoadImage("orange-restart-button-hover.png")
global orangeRestartButtonImage as integer : orangeRestartButtonImage = LoadImage("orange-restart-button.png")
global pauseButtonHoverImage as integer : pauseButtonHoverImage = LoadImage("pause-button-hover.png")
global pauseButtonImage as integer : pauseButtonImage = LoadImage("pause-button.png")
global playButtonHoverImage as integer : playButtonHoverImage = LoadImage("play-button-hover.png")
global playButtonImage as integer : playButtonImage = LoadImage("play-button.png")
global rewindButtonDisabledImage as integer : rewindButtonDisabledImage = LoadImage("rewind-button-disabled.png")
global rewindButtonHoverImage as integer : rewindButtonHoverImage = LoadImage("rewind-button-hover.png")
global rewindButtonImage as integer : rewindButtonImage = LoadImage("rewind-button.png")
global rewindIconImage as integer : rewindIconImage = LoadImage("rewind-icon.png")
global rightHalfCircleImage as integer : rightHalfCircleImage = LoadImage("right-half-circle.png")
global scoreboardButtonHoverImage as integer : scoreboardButtonHoverImage = LoadImage("scoreboard-button-hover.png")
global scoreboardButtonImage as integer : scoreboardButtonImage = LoadImage("scoreboard-button.png")
global scratchcardButtonHoverImage as integer : scratchcardButtonHoverImage = LoadImage("scratchcard-button-hover.png")
global scratchcardButtonImage as integer : scratchcardButtonImage = LoadImage("scratchcard-button.png")
global selectButtonHoverImage as integer : selectButtonHoverImage = LoadImage("select-button-hover.png")
global selectButtonImage as integer : selectButtonImage = LoadImage("select-button.png")
global selectedButtonHoverImage as integer : selectedButtonHoverImage = LoadImage("selected-button-hover.png")
global selectedButtonImage as integer : selectedButtonImage = LoadImage("selected-button.png")
global settingsButtonHoverImage as integer : settingsButtonHoverImage = LoadImage("settings-button-hover.png")
global settingsButtonImage as integer : settingsButtonImage = LoadImage("settings-button.png")
global shop1500ButtonHoverImage as integer : shop1500ButtonHoverImage = LoadImage("shop-1500-button-hover.png")
global shop1500ButtonImage as integer : shop1500ButtonImage = LoadImage("shop-1500-button.png")
global shop200X2ButtonHoverImage as integer : shop200X2ButtonHoverImage = LoadImage("shop-200-x2-button-hover.png")
global shop200X2ButtonImage as integer : shop200X2ButtonImage = LoadImage("shop-200-x2-button.png")
global shop400X5ButtonHoverImage as integer : shop400X5ButtonHoverImage = LoadImage("shop-400-x5-button-hover.png")
global shop400X5ButtonImage as integer : shop400X5ButtonImage = LoadImage("shop-400-x5-button.png")
global shop500ButtonHoverImage as integer : shop500ButtonHoverImage = LoadImage("shop-500-button-hover.png")
global shop500ButtonImage as integer : shop500ButtonImage = LoadImage("shop-500-button.png")
global shopButtonHoverImage as integer : shopButtonHoverImage = LoadImage("shop-button-hover.png")
global shopButtonImage as integer : shopButtonImage = LoadImage("shop-button.png")
global shopPageButtonHoverImage as integer : shopPageButtonHoverImage = LoadImage("shop-page-button-hover.png")
global shopPageButtonImage as integer : shopPageButtonImage = LoadImage("shop-page-button.png")
global shopFreeX1ButtonHoverImage as integer : shopFreeX1ButtonHoverImage = LoadImage("shop-free-x1-button-hover.png")
global shopFreeX1ButtonImage as integer : shopFreeX1ButtonImage = LoadImage("shop-free-x1-button.png")
global shopTileSetImage as integer[20]
for i = 1 to 2
	shopTileSetImage[i] = LoadImage("shop-tile-set-" + AddLeadingZeros(str(i), 2) + ".png")
next
global shuffleButtonHoverImage as integer : shuffleButtonHoverImage = LoadImage("shuffle-button-hover.png")
global shuffleButtonImage as integer : shuffleButtonImage = LoadImage("shuffle-button.png")
global shuffleIconImage as integer : shuffleIconImage = LoadImage("shuffle-icon.png")
global soundOffButtonHoverImage as integer : soundOffButtonHoverImage = LoadImage("sound-off-button-hover.png")
global soundOffButtonImage as integer : soundOffButtonImage = LoadImage("sound-off-button.png")
global soundOnButtonHoverImage as integer : soundOnButtonHoverImage = LoadImage("sound-on-button-hover.png")
global soundOnButtonImage as integer : soundOnButtonImage = LoadImage("sound-on-button.png")
global statisticsButtonHoverImage as integer : statisticsButtonHoverImage = LoadImage("statistics-button-hover.png")
global statisticsButtonImage as integer : statisticsButtonImage = LoadImage("statistics-button.png")
//global tileHiddenImage as integer : tileHiddenImage = LoadImage("tile-hidden.png")
global tileSetsTabSelectedImage as integer : tileSetsTabSelectedImage = LoadImage("tile-sets-tab-selected.png")
global tileSetsTabUnselectedImage as integer : tileSetsTabUnselectedImage = LoadImage("tile-sets-tab-unselected.png")
global timerFrozenOverlayImage as integer : timerFrozenOverlayImage = LoadImage("timer-tray-frozen-overlay.png")
global timerTrayImage as integer : timerTrayImage = LoadImage("timer-tray.png")
global titleImage as integer : titleImage = LoadImage("title.png")
global toolsTabSelectedImage as integer : toolsTabSelectedImage = LoadImage("tools-tab-selected.png")
global toolsTabUnselectedImage as integer : toolsTabUnselectedImage = LoadImage("tools-tab-unselected.png")
global trayImage as integer : trayImage = LoadImage("tray.png")
global vibrateOffButtonHoverImage as integer : vibrateOffButtonHoverImage = LoadImage("vibrate-off-button-hover.png")
global vibrateOffButtonImage as integer : vibrateOffButtonImage = LoadImage("vibrate-off-button.png")
global vibrateOnButtonHoverImage as integer : vibrateOnButtonHoverImage = LoadImage("vibrate-on-button-hover.png")
global vibrateOnButtonImage as integer : vibrateOnButtonImage = LoadImage("vibrate-on-button.png")
global watchAdButtonHoverImage as integer : watchAdButtonHoverImage = LoadImage("watch-ad-button-hover.png")
global watchAdButtonImage as integer : watchAdButtonImage = LoadImage("watch-ad-button.png")
global windowBottomImage as integer : windowBottomImage = LoadImage("window-bottom.png")
global windowBottomLeftCornerImage as integer : windowBottomLeftCornerImage = LoadImage("window-bottom-left-corner.png")
global windowBottomRightCornerImage as integer : windowBottomRightCornerImage = LoadImage("window-bottom-right-corner.png")
global windowCentreImage as integer : windowCentreImage = LoadImage("window-centre.png")
global windowCloseImage as integer : windowCloseImage = LoadImage("window-close.png")
global windowLeftImage as integer : windowLeftImage = LoadImage("window-left.png")
global windowRightImage as integer : windowRightImage = LoadImage("window-right.png")
global windowTopImage as integer : windowTopImage = LoadImage("window-top.png")
global windowTopLeftCornerImage as integer : windowTopLeftCornerImage = LoadImage("window-top-left-corner.png")
global windowTopRightCornerImage as integer : windowTopRightCornerImage = LoadImage("window-top-right-corner.png")




