"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Model subclass: #FeTextModel
	instanceVariableNames: 'work feTextEdition cachedTextEdition cachedTitle'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextModel guid: (GUID fromString: '{1B117EF3-F860-47C4-940C-B3BC9817DE93}')!
FeTextModel comment: ''!
!FeTextModel categoriesForClass!MVP-Models! !
!FeTextModel methodsFor!

addHyperLink: hyperLink
	| newTopEdition |
	newTopEdition := self topEdition append: hyperLink edition.
	self reviseWork: newTopEdition!

clearCache
	cachedTitle := nil.!

createTitle
	| transclusions  hyperRefEdition |
	transclusions := self topEdition contents select: [:edition | edition endorsements includes: FeIds linkTitleEndorsement].
	transclusions isEmpty ifTrue: [^'<Unknown>'].
	hyperRefEdition := transclusions asArray first contents first.
	^hyperRefEdition contents asAboraText!

displayOn: stream
	stream nextPutAll: self title.
	stream nextPutAll: ' ('.
	self work revision displayOn: stream.
	stream nextPutAll: ' - '.
	self work revisionTime displayOn: stream.
	stream nextPutAll: ')'.!

edition
	^self textEdition edition!

editionUpdatedTo: newEdition
	| newTopEdition |
	newTopEdition := work edition = self edition 
				ifTrue: [newEdition]
				ifFalse: 
					[| index |
					index := self topEdition contents indexOf: self edition.
					self assert: [index > 0].
					(self topEdition removeFrom: index extent: 1) insert: newEdition at: index].
	self initializeWithEdition: newEdition.
	self reviseWork: newTopEdition!

initializeWithEdition: feEdition
	feTextEdition notNil ifTrue: [feTextEdition edition removeEventsTriggeredFor: self].
	feTextEdition := FeTextEdition on: feEdition.
	cachedTextEdition notNil 
		ifTrue: [cachedTextEdition textEdition: feTextEdition]
		ifFalse: 
			[cachedTextEdition := (self work isNil or: [self work isFrozen]) 
						ifTrue: [ReadOnlyTextEdition textEdition: feTextEdition]
						ifFalse: [CachedTextEdition textEdition: feTextEdition]].
	feEdition when: #editionUpdatedTo: sendTo: self!

isSingleRefEditionNative: singleRefEdition
	^ (FeSingleRef on: singleRefEdition) hyperLink homeEditions includes: self topEdition!

removeHyperLink: hyperLink
	| newTopEdition mapping |
	newTopEdition := self topEdition.
	#todo.
	
	[mapping := newTopEdition sharedWith: (FeEdition contents: hyperLink edition).
	mapping isEmpty] 
			whileFalse: 
				[newTopEdition := newTopEdition removeFrom: mapping first first startPosition
							extent: mapping first last extent].
	newTopEdition = self topEdition ifTrue: [^self].
	self reviseWork: newTopEdition!

reviseWork: newTopEdition
	self work revise: newTopEdition.
	self clearCache.
	self trigger: #workRevised!

textEdition
	^cachedTextEdition!

title
	cachedTitle isNil ifTrue: [cachedTitle := self createTitle].
	^cachedTitle!

topEdition
	^self work edition!

work
	^work
!

work: newWork
"	self assert: [work edition == self edition]."
	work := newWork
! !
!FeTextModel categoriesFor: #addHyperLink:!public! !
!FeTextModel categoriesFor: #clearCache!private! !
!FeTextModel categoriesFor: #createTitle!private! !
!FeTextModel categoriesFor: #displayOn:!public! !
!FeTextModel categoriesFor: #edition!public! !
!FeTextModel categoriesFor: #editionUpdatedTo:!public! !
!FeTextModel categoriesFor: #initializeWithEdition:!private! !
!FeTextModel categoriesFor: #isSingleRefEditionNative:!public! !
!FeTextModel categoriesFor: #removeHyperLink:!public! !
!FeTextModel categoriesFor: #reviseWork:!private! !
!FeTextModel categoriesFor: #textEdition!public! !
!FeTextModel categoriesFor: #title!public! !
!FeTextModel categoriesFor: #topEdition!public! !
!FeTextModel categoriesFor: #work!public! !
!FeTextModel categoriesFor: #work:!private! !

!FeTextModel class methodsFor!

contents: text
	| textEdition topEdition work |
	textEdition := FeTextEdition contents: text.
	topEdition := FeEdition contents: textEdition edition.
	work := FeWork edition: topEdition.
	^self work: work!

empty
	| textEdition topEdition work |
	textEdition := FeTextEdition empty.
	topEdition := FeEdition contents: textEdition edition.
	work := FeWork edition: topEdition.
	^self work: work!

findEditionWithTextEndorsement: work
	| edition |
	edition := work edition.
	^(edition endorsements includes: SystemIds textEditionEndorsement) 
		ifTrue: [edition]
		ifFalse: 
			[edition contents 
				detect: [:childEdition | childEdition isInteger not and: [childEdition endorsements includes: SystemIds textEditionEndorsement]] ifNone: [nil]]
!

work: feWork
	| textEdition |
	textEdition := self findEditionWithTextEndorsement: feWork.
	textEdition isNil ifTrue: [self error: 'Could not find text edition within work'].
	^(self new)
		work: feWork;
		initializeWithEdition: textEdition;
		yourself! !
!FeTextModel class categoriesFor: #contents:!public! !
!FeTextModel class categoriesFor: #empty!public! !
!FeTextModel class categoriesFor: #findEditionWithTextEndorsement:!private! !
!FeTextModel class categoriesFor: #work:!public! !

