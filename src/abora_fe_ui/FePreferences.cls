"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Model subclass: #FePreferences
	instanceVariableNames: 'comparisonFollowsPoint comparisonColors'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FePreferences guid: (GUID fromString: '{DF7583AD-53B4-4BBB-B394-8275C803FF65}')!
FePreferences comment: ''!
!FePreferences categoriesForClass!MVP-Models! !
!FePreferences methodsFor!

comparisonColorStream
	^ ColorStream colors: comparisonColors!

comparisonFollowsPoint
	^comparisonFollowsPoint!

comparisonFollowsPoint: anObject
	comparisonFollowsPoint := anObject!

defaultComparisonColors
	| colors |
	colors := OrderedCollection new.
	colors add: (Color red: 255 green: 215 blue: 215).
	colors add: (Color red: 193 green: 193 blue: 255).
	colors add: (Color red: 204 green: 255 blue: 204).
	colors add: (Color red: 255 green: 206 blue: 255).
	colors add: (Color red: 255 green: 172 blue: 132).
	colors add: (Color red: 164 green: 215 blue: 219).
	colors add: (Color red: 217 green: 193 blue: 185).
	^colors asArray!

initialize
	super initialize.
	comparisonFollowsPoint := true.
	comparisonColors := self defaultComparisonColors.! !
!FePreferences categoriesFor: #comparisonColorStream!public! !
!FePreferences categoriesFor: #comparisonFollowsPoint!accessing!public! !
!FePreferences categoriesFor: #comparisonFollowsPoint:!accessing!private! !
!FePreferences categoriesFor: #defaultComparisonColors!private! !
!FePreferences categoriesFor: #initialize!private! !

