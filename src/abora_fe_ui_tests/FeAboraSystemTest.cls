"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #FeAboraSystemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeAboraSystemTest guid: (GUID fromString: '{6EEFB693-3A10-4D48-B9B0-32D03F0663CA}')!
FeAboraSystemTest comment: ''!
!FeAboraSystemTest categoriesForClass!SUnit! !
!FeAboraSystemTest methodsFor!

testCurrent
	| system |
	system := FeAboraSystem current.
	self should: [system notNil].
	self should: [system preferences notNil].! !
!FeAboraSystemTest categoriesFor: #testCurrent!public! !

