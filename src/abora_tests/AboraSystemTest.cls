"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #AboraSystemTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraSystemTest guid: (GUID fromString: '{AB08ABD3-E25E-4D00-9A5A-460D9C74BC5E}')!
AboraSystemTest comment: ''!
!AboraSystemTest categoriesForClass!Kernel-Objects! !
!AboraSystemTest methodsFor!

testCurrent
	| system |
	system := AboraSystem current.
	self should: [system notNil].! !
!AboraSystemTest categoriesFor: #testCurrent!public! !

