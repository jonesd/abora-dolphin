"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Model subclass: #FeTextModelCache
	instanceVariableNames: 'textModels'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextModelCache guid: (GUID fromString: '{B0C34385-3F9D-4E4F-962E-3C0FC63BB26D}')!
FeTextModelCache comment: ''!
!FeTextModelCache categoriesForClass!MVP-Models! !
!FeTextModelCache methodsFor!

addTextModel: textModel
	self textModels at: textModel work put: textModel.
!

initialize
	super initialize.

	textModels := LookupTable new.
!

textModelForWork: beWork
	^self textModels at: beWork!

textModelForWork: beWork ifAbsent: block
	^self textModels at: beWork ifAbsent: block!

textModels
	^textModels!

textModels: anObject
	textModels := anObject! !
!FeTextModelCache categoriesFor: #addTextModel:!public! !
!FeTextModelCache categoriesFor: #initialize!public! !
!FeTextModelCache categoriesFor: #textModelForWork:!public! !
!FeTextModelCache categoriesFor: #textModelForWork:ifAbsent:!public! !
!FeTextModelCache categoriesFor: #textModels!accessing!private! !
!FeTextModelCache categoriesFor: #textModels:!accessing!private! !

