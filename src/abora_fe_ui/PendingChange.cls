"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #PendingChange
	instanceVariableNames: 'textEdition'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PendingChange guid: (GUID fromString: '{339AC79E-94E5-45DA-8FB2-B1C8728AFB5A}')!
PendingChange comment: ''!
!PendingChange categoriesForClass!Kernel-Objects! !
!PendingChange methodsFor!

canInsert: insertText at: start
	self subclassResponsibility!

canRemoveFrom: position extent: removeExtent
	self subclassResponsibility!

contents
	^self contentsFrom: 1 extent: self count!

contentsFrom: position extent: contentsExtent
	self subclassResponsibility!

count
	self subclassResponsibility!

flushChanges
	self subclassResponsibility!

insert: insertText at: start
	self subclassResponsibility!

removeFrom: position extent: removeExtent
	self subclassResponsibility!

textEdition
	^textEdition!

textEdition: anObject
	textEdition := anObject! !
!PendingChange categoriesFor: #canInsert:at:!public! !
!PendingChange categoriesFor: #canRemoveFrom:extent:!public! !
!PendingChange categoriesFor: #contents!public! !
!PendingChange categoriesFor: #contentsFrom:extent:!public! !
!PendingChange categoriesFor: #count!public! !
!PendingChange categoriesFor: #flushChanges!public! !
!PendingChange categoriesFor: #insert:at:!public! !
!PendingChange categoriesFor: #removeFrom:extent:!public! !
!PendingChange categoriesFor: #textEdition!accessing!private! !
!PendingChange categoriesFor: #textEdition:!accessing!private! !

