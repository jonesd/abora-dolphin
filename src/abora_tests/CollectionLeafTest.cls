"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #CollectionLeafTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CollectionLeafTest guid: (GUID fromString: '{5D1379AA-01B5-4DC8-AEF9-C5B54A1529AD}')!
CollectionLeafTest comment: ''!
!CollectionLeafTest categoriesForClass!SUnit! !
!CollectionLeafTest methodsFor!

testAllEditions
	| leaf root1 edition1 root2 edition2 |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	edition1 := BeEdition new.
	root1 := RootNode 
				edition: edition1
				branch: 1
				with: leaf.
	edition2 := BeEdition new.
	root2 := RootNode 
				edition: edition2
				branch: 2
				with: leaf.
	self should: [leaf allEditions size = 2].
	self should: [leaf allEditions includes: edition1].
	self should: [leaf allEditions includes: edition2]!

testAllRoots
	| leaf root1 root2 |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	root1 := RootNode 
				edition: nil
				branch: 1
				with: leaf.
	root2 := RootNode 
				edition: nil
				branch: 2
				with: leaf.
	self should: [leaf allRoots size = 2].
	self should: [leaf allRoots includes: root1].
	self should: [leaf allRoots includes: root2]!

testContents
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	self should: [leaf contents = 'abcdef' asAboraContent]!

testContentsAt
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	self should: [(leaf contentsAt: 10) = $a codePoint].
	self should: [(leaf contentsAt: 11) = $b codePoint].
	self should: [(leaf contentsAt: 15) = $f codePoint]!

testContentsAtBadPosition
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	self should: [leaf contentsAt: 9] raise: BoundsError.
	self should: [leaf contentsAt: 16] raise: BoundsError!

testContentsFromExtentDo
	| leaf out do |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'abcdef' asAboraContent.
	out := ''.
	do := [:int | out := out , (Character codePoint: int) asString].
	leaf 
		contentsFrom: 10
		extent: 6
		do: do.
	self should: [out = 'abcdef'].
	out := ''.
	leaf 
		contentsFrom: 11
		extent: 3
		do: do.
	self should: [out = 'bcd'].
	out := ''.
	leaf 
		contentsFrom: 8
		extent: 13
		do: do.
	self should: [out = 'abcdef'].
	out := ''.
	leaf 
		contentsFrom: 8
		extent: 3
		do: do.
	self should: [out = 'a'].
	out := ''.
	leaf 
		contentsFrom: 15
		extent: 6
		do: do.
	self should: [out = 'f'].
	out := ''.
	leaf 
		contentsFrom: 5
		extent: 5
		do: do.
	self should: [out = ''].
	out := ''.
	leaf 
		contentsFrom: 16
		extent: 5
		do: do.
	self should: [out = '']!

testCount
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 10
				elements: 'hello' asAboraContent.
	self should: [leaf count = 5]!

testCreate
	| leaf |
	leaf := CollectionLeaf 
				branch: 3
				startPosition: 2
				elements: 'hello' asAboraContent.
	self should: [leaf elements = 'hello' asAboraContent].
	self should: [leaf branch  = 3].
	self should: [leaf startPosition = 2]!

testDuplicateFor
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [leaf duplicateFor: 1] raise: Error!

testGlobalPositionFor
	| leaf1 leaf2 split root |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 4
				elements: '12' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 5
				elements: '3' asAboraContent.
	split := SplitNode 
				branch: 1
				split: 7
				left: leaf1
				leftDsp: 1
				right: leaf2
				rightDsp: 2.
	root := RootNode 
				edition: nil
				branch: 1
				with: split
				dsp: -4.
	self assertTextContentsOf: root is: '123'.

	"test"
	self should: [(leaf1 globalPositionFor: 1) = 1].
	self should: [(leaf2 globalPositionFor: 1) = 3]!

testGlobalPositionForSimple
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [(leaf globalPositionFor: 1) = 1]!

testGlobalRegionFor
	| leaf1 leaf2 split root |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 4
				elements: '12' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 5
				elements: '3' asAboraContent.
	split := SplitNode 
				branch: 1
				split: 7
				left: leaf1
				leftDsp: 1
				right: leaf2
				rightDsp: 2.
	root := RootNode 
				edition: nil
				branch: 1
				with: split
				dsp: -4.
	self assertTextContentsOf: root is: '123'.

	"test"
	self should: [(leaf1 globalRegionFor: 1) = (IntegerRegion startPosition: 1 extent: 2)].
	self should: [(leaf2 globalRegionFor: 1) = (IntegerRegion startPosition: 3 extent: 1)]!

