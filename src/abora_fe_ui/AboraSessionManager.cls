"Filed out from Dolphin Smalltalk 2002 release 5.00"!

RuntimeSessionManager subclass: #AboraSessionManager
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraSessionManager guid: (GUID fromString: '{7CC0D375-22D3-43A6-AFC3-7966E690F5A5}')!
AboraSessionManager comment: ''!
!AboraSessionManager categoriesForClass!System-Support! !
!AboraSessionManager methodsFor!

defaultResLibPath
        ^self argv first!

main
	| shell splash |
	
	[splash := self showControlledSplash.
	self setFeConnection isNil ifTrue: [^nil].
	shell := self mainShellClass show.
	shell saveOnClose: true] 
			ensure: [splash notNil ifTrue: [splash close]].
	^shell!

setFeConnection
	| connection |
	connection := FindBeServerDialog showModal.
	connection isNil ifTrue: [^nil].
	FeConnection current: (FeBackgroundConnection onConnection: connection)!

showControlledSplash
	| splash bitmap |
	bitmap := DIBSection width: 200 height: 100.
	(bitmap canvas)
		setTextColor: Color white;
		setBkMode: TRANSPARENT;
		text: 'Abora Client starting...' at: 20 @ 40.
	splash := (Splash new)
				bitmap: bitmap;
				yourself.
	splash show.
	^splash! !
!AboraSessionManager categoriesFor: #defaultResLibPath!public! !
!AboraSessionManager categoriesFor: #main!public! !
!AboraSessionManager categoriesFor: #setFeConnection!public! !
!AboraSessionManager categoriesFor: #showControlledSplash!private! !

!AboraSessionManager class methodsFor!

mainShellClass
	"Answer the class of the application's main window (a <Shell> presenter)."

	^FeShell! !
!AboraSessionManager class categoriesFor: #mainShellClass!public! !

