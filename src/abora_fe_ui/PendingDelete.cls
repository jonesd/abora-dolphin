"Filed out from Dolphin Smalltalk 2002 release 5.00"!

PendingChange subclass: #PendingDelete
	instanceVariableNames: 'startPosition extent'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PendingDelete guid: (GUID fromString: '{70ADDFC0-818D-47BC-BF8C-05E48B462569}')!
PendingDelete comment: ''!
!PendingDelete categoriesForClass!Kernel-Objects! !
!PendingDelete methodsFor!

canInsert: insertText at: start
	^false!

canRemoveFrom: position extent: removeExtent
	^position = startPosition or: [position < startPosition and: [position + removeExtent >= startPosition]]!

contentsFrom: position extent: contentsExtent
	^startPosition < (position + contentsExtent) 
		ifTrue: 
			[position < startPosition 
				ifTrue: 
					[| contents |
					contents := WriteStream on: (String new: contentsExtent).
					contents 
						nextPutAll: (textEdition contentsFrom: position extent: startPosition - position).
					contents size < contentsExtent 
						ifTrue: 
							[contents nextPutAll: (textEdition contentsFrom: position + extent + contents size
										extent: contentsExtent - contents size)].
					contents contents]
				ifFalse: [textEdition contentsFrom: position + extent extent: contentsExtent]]
		ifFalse: [textEdition contentsFrom: position extent: contentsExtent]!

count
	^textEdition count - extent!

extent
	^extent!

extent: anObject
	extent := anObject!

flushChanges
	^textEdition removeFrom: startPosition extent: extent.!

insert: insertText at: start
	self shouldNotImplement!

removeFrom: position extent: removeExtent
	position = startPosition ifTrue: [extent := extent + removeExtent. ^self].
	(position < startPosition and: [position + removeExtent >= startPosition]) ifTrue: [
		startPosition := position.
		extent := extent + removeExtent.
		^self].
	self shouldNotImplement.!

startPosition
	^startPosition!

startPosition: anObject
	startPosition := anObject! !
!PendingDelete categoriesFor: #canInsert:at:!public! !
!PendingDelete categoriesFor: #canRemoveFrom:extent:!public! !
!PendingDelete categoriesFor: #contentsFrom:extent:!public! !
!PendingDelete categoriesFor: #count!public! !
!PendingDelete categoriesFor: #extent!accessing!private! !
!PendingDelete categoriesFor: #extent:!accessing!private! !
!PendingDelete categoriesFor: #flushChanges!public! !
!PendingDelete categoriesFor: #insert:at:!public! !
!PendingDelete categoriesFor: #removeFrom:extent:!public! !
!PendingDelete categoriesFor: #startPosition!accessing!private! !
!PendingDelete categoriesFor: #startPosition:!accessing!private! !

!PendingDelete class methodsFor!

textEdition: textEdition startPosition: startPosition extent: extent
	^(self new)
		textEdition: textEdition;
		startPosition: startPosition;
		extent: extent;
		yourself! !
!PendingDelete class categoriesFor: #textEdition:startPosition:extent:!public! !

