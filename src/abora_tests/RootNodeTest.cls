"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #RootNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
RootNodeTest guid: (GUID fromString: '{0BE06540-01B5-48AE-B758-DC400657286E}')!
RootNodeTest comment: ''!
!RootNodeTest categoriesForClass!SUnit! !
!RootNodeTest methodsFor!

shouldHaveMatchingParents: node
	node children do: [:child |
		self should: [child parents size = 1 and: [child parents first == node]].
		self shouldHaveMatchingParents: child].
	
	!

testAllEditions
	| root edition editions |
	edition := BeEdition new.
	root := RootNode edition: edition branch: 10.
	editions := root allEditions.
	self should: [editions size = 1].
	self should: [editions includes: edition]!

testAllRoots
	| root roots |
	root := RootNode edition: nil branch: 10.
	"test"
	roots := root allRoots.
	self should: [roots size = 1].
	self should: [roots includes: root]!

testAssertIsChild
	| leaf1 leaf2 root |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '12345' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '12345' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf1.
	self shouldnt: [root assertIsChild: leaf1] raise: EntError.
	self 
		should: [root assertIsChild: leaf2]
		raise: EntError
		description: 'unknown child of root'!

testChildren
	| dataLeaf root |
	dataLeaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '12345' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: dataLeaf.
	self should: [root children = (Array with: dataLeaf)]!

testChildrenEmpty
	| root |
	root := RootNode edition: nil branch: 1.
	self should: [root children isEmpty]!

testContentsAt
	| root |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: 'abcdef' asAboraContent).
	self should: [(root contentsAt: 1) = $a codePoint].
	self should: [(root contentsAt: 2) = $b codePoint].
	self should: [(root contentsAt: 6) = $f codePoint]!

testContentsAtBadPosition
	| root |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: 'abcdef' asAboraContent).
	self should: [root contentsAt: 0] raise: BoundsError.
	self should: [root contentsAt: 7] raise: BoundsError!

testContentsFromExtentDo
	| root out do |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 2
						elements: 'abcdef' asAboraContent)
				dsp: -1.
	out := ''.
	do := [:int | out := out , (Character codePoint: int) asString].
	root 
		contentsFrom: 1
		extent: 6
		do: do.
	self should: [out = 'abcdef'].
	out := ''.
	root 
		contentsFrom: 2
		extent: 3
		do: do.
	self should: [out = 'bcd'].
	out := ''.
	root 
		contentsFrom: 1
		extent: 13
		do: do.
	self should: [out = 'abcdef'].
	out := ''.
	root 
		contentsFrom: -2
		extent: 4
		do: do.
	self should: [out = 'a'].
	out := ''.
	root 
		contentsFrom: 6
		extent: 6
		do: do.
	self should: [out = 'f'].
	out := ''.
	root 
		contentsFrom: -2
		extent: 3
		do: do.
	self should: [out = ''].
	out := ''.
	root 
		contentsFrom: 7
		extent: 5
		do: do.
	self should: [out = '']!

testCount
	| root |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345' asAboraContent).
	self should: [root count = 5]!

testCountEmpty
	| root |
	root := RootNode edition: nil branch: 1.
	self should: [root count = 0]!

testCreate
	| root edition |
	edition := BeEdition new.
	root := RootNode edition: edition branch: 10.
	self should: [root branch  = 10].
	self should: [root dsp = 0].
	self should: [root child isNil].
	self should: [root edition == edition]!

testCreateWith
	| root leaf edition |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	edition := BeEdition new.
	root := RootNode 
				edition: edition
				branch: 10
				with: leaf.
	self should: [root branch  = 10].
	self should: [root dsp = 0].
	self should: [root child == leaf].
	self should: [leaf parents = (OrderedCollection with: root)].
	self should: [root edition == edition]!

testCreateWithDsp
	| root leaf edition |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	edition := BeEdition new.
	root := RootNode 
				edition: edition
				branch: 10
				with: leaf
				dsp: 9.
	self should: [root branch  = 10].
	self should: [root dsp = 9].
	self should: [root child == leaf].
	self should: [leaf parents = (OrderedCollection with: root)].
	self should: [root edition == edition]!

