"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeTextEditionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextEditionTest guid: (GUID fromString: '{95077F86-D4E9-4A39-8C21-F561BD74405B}')!
FeTextEditionTest comment: ''!
!FeTextEditionTest categoriesForClass!SUnit! !
!FeTextEditionTest methodsFor!

testContents
	| feTextEdition |
	feTextEdition := FeTextEdition contents: '123'.
	self should: [feTextEdition contents = '123'].

	feTextEdition := FeTextEdition empty.
	self should: [feTextEdition contents = ''].!

testContentsFromExtent
	| feTextEdition |
	feTextEdition := FeTextEdition contents: '123'.
	self should: [(feTextEdition contentsFrom: 2 extent: 2) = '23'].
!

testCount
	| feTextEdition |
	feTextEdition := FeTextEdition contents: '123'.
	self should: [feTextEdition count = 3].

	feTextEdition := FeTextEdition empty.
	self should: [feTextEdition count = 0].!

testCreateContents
	| feTextEdition feEdition |
	feTextEdition := FeTextEdition contents: '123'.

	self should: [feTextEdition contents = '123'].
	self should: [feTextEdition edition endorsements includes: SystemIds textEditionEndorsement].
	self should: [feTextEdition edition contents = '123' asAboraContent].
	self should: [feTextEdition edition beEdition contents = '123' asAboraContent].!

testCreateEmpty
	| feTextEdition feEdition |
	feTextEdition := FeTextEdition empty.

	self should: [feTextEdition contents = ''].
	self should: [feTextEdition edition endorsements includes: SystemIds textEditionEndorsement].
	self should: [feTextEdition edition contents = '' asAboraContent].
	self should: [feTextEdition edition beEdition contents = '' asAboraContent].!

testCreateOn
	| feEdition feTextEdition feTextEdition2  |
	feEdition := FeEdition contents: '123' asAboraContent.
	feEdition endorse: SystemIds textEditionEndorsement.
	feTextEdition := FeTextEdition on: feEdition.

	self should: [feTextEdition contents = '123'].
	self should: [feTextEdition edition == feEdition].

	feTextEdition2 := FeTextEdition on: feEdition.
	self should: [feTextEdition2 ~~ feTextEdition].!

testCreateOnMissingEndorsement
	| feEdition |
	feEdition := FeEdition contents: '123' asAboraContent.
	self should: [FeTextEdition on: feEdition] raise: FeError.!

testInsertAt
	| feTextEdition feEdition2 feTextEdition2 |
	feTextEdition := FeTextEdition contents: '123'.
	feEdition2 := feTextEdition insert: 'abc' at: 2.
	feTextEdition2 := FeTextEdition on: feEdition2.

	self should: [feTextEdition2 contents = '1abc23'].
	self should: [feTextEdition contents = '123'].
!

testRemoveFromExtent
	| feTextEdition feEdition2 feTextEdition2 |
	feTextEdition := FeTextEdition contents: '123'.
	feEdition2 := feTextEdition removeFrom: 2 extent: 2.
	feTextEdition2 := FeTextEdition on: feEdition2.

	self should: [feTextEdition2 contents = '1'].
	self should: [feTextEdition contents = '123'].
!

testTrancludeEditionFromExtentTo
	| feTextEdition feEdition2 feTextEdition2 |
	feTextEdition := FeTextEdition contents: '123'.
	feEdition2 := feTextEdition transcludeEdition: feTextEdition edition from: 2 extent: 2 to: 4.
	feTextEdition2 := FeTextEdition on: feEdition2.

	self should: [feTextEdition2 contents = '12323'].
	self should: [feTextEdition contents = '123'].
! !
!FeTextEditionTest categoriesFor: #testContents!public! !
!FeTextEditionTest categoriesFor: #testContentsFromExtent!public! !
!FeTextEditionTest categoriesFor: #testCount!public! !
!FeTextEditionTest categoriesFor: #testCreateContents!public! !
!FeTextEditionTest categoriesFor: #testCreateEmpty!public! !
!FeTextEditionTest categoriesFor: #testCreateOn!public! !
!FeTextEditionTest categoriesFor: #testCreateOnMissingEndorsement!public! !
!FeTextEditionTest categoriesFor: #testInsertAt!public! !
!FeTextEditionTest categoriesFor: #testRemoveFromExtent!public! !
!FeTextEditionTest categoriesFor: #testTrancludeEditionFromExtentTo!public! !

