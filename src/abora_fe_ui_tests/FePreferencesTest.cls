"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #FePreferencesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FePreferencesTest guid: (GUID fromString: '{3F5C9EBD-3F07-4961-AF00-CEE8F8FF3DE4}')!
FePreferencesTest comment: ''!
!FePreferencesTest categoriesForClass!SUnit! !
!FePreferencesTest methodsFor!

testCreate
	| preferences |
	preferences := FePreferences new.
	self should: [preferences notNil].
	self should: [preferences comparisonFollowsPoint notNil].! !
!FePreferencesTest categoriesFor: #testCreate!public! !

