"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #ClippedItem
	instanceVariableNames: 'id position extent'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ClippedItem guid: (GUID fromString: '{E2C013EB-6FD2-4E5B-88E3-6832F51BD088}')!
ClippedItem comment: ''!
!ClippedItem categoriesForClass!Kernel-Objects! !
!ClippedItem methodsFor!

extent
	^extent!

extent: anObject
	extent := anObject!

id
	^id!

id: anObject
	id := anObject!

position
	^position!

position: anObject
	position := anObject! !
!ClippedItem categoriesFor: #extent!accessing!private! !
!ClippedItem categoriesFor: #extent:!accessing!private! !
!ClippedItem categoriesFor: #id!accessing!private! !
!ClippedItem categoriesFor: #id:!accessing!private! !
!ClippedItem categoriesFor: #position!accessing!private! !
!ClippedItem categoriesFor: #position:!accessing!private! !

!ClippedItem class methodsFor!

id: id position: position extent: extent
	^(self new)
		id: id;
		position: position;
		extent: extent;
		yourself! !
!ClippedItem class categoriesFor: #id:position:extent:!public! !

