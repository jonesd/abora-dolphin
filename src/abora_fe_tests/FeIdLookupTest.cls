"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeIdLookupTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeIdLookupTest guid: (GUID fromString: '{736CF3F1-3FD5-4D5B-8F01-3CF956C8D30C}')!
FeIdLookupTest comment: ''!
!FeIdLookupTest categoriesForClass!SUnit! !
!FeIdLookupTest methodsFor!

testCurrent
	| lookup |
	lookup := FeIdLookup current.
	self should: [lookup notNil].!

testLookupId
	| lookup beEdition feEdition |
	lookup := FeIdLookup current.
	beEdition := BeEdition new.
	self should: [lookup lookupId: beEdition id] raise: NotFoundError.
	feEdition := FeEdition on: beEdition.
	self should: [(lookup lookupId: beEdition id) == feEdition].	! !
!FeIdLookupTest categoriesFor: #testCurrent!public! !
!FeIdLookupTest categoriesFor: #testLookupId!public! !

