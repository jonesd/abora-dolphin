"Filed out from Dolphin Smalltalk 2002 release 5.00"!

STBProxy subclass: #STBBeContentElementForBE
	instanceVariableNames: 'id'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
STBBeContentElementForBE guid: (GUID fromString: '{0FE727E8-F7EB-4F44-8957-9D07424EA81A}')!
STBBeContentElementForBE comment: ''!
!STBBeContentElementForBE categoriesForClass!System-Binary storage! !
!STBBeContentElementForBE methodsFor!

id
	^id!

id: anObject
	id := anObject!

stbFixup: inFiler at: anInteger
	"Answer the object that this one represents.
	We must not use #become: to swap the receiver with the represented
	object. We need to tell inFiler to replace its readMap entry for our answer."

	| be |
	be := self value.
	inFiler fixup: anInteger to: be.
	^be!

value
	^WorksStorage current lookupId: self id
! !
!STBBeContentElementForBE categoriesFor: #id!accessing!private! !
!STBBeContentElementForBE categoriesFor: #id:!accessing!private! !
!STBBeContentElementForBE categoriesFor: #stbFixup:at:!public! !
!STBBeContentElementForBE categoriesFor: #value!public! !

!STBBeContentElementForBE class methodsFor!

forId: id
	^(self basicNew)
		id: id;
		yourself! !
!STBBeContentElementForBE class categoriesFor: #forId:!public! !

