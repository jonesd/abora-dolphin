"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeWorkTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeWorkTest guid: (GUID fromString: '{E65D4673-5DDD-4F3D-96FC-4A3CAF98A4F7}')!
FeWorkTest comment: ''!
!FeWorkTest categoriesForClass!SUnit! !
!FeWorkTest methodsFor!

testCreateEdition
	| beEdition beProxy feEdition feWork |
	beEdition := BeEdition contents: '1234567890' asAboraContent.
	beProxy := BeContentElementProxy for: beEdition.
	feEdition := FeEdition on: beProxy.
	feWork := FeWork edition: feEdition.
	self should: [feWork edition == feEdition].
	self should: [feWork beWork edition isIdentical: beProxy]!

testOn
	| beEdition beWork feWork feWork2 |
	beEdition := BeEdition contents: '1234567890' asAboraContent.
	beWork := BeWork edition: beEdition.
	feWork := FeWork on: beWork.

	self should: [feWork beWork == beWork].
	self should: [feWork edition beEdition == beEdition].

	feWork2 := FeWork on: beWork.
	self should: [feWork2 == feWork].
	self should: [feWork2 edition beEdition == beEdition].
	self should: [feWork2 edition == feWork edition].
	self should: [feWork2 edition beEdition == beEdition].


! !
!FeWorkTest categoriesFor: #testCreateEdition!public! !
!FeWorkTest categoriesFor: #testOn!public! !