testInsertAtRootBadPosition
	| root leaf insertedNode |
	leaf := CollectionLeaf 
				branch: 3
				startPosition: 4
				elements: 'hello' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 4
				with: leaf
				dsp: -3.
	insertedNode := CollectionLeaf 
				branch: 3
				startPosition: 0
				elements: 'ab' asAboraContent.
	self should: 
			[leaf 
				insert: insertedNode
				at: 3
				root: root]
		raise: BoundsError.
	self should: 
			[leaf 
				insert: insertedNode
				at: 9 + 1
				root: root]
		raise: BoundsError!

testIsMaxNodeFor
	| root leaf |
	root := self createBalanced12345678.
	1 to: 7
		do: 
			[:index | 
			leaf := root nodeAt: index.
			self should: [(leaf isMaxNodeFor: 1) not]].
	leaf := root nodeAt: 8.
	self should: [leaf isMaxNodeFor: 1]!

testIsMaxNodeForSingle
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [leaf isMaxNodeFor: 1]!

testIsMinNodeFor
	| root leaf |
	root := self createBalanced12345678.
	2 to: 8
		do: 
			[:index | 
			leaf := root nodeAt: index.
			self should: [(leaf isMinNodeFor: 1) not]].
	leaf := root nodeAt: 1.
	self should: [leaf isMinNodeFor: 1]!

testIsMinNodeForSingle
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [leaf isMinNodeFor: 1]!

testMaxNode
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [leaf maxNode == leaf]!

testMinNode
	| leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	self should: [leaf minNode == leaf]!

testRemoveFromRoot
	| root leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.

	"test"
	leaf removeFor: 1.
	self should: [root count = 0].
	self assertTextContentsOf: root is: ''!

testRemoveFromSplitLeft
	| root leaf1 leaf2 splitNode |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'a' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 2
				elements: 'b' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 2
				left: leaf1
				right: leaf2.
	root := RootNode 
				edition: nil
				branch: 1
				with: splitNode.

	"test"
	leaf1 removeFor: 1.
	self assertTextContentsOf: root is: 'b'!

testRemoveFromSplitRight
	| root leaf1 leaf2 splitNode |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'a' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 2
				elements: 'b' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 2
				left: leaf1
				right: leaf2.
	root := RootNode 
				edition: nil
				branch: 1
				with: splitNode.

	"test"
	leaf2 removeFor: 1.
	self assertTextContentsOf: root is: 'a'!

testReplaceWithSplitAbout
	| root leaf splitNode collection |
	collection := BeCollectionHolder collection: 'hello' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: collection.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.
	self should: [collection parents = (OrderedCollection with: leaf)].

	"test"
	splitNode := leaf replaceWithSplit: 1 about: 3.
	self should: [splitNode left elements = 'he' asAboraContent].
	self should: [splitNode right elements = 'llo' asAboraContent].
	self should: [splitNode left parents = (OrderedCollection with: splitNode)].
	self should: [splitNode right parents = (OrderedCollection with: splitNode)].
	self 
		should: [collection parents = (OrderedCollection with: splitNode left with: splitNode right)].
	"existing parents should be updated with new splitNode"
	self should: [leaf parents = OrderedCollection new].
	self should: [root child == splitNode].
	self should: [splitNode parents = (OrderedCollection with: root)]!

testSharedWithForMappingsMultiple
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: content.
	anotherEdition := anotherEdition append: 'abcde' asAboraContent.
	anotherEdition := anotherEdition append: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings last first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings last last = (IntegerRegion startPosition: 9 extent: 3)]!

testSharedWithForMappingsNone
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition new.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings isEmpty]!

testSharedWithForMappingsNoneByPartialOverlap
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	edition := edition removeFrom: 1 extent: 2.
	anotherEdition := BeEdition contents: content.
	anotherEdition := anotherEdition removeFrom: 2 extent: 2.
	mappings := OrderedCollection new.
	self should: [edition root child contents = '3' asAboraContent].
	edition root child 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 0]!

