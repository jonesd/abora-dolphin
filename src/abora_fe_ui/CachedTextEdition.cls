"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #CachedTextEdition
	instanceVariableNames: 'textEdition pendingChanges'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CachedTextEdition guid: (GUID fromString: '{CDFF7729-1502-4446-8473-34A3E3E4C7DC}')!
CachedTextEdition comment: ''!
!CachedTextEdition categoriesForClass!Kernel-Objects! !
!CachedTextEdition methodsFor!

contents
	^pendingChanges notNil ifTrue: [pendingChanges contents] ifFalse: [textEdition contents]!

contentsFrom: start extent: extent
	^pendingChanges notNil 
		ifTrue: [pendingChanges contentsFrom: start extent: extent]
		ifFalse: [textEdition contentsFrom: start extent: extent]!

count
	^pendingChanges notNil ifTrue: [pendingChanges count] ifFalse: [textEdition count]!

createForInsert: text at: position
	^PendingInsert 
		textEdition: textEdition
		position: position
		text: text!

createForRemoveFrom: position extent: extent
	^PendingDelete 
		textEdition: self textEdition
		startPosition: position
		extent: extent!

edition
	^textEdition edition!

flushChanges
	| oldPendingChanges |
	pendingChanges isNil ifTrue: [^self].
	"shuffle around here to stop possibility of recursive error"
	oldPendingChanges := pendingChanges.
	pendingChanges := nil.
	oldPendingChanges flushChanges!

hasPendingChanges
	^pendingChanges notNil!

insert: text at: position
	pendingChanges notNil 
		ifTrue: 
			[(pendingChanges canInsert: text at: position) 
				ifTrue: 
					[pendingChanges insert: text at: position.
					^self].
			self flushChanges].
	pendingChanges := self createForInsert: text at: position!

removeFrom: position extent: extent
	pendingChanges notNil 
		ifTrue: 
			[(pendingChanges canRemoveFrom: position extent: extent) 
				ifTrue: 
					[pendingChanges removeFrom: position extent: extent.
					^self].
			self flushChanges].
	pendingChanges := self createForRemoveFrom: position extent: extent!

textEdition
	^textEdition!

textEdition: anObject
	textEdition := anObject.
	pendingChanges notNil ifTrue: [pendingChanges textEdition: anObject]!

transcludeEdition: feEdition from: from extent: extent to: to
	self flushChanges.
	^textEdition transcludeEdition: feEdition from: from extent: extent to: to.! !
!CachedTextEdition categoriesFor: #contents!public! !
!CachedTextEdition categoriesFor: #contentsFrom:extent:!public! !
!CachedTextEdition categoriesFor: #count!public! !
!CachedTextEdition categoriesFor: #createForInsert:at:!public! !
!CachedTextEdition categoriesFor: #createForRemoveFrom:extent:!public! !
!CachedTextEdition categoriesFor: #edition!public! !
!CachedTextEdition categoriesFor: #flushChanges!public! !
!CachedTextEdition categoriesFor: #hasPendingChanges!public! !
!CachedTextEdition categoriesFor: #insert:at:!public! !
!CachedTextEdition categoriesFor: #removeFrom:extent:!public! !
!CachedTextEdition categoriesFor: #textEdition!accessing!private! !
!CachedTextEdition categoriesFor: #textEdition:!accessing!private! !
!CachedTextEdition categoriesFor: #transcludeEdition:from:extent:to:!public! !

!CachedTextEdition class methodsFor!

textEdition: textEdition
	^(self new)
		textEdition: textEdition;
		yourself! !
!CachedTextEdition class categoriesFor: #textEdition:!public! !