testDuplicateFor
	| root newRoot |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345' asAboraContent).

	"operation"
	newRoot := root duplicateFor: 1.
	self should: [root == newRoot].
	self assertTextContentsOf: newRoot is: '12345'!

testHasChild
	self should: 
			[(RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: 'hello' asAboraContent)) 
					hasChild].
	self shouldnt: [(RootNode edition: nil branch: 1) hasChild]!

testInsertEmpty
	| root dataLeaf |
	root := RootNode edition: nil branch: 1.
	dataLeaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.

	"test"
	root insert: dataLeaf.
	self should: [root child == dataLeaf].
	self should: [dataLeaf parents = (OrderedCollection with: root)]!

testInsertEmptyBadPosition
	| root dataLeaf |
	root := RootNode edition: nil branch: 1.
	dataLeaf := CollectionLeaf 
				branch: 1
				startPosition: 2
				elements: 'hello' asAboraContent.

	"test"
	self should: [root insert: dataLeaf] raise: BoundsError!

testInsertEmptyBadRevision
	| root dataLeaf |
	root := RootNode edition: nil branch: 1.
	dataLeaf := CollectionLeaf 
				branch: 2
				startPosition: 1
				elements: 'hello' asAboraContent.

	"test"
	self should: [root insert: dataLeaf] raise: EntError!

testInsertWithDsp
	| root |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 10
						elements: 'hello' asAboraContent)
				dsp: -9.

	"test"
	root insert: (CollectionLeaf 
				branch: 1
				startPosition: 2
				elements: 'ab' asAboraContent).
	self assertTextContentsOf: root is: 'habello'!

testNodesFromExtent
	| root found |
	root := self createBalanced12345678.
	root dsp: -1.
	found := root 
				nodesFrom: 0
				extent: 1
				shouldSplit: false.
	self should: [found size = 1 and: [found first elements = '1' asAboraContent]].
	found := root 
				nodesFrom: 1
				extent: 1
				shouldSplit: false.
	self should: [found size = 1 and: [found first elements = '2' asAboraContent]].
	found := root 
				nodesFrom: 7
				extent: 1
				shouldSplit: false.
	self should: [found size = 1 and: [found first elements = '8' asAboraContent]].
	found := root 
				nodesFrom: 1
				extent: 2
				shouldSplit: false.
	self 
		should: [found size = 2 and: [found first elements = '2' asAboraContent and: [found last elements = '3' asAboraContent]]].
	found := root 
				nodesFrom: 0
				extent: 8
				shouldSplit: false.
	self should: [found size = 8].
	found keysAndValuesDo: [:i :element | self should: [element elements = i printString asAboraContent]]!

testNodesFromExtentShouldSplitLeft
	| root found |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345678' asAboraContent).
	found := root 
				nodesFrom: 1
				extent: 2
				shouldSplit: true.
	self should: [found size = 1 and: [found first elements = '12' asAboraContent]]!

testNodesFromExtentShouldSplitMiddle
	| root found |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345678' asAboraContent).
	found := root 
				nodesFrom: 2
				extent: 6
				shouldSplit: true.
	self should: [found size = 1 and: [found first elements = '234567' asAboraContent]]!

testNodesFromExtentShouldSplitMultiple
	| root found |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12' asAboraContent).
	root insert: (CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: '345' asAboraContent).
	root insert: (CollectionLeaf 
				branch: 1
				startPosition: 6
				elements: '67' asAboraContent).
	root insert: (CollectionLeaf 
				branch: 1
				startPosition: 8
				elements: '89a' asAboraContent).
	root insert: (CollectionLeaf 
				branch: 1
				startPosition: 11
				elements: 'bc' asAboraContent).
	self assertTextContentsOf: root is: '123456789abc'.
	found := root 
				nodesFrom: 4
				extent: 5
				shouldSplit: true.
	self should: [found size = 3].
	self should: [found first elements = '45' asAboraContent].
	self should: [found second elements = '67' asAboraContent].
	self should: [found last elements = '8' asAboraContent].
	self assertTextContentsOf: root is: '123456789abc'!

