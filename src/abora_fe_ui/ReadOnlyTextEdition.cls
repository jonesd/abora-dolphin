"Filed out from Dolphin Smalltalk 2002 release 5.00"!

CachedTextEdition subclass: #ReadOnlyTextEdition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ReadOnlyTextEdition guid: (GUID fromString: '{D5DBFD1E-1AEB-4CCB-8E1A-DA26F0796F07}')!
ReadOnlyTextEdition comment: ''!
!ReadOnlyTextEdition categoriesForClass!Kernel-Objects! !
!ReadOnlyTextEdition methodsFor!

createForInsert: text at: position
	self frozenWorkMessage.
	^nil!

createForRemoveFrom: position extent: extent
	self frozenWorkMessage.
	^nil
!

frozenWorkMessage
	MessageBox notify: 'Frozen Work

If you want to modify such a work, then Create New Work from Edition to get a modifiable version.' caption: AboraSystem current applicationName! !
!ReadOnlyTextEdition categoriesFor: #createForInsert:at:!public! !
!ReadOnlyTextEdition categoriesFor: #createForRemoveFrom:extent:!public! !
!ReadOnlyTextEdition categoriesFor: #frozenWorkMessage!private! !

