"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #ContentLeafTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ContentLeafTest guid: (GUID fromString: '{0D230093-2E44-4D9C-839C-7678FC96F2B5}')!
ContentLeafTest comment: ''!
!ContentLeafTest categoriesForClass!Kernel-Objects! !
!ContentLeafTest methodsFor!

testContentsAt
	| leaf content |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	self should: [(leaf contentsAt: 2) == content]!

testContentsAtBadPosition
	| leaf content |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	self should: [leaf contentsAt: 1] raise: BoundsError.
	self should: [leaf contentsAt: 3] raise: BoundsError!

testContentsFromExtentDo
	| leaf content out |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	out := OrderedCollection new.
	leaf 
		contentsFrom: 2
		extent: 1
		do: [:data | out add: data].
	self should: [out = (OrderedCollection with: content)].
	out := OrderedCollection new.
	leaf 
		contentsFrom: 1
		extent: 3
		do: [:data | out add: data].
	self should: [out = (OrderedCollection with: content)]!

testCount
	| leaf content |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	self should: [leaf count = 1]!

testCountCollection
	| leaf content |
	content := BeDataHolder value: 'hello'.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	self should: [leaf count = 1]!

testCreate
	| leaf content |
	content := BeDataHolder value: 123.
	self should: [content parents isEmpty].
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	self should: [leaf contentElement = content].
	self should: [leaf branch  = 3].
	self should: [leaf startPosition = 2].
	self should: [content parents = (OrderedCollection with: leaf)]!

testSharedWithForMappingsMultiple
	| leaf content edition anotherEdition mappings |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 1
				startPosition: 1
				contentElement: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: content.
	anotherEdition := anotherEdition append: (BeDataHolder value: 9).
	anotherEdition := anotherEdition append: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 1)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 1)].
	self should: [mappings last first = (IntegerRegion startPosition: 1 extent: 1)].
	self should: [mappings last last = (IntegerRegion startPosition: 3 extent: 1)]!

testSharedWithForMappingsNone
	| leaf content edition anotherEdition mappings |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 1
				startPosition: 1
				contentElement: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition new.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings isEmpty]!

testSharedWithForMappingsSimpleDisplacement
	| leaf content edition anotherEdition mappings |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 1
				startPosition: 1
				contentElement: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: (BeDataHolder value: 9).
	anotherEdition := anotherEdition append: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 1)].
	self should: [mappings first last = (IntegerRegion startPosition: 2 extent: 1)]!

testSharedWithForMappingsStraight
	| leaf content edition anotherEdition mappings |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 1
				startPosition: 1
				contentElement: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 1)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 1)]!

testSplitAbout
	| leaf content root |
	content := BeDataHolder value: 123.
	leaf := ContentLeaf 
				branch: 3
				startPosition: 2
				contentElement: content.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.

	"test"
	self 
		should: [leaf split: 1 about: 2]
		raise: Error
		description: 'ContentLeaf should not implement #split:about:'! !
!ContentLeafTest categoriesFor: #testContentsAt!public! !
!ContentLeafTest categoriesFor: #testContentsAtBadPosition!public! !
!ContentLeafTest categoriesFor: #testContentsFromExtentDo!public! !
!ContentLeafTest categoriesFor: #testCount!public! !
!ContentLeafTest categoriesFor: #testCountCollection!public! !
!ContentLeafTest categoriesFor: #testCreate!public! !
!ContentLeafTest categoriesFor: #testSharedWithForMappingsMultiple!public! !
!ContentLeafTest categoriesFor: #testSharedWithForMappingsNone!public! !
!ContentLeafTest categoriesFor: #testSharedWithForMappingsSimpleDisplacement!public! !
!ContentLeafTest categoriesFor: #testSharedWithForMappingsStraight!public! !
!ContentLeafTest categoriesFor: #testSplitAbout!public! !

