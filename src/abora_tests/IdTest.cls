"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #IdTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IdTest guid: (GUID fromString: '{655D7686-5F36-4A3A-B65A-3FF86D6083EB}')!
IdTest comment: ''!
!IdTest categoriesForClass!Kernel-Objects! !
!IdTest methodsFor!

testCreate
	| id |
	id := Id nextId.
	self should: [id notNil].!

testCreateEquals
	| id |
	id := Id nextId.

	self should: [id = id].
	self should: [id = id copy].

	self shouldnt: [id = Id nextId].!

testUniqueness
	| values |
	values := Set new.
	20 timesRepeat: 
			[| id |
			id := Id nextId.
			self shouldnt: [values includes: id value].
			values add: id value]! !
!IdTest categoriesFor: #testCreate!public! !
!IdTest categoriesFor: #testCreateEquals!public! !
!IdTest categoriesFor: #testUniqueness!public! !

