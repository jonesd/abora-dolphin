"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Model subclass: #FeAboraSystem
	instanceVariableNames: 'preferences'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeAboraSystem guid: (GUID fromString: '{C525A213-55B0-4FDF-BBED-C8A58F853D52}')!
FeAboraSystem comment: ''!
!FeAboraSystem categoriesForClass!MVP-Models! !
!FeAboraSystem methodsFor!

initialize
	super initialize.

	preferences := FePreferences new.
!

preferences
	^preferences
! !
!FeAboraSystem categoriesFor: #initialize!private! !
!FeAboraSystem categoriesFor: #preferences!public! !

!FeAboraSystem class methodsFor!

current
	^Current!

initialize
"Private - 
self  initialize.
"

	Current := self new.! !
!FeAboraSystem class categoriesFor: #current!public! !
!FeAboraSystem class categoriesFor: #initialize!private! !

