"Filed out from Dolphin Smalltalk 2002 release 5.00"!

PendingChange subclass: #PendingInsert
	instanceVariableNames: 'position text'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PendingInsert guid: (GUID fromString: '{35F233F8-D068-473F-A8E8-438217189463}')!
PendingInsert comment: ''!
!PendingInsert categoriesForClass!Kernel-Objects! !
!PendingInsert methodsFor!

canInsert: insertText at: start
	^start >= position and: [start <= (position + text size)]!

canRemoveFrom: start extent: extent
	^start >= position and: [start + extent <= (position + text size)]!

contentsFrom: start extent: extent
	^(position < (start + extent) and: [position + text size > start]) 
		ifTrue: 
			[| contents |
			contents := WriteStream on: (String new: extent).
			position < start 
				ifTrue: 
					[| textStart textEnd |
					textStart := start - position + 1.
					textEnd := textStart + extent - 1 min: text size.
					contents 
						next: textEnd - textStart + 1
						putAll: text
						startingAt: textStart]
				ifFalse: 
					[contents nextPutAll: (textEdition contentsFrom: start extent: position - start).
					contents 
						next: (extent - contents size min: text size)
						putAll: text
						startingAt: 1].
			contents size < extent 
				ifTrue: 
					[contents nextPutAll: (textEdition contentsFrom: position extent: extent - contents size)].
			contents contents]
		ifFalse: 
			[position < start 
				ifTrue: [textEdition contentsFrom: start - text size extent: extent]
				ifFalse: [textEdition contentsFrom: start extent: extent]]!

count
	^textEdition count + text size!

flushChanges
	^textEdition insert: text at: position.!

insert: insertText at: start
	text := text copyReplaceFrom: start - position + 1 to: start - position with: insertText !

position
	^position!

position: anObject
	position := anObject!

removeFrom: start extent: extent
	(self canRemoveFrom: start extent: extent) ifFalse: [^self shouldNotImplement].
	text := text copyReplaceFrom: start - position + 1 to: start - position + extent with: ''.!

text
	^text!

text: anObject
	text := anObject! !
!PendingInsert categoriesFor: #canInsert:at:!public! !
!PendingInsert categoriesFor: #canRemoveFrom:extent:!public! !
!PendingInsert categoriesFor: #contentsFrom:extent:!public! !
!PendingInsert categoriesFor: #count!public! !
!PendingInsert categoriesFor: #flushChanges!public! !
!PendingInsert categoriesFor: #insert:at:!public! !
!PendingInsert categoriesFor: #position!accessing!private! !
!PendingInsert categoriesFor: #position:!accessing!private! !
!PendingInsert categoriesFor: #removeFrom:extent:!public! !
!PendingInsert categoriesFor: #text!accessing!private! !
!PendingInsert categoriesFor: #text:!accessing!private! !

!PendingInsert class methodsFor!

textEdition: textEdition position: position text: text
	^(self new)
		textEdition: textEdition;
		position: position;
		text: text;
		yourself! !
!PendingInsert class categoriesFor: #textEdition:position:text:!public! !

