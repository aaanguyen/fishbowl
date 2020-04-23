# Fishbowl
Unreleased mobile game app made with Flutter, based on the public domain game of the same name.  

![[Demo gif 1]](demo_gifs/demo01.gif)
![[Demo gif 2]](demo_gifs/demo02.gif)
![[Demo gif 3]](demo_gifs/demo03.gif)
![[Demo gif 4]](demo_gifs/demo04.gif)
![[Demo gif 5]](demo_gifs/demo05.gif)
## Future Plans
- Handle large bodies of text correctly in CardModels
- Support for iOS
- Support for screens of all sorts of dimensions
- Add 'How To Play' screen (simple ListView of game instructions)
- Add 'Options' screen
	- Modify active set of cards (SQLite UPDATE queries)
	- Create and add cards to database (SQLite CREATE/INSERT queries)
- Maybe support for uploading of card metadata (.yaml?)
## Modules Used
- provider (State management)
- sqflite (Offline data storage of card data)
- path_provider (Filesystem navigation for use with SQFLite)
- grouped_buttons (Radio button grouping for game setup)
- carousel_slider (Carousel for card selection phase)
- rflutter_alert (Alert dialogs used as transitions)
## Credits
- Palm Court (Writers of demo base card set)
- gmetekorkmaz on GitHub (swipe_stack module mechanics)