testSharedWithForMappingsPartialOverlap
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: 'abcd' asAboraContent.
	anotherEdition := anotherEdition insert: content at: 5.
	anotherEdition := anotherEdition removeFrom: 5 extent: 2.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 3 extent: 1)].
	self should: [mappings first last = (IntegerRegion startPosition: 5 extent: 1)]!

testSharedWithForMappingsSimpleDisplacement
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: 'abcde' asAboraContent.
	anotherEdition := anotherEdition append: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 6 extent: 3)]!

testSharedWithForMappingsStraight
	| leaf content edition anotherEdition mappings |
	content := BeCollectionHolder collection: '123' asAboraContent.
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				collection: content.
	edition := BeEdition new.
	edition root insert: leaf.
	anotherEdition := BeEdition contents: content.
	mappings := OrderedCollection new.
	leaf 
		sharedWith: anotherEdition
		for: anotherEdition branch
		mappings: mappings.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)]!

testSplitAbout
	| root leaf splitNode |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.

	"test"
	splitNode := leaf split: 1 about: 3.
	self should: [splitNode left elements = 'he' asAboraContent].
	self should: [splitNode right elements = 'llo' asAboraContent].
	self should: [splitNode left parents = (OrderedCollection with: splitNode)].
	self should: [splitNode right parents = (OrderedCollection with: splitNode)].
	self assertTextContentsOf: root is: 'hello'.
	"existing parents should be left untouched"
	self should: [splitNode parents = OrderedCollection new].
	self should: [root child == leaf].
	self should: [leaf parents = (OrderedCollection with: root)]!

testSplitAboutBadAbout
	| root leaf splitNode |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.

	"test"
	self should: [splitNode := leaf split: 1 about: 0] raise: BoundsError.
	self should: [splitNode := leaf split: 1 about: 1] raise: BoundsError.
	self should: [splitNode := leaf split: 1 about: 6] raise: BoundsError.
	self should: [splitNode := leaf split: 1 about: 7] raise: BoundsError! !
!CollectionLeafTest categoriesFor: #testAllEditions!public! !
!CollectionLeafTest categoriesFor: #testAllRoots!public! !
!CollectionLeafTest categoriesFor: #testContents!public! !
!CollectionLeafTest categoriesFor: #testContentsAt!public! !
!CollectionLeafTest categoriesFor: #testContentsAtBadPosition!public! !
!CollectionLeafTest categoriesFor: #testContentsFromExtentDo!public! !
!CollectionLeafTest categoriesFor: #testCount!public! !
!CollectionLeafTest categoriesFor: #testCreate!public! !
!CollectionLeafTest categoriesFor: #testDuplicateFor!public! !
!CollectionLeafTest categoriesFor: #testGlobalPositionFor!public! !
!CollectionLeafTest categoriesFor: #testGlobalPositionForSimple!public! !
!CollectionLeafTest categoriesFor: #testGlobalRegionFor!public! !
!CollectionLeafTest categoriesFor: #testInsertAtRootBadPosition!public! !
!CollectionLeafTest categoriesFor: #testIsMaxNodeFor!public! !
!CollectionLeafTest categoriesFor: #testIsMaxNodeForSingle!public! !
!CollectionLeafTest categoriesFor: #testIsMinNodeFor!public! !
!CollectionLeafTest categoriesFor: #testIsMinNodeForSingle!public! !
!CollectionLeafTest categoriesFor: #testMaxNode!public! !
!CollectionLeafTest categoriesFor: #testMinNode!public! !
!CollectionLeafTest categoriesFor: #testRemoveFromRoot!public! !
!CollectionLeafTest categoriesFor: #testRemoveFromSplitLeft!public! !
!CollectionLeafTest categoriesFor: #testRemoveFromSplitRight!public! !
!CollectionLeafTest categoriesFor: #testReplaceWithSplitAbout!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsMultiple!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsNone!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsNoneByPartialOverlap!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsPartialOverlap!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsSimpleDisplacement!public! !
!CollectionLeafTest categoriesFor: #testSharedWithForMappingsStraight!public! !
!CollectionLeafTest categoriesFor: #testSplitAbout!public! !
!CollectionLeafTest categoriesFor: #testSplitAboutBadAbout!public! !