testNodesFromExtentShouldSplitRight
	| root found |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345678' asAboraContent).
	found := root 
				nodesFrom: 7
				extent: 2
				shouldSplit: true.
	self should: [found size = 1 and: [found first elements = '78' asAboraContent]]!

testParents
	| root leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 10
				with: leaf.
	self should: [root parents isEmpty]!

testRemove
	| root found leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 2
				elements: '1' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf
				dsp: -1.
	self assertTextContentsOf: root is: '1'.
	leaf removeFor: 1.
	self should: [root children isEmpty].
	self should: [root dsp = 0]!

testRemoveBadRevision
	| root found leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '1' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.
	self should: [leaf removeFor: 2] raise: EntError!

testRootFor
	| root |
	root := RootNode edition: nil branch: 10.
	self should: [(root rootFor: 10) == root].
	self should: [(root rootFor: 11) == root].
	self 
		should: [(root rootFor: 9) == root]
		raise: EntError
		description: 'revision is before my time'!

testSplay
	| root found |
	root := self createBalanced12345678.
	self shouldHaveMatchingParents: root.
	found := root splay: 1.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '1' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 2.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '2' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 3.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '3' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 4.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '4' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 5.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '5' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 6.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '6' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 7.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '7' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 8.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '8' asAboraContent].
	self shouldHaveMatchingParents: root.
	found := root splay: 4.
	self assertTextContentsOf: root is: '12345678'.
	self should: [found elements = '4' asAboraContent].
	self shouldHaveMatchingParents: root.
!

testSplayChild
	| root found leaf |
	leaf := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '1' asAboraContent.
	root := RootNode 
				edition: nil
				branch: 1
				with: leaf.
	root splay: 1.
	self should: [root child == leaf]! !
!RootNodeTest categoriesFor: #shouldHaveMatchingParents:!private! !
!RootNodeTest categoriesFor: #testAllEditions!public! !
!RootNodeTest categoriesFor: #testAllRoots!public! !
!RootNodeTest categoriesFor: #testAssertIsChild!public! !
!RootNodeTest categoriesFor: #testChildren!public! !
!RootNodeTest categoriesFor: #testChildrenEmpty!public! !
!RootNodeTest categoriesFor: #testContentsAt!public! !
!RootNodeTest categoriesFor: #testContentsAtBadPosition!public! !
!RootNodeTest categoriesFor: #testContentsFromExtentDo!public! !
!RootNodeTest categoriesFor: #testCount!public! !
!RootNodeTest categoriesFor: #testCountEmpty!public! !
!RootNodeTest categoriesFor: #testCreate!public! !
!RootNodeTest categoriesFor: #testCreateWith!public! !
!RootNodeTest categoriesFor: #testCreateWithDsp!public! !
!RootNodeTest categoriesFor: #testDuplicateFor!public! !
!RootNodeTest categoriesFor: #testHasChild!public! !
!RootNodeTest categoriesFor: #testInsertEmpty!public! !
!RootNodeTest categoriesFor: #testInsertEmptyBadPosition!public! !
!RootNodeTest categoriesFor: #testInsertEmptyBadRevision!public! !
!RootNodeTest categoriesFor: #testInsertWithDsp!public! !
!RootNodeTest categoriesFor: #testNodesFromExtent!public! !
!RootNodeTest categoriesFor: #testNodesFromExtentShouldSplitLeft!public! !
!RootNodeTest categoriesFor: #testNodesFromExtentShouldSplitMiddle!public! !
!RootNodeTest categoriesFor: #testNodesFromExtentShouldSplitMultiple!public! !
!RootNodeTest categoriesFor: #testNodesFromExtentShouldSplitRight!public! !
!RootNodeTest categoriesFor: #testParents!public! !
!RootNodeTest categoriesFor: #testRemove!public! !
!RootNodeTest categoriesFor: #testRemoveBadRevision!public! !
!RootNodeTest categoriesFor: #testRootFor!public! !
!RootNodeTest categoriesFor: #testSplay!public! !
!RootNodeTest categoriesFor: #testSplayChild!public! !

