"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #SplitNodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SplitNodeTest guid: (GUID fromString: '{CC025AE1-680C-498F-BF70-ABE7C6E62C9F}')!
SplitNodeTest comment: ''!
!SplitNodeTest categoriesForClass!SUnit! !
!SplitNodeTest methodsFor!

testAssertIsChild
	| splitNode leaf1 leaf2 leaf3 |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'abcdef' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 7
				elements: 'ghijk' asAboraContent.
	leaf3 := CollectionLeaf 
				branch: 1
				startPosition: 7
				elements: 'ghijk' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 7
				left: leaf1
				right: leaf2.
	splitNode assertIsChild: leaf1.
	splitNode assertIsChild: leaf2.
	self should: [splitNode assertIsChild: leaf3] raise: EntError!

testChildren
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 7
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 7
				left: dataLeaf1
				right: dataLeaf2.
	self should: [splitNode children = (Array with: dataLeaf1 with: dataLeaf2)]!

testContents
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'h' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'there' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: dataLeaf1
				leftDsp: 16
				right: dataLeaf2
				rightDsp: -80.

	"test"
	self should: [splitNode contents = 'hthere' asAboraContent]!

testContentsAt
	| splitNode leaf1 leaf2 |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'abcdef' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'ghijk' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: leaf1
				leftDsp: 11
				right: leaf2
				rightDsp: -80.
	self should: [(splitNode contentsAt: 14) = $a codePoint].
	self should: [(splitNode contentsAt: 15) = $b codePoint].
	self should: [(splitNode contentsAt: 19) = $f codePoint].
	self should: [(splitNode contentsAt: 20) = $g codePoint].
	self should: [(splitNode contentsAt: 24) = $k codePoint]!

testContentsAtBadPosition
	| splitNode leaf1 leaf2 |
	leaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'abcdef' asAboraContent.
	leaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'ghijk' asAboraContent.
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: leaf1
				leftDsp: 11
				right: leaf2
				rightDsp: -80.
	self should: [splitNode contentsAt: 13] raise: BoundsError.
	self should: [splitNode contentsAt: 25] raise: BoundsError!

testContentsFromExtentDo
	| splitNode out do |
	splitNode := SplitNode 
				branch: 1
				split: 7
				left: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '123456' asAboraContent)
				right: (CollectionLeaf 
						branch: 1
						startPosition: 7
						elements: '78901' asAboraContent).
	out := ''.
	do := [:int | out := out , (Character codePoint: int) asString].
	splitNode 
		contentsFrom: 1
		extent: 11
		do: do.
	self should: [out = '12345678901'].
	out := ''.
	splitNode 
		contentsFrom: 1
		extent: 6
		do: do.
	self should: [out = '123456'].
	out := ''.
	splitNode 
		contentsFrom: 7
		extent: 5
		do: do.
	self should: [out = '78901'].
	out := ''.
	splitNode 
		contentsFrom: 2
		extent: 3
		do: do.
	self should: [out = '234'].
	out := ''.
	splitNode 
		contentsFrom: 8
		extent: 2
		do: do.
	self should: [out = '89'].
	out := ''.
	splitNode 
		contentsFrom: 3
		extent: 7
		do: do.
	self should: [out = '3456789'].
	out := ''.
	splitNode 
		contentsFrom: -4
		extent: 10
		do: do.
	self should: [out = '12345'].
	out := ''.
	splitNode 
		contentsFrom: 8
		extent: 10
		do: do.
	self should: [out = '8901'].
	out := ''.
	splitNode 
		contentsFrom: -4
		extent: 20
		do: do.
	self should: [out = '12345678901'].
	out := ''.
	splitNode 
		contentsFrom: -4
		extent: 6
		do: do.
	self should: [out = '1'].
	out := ''.
	splitNode 
		contentsFrom: -4
		extent: 5
		do: do.
	self should: [out = ''].
	out := ''.
	splitNode 
		contentsFrom: 11
		extent: 2
		do: do.
	self should: [out = '1'].
	out := ''.
	splitNode 
		contentsFrom: 12
		extent: 2
		do: do.
	self should: [out = '']!

testCount
	| splitNode |
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: (CollectionLeaf 
						branch: 1
						startPosition: 3
						elements: 'hello ' asAboraContent)
				leftDsp: 12
				right: (CollectionLeaf 
						branch: 1
						startPosition: 100
						elements: 'there' asAboraContent)
				rightDsp: 80.
	self should: [splitNode count = 11]!

testCreate
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 7
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 7
				left: dataLeaf1
				right: dataLeaf2.
	self should: [splitNode split = 7].
	self should: [splitNode left == dataLeaf1].
	self should: [splitNode right == dataLeaf2].
	self should: [dataLeaf1 parents = (OrderedCollection with: splitNode)].
	self should: [dataLeaf2 parents = (OrderedCollection with: splitNode)]!

testCreateDsp
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: dataLeaf1
				leftDsp: 14
				right: dataLeaf2
				rightDsp: -80.
	self should: [splitNode split = 20].
	self should: [splitNode left == dataLeaf1].
	self should: [splitNode leftDsp = 14].
	self should: [splitNode right == dataLeaf2].
	self should: [splitNode rightDsp = -80].
	self should: [dataLeaf1 parents = (OrderedCollection with: splitNode)].
	self should: [dataLeaf2 parents = (OrderedCollection with: splitNode)]!

testDspForChild
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: dataLeaf1
				leftDsp: 14
				right: dataLeaf2
				rightDsp: -80.
	self should: [(splitNode dspForChild: dataLeaf1) = 14].
	self should: [(splitNode dspForChild: dataLeaf2) = -80]!

testDspSetForChild
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: dataLeaf1
				leftDsp: 14
				right: dataLeaf2
				rightDsp: -80.
	splitNode dsp: 15 forChild: dataLeaf1.
	self should: [(splitNode dspForChild: dataLeaf1) = 15].
	self should: [(splitNode dspForChild: dataLeaf2) = -80].
	splitNode dsp: -60 forChild: dataLeaf2.
	self should: [(splitNode dspForChild: dataLeaf1) = 15].
	self should: [(splitNode dspForChild: dataLeaf2) = -60]!

testDuplicate
	| root1 split  newSplit |
	root1 := self createBalanced12345678.
	self assertTextContentsOf: root1 is: '12345678'.

	"operation"
	split := (root1 nodeAt: 8) singleParentFor: 1.
	newSplit := split duplicateFor: 2.

	self should: [split ~~ newSplit].
	self assertTextContentsOf: root1 is: '12345678'.
	self should: [newSplit left == split left].
	self should: [newSplit right == split right].
	self should: [newSplit leftDsp == split leftDsp].
	self should: [newSplit rightDsp == split rightDsp].
	self should: [newSplit parents isEmpty].
	self should: [split parents size = 1].


	
!

testDuplicateAndParents
	| root1 originalChild duplicateSplit root2 |
	root1 := self createBalanced12345678.
	root2 := RootNode 
				edition: nil
				branch: 2
				with: root1 child
				dsp: root1 dsp.
	originalChild := root2 child.
	self assertTextContentsOf: root1 is: '12345678'.

	"operation"
	duplicateSplit := ((root1 nodeAt: 8) singleParentFor: 1) duplicateWithParentsFor: 2.
	self assertTextContentsOf: root1 is: '12345678'.
	self assertTextContentsOf: root2 is: '12345678'.
	self should: [root2 child ~~ originalChild].
	self should: [root2 child right ~~ originalChild right].
	self should: [root2 child left == originalChild left].
	self should: [root2 child right right ~~ originalChild right right].
	self should: [root2 child right left == originalChild right left].
	self should: [root2 child right right right == originalChild right right right].
	self assertTextContentsOf: originalChild is: '12345678'!

testDuplicateAndParentsSameRevision
	| root1 originalChild duplicateSplit originalSplit  |
	root1 := self createBalanced12345678.
	originalChild := root1 child.
	self assertTextContentsOf: root1 is: '12345678'.
	originalSplit := (root1 nodeAt: 8) singleParentFor: 1.

	"operation"
	duplicateSplit := originalSplit duplicateWithParentsFor: 1.
	self should: [duplicateSplit == originalSplit].
	self assertTextContentsOf: root1 is: '12345678'.
	self should: [root1 child == originalChild].
	self should: [((root1 nodeAt: 8) singleParentFor: 1) == originalSplit].
	self should: [originalSplit parents size = 1].!

testDuplicateBadRevision
	| root1 node |
	root1 := self createBalanced12345678.
	self assertTextContentsOf: root1 is: '12345678'.

	"operation"
	node := (root1 nodeAt: 8) singleParentFor: 1.
	self should: [node duplicateFor: 0] raise: EntError.!

testDuplicateSameRevision
	| root1 split  newSplit |
	root1 := self createBalanced12345678.
	self assertTextContentsOf: root1 is: '12345678'.

	"operation"
	split := (root1 nodeAt: 8) singleParentFor: 1.
	newSplit := split duplicateFor: 1.

	self should: [split == newSplit].!

testIsLeft
	| dataLeaf1 dataLeaf2 splitNode |
	dataLeaf1 := CollectionLeaf 
				branch: 1
				startPosition: 3
				elements: 'hello ' asAboraContent.
	dataLeaf2 := CollectionLeaf 
				branch: 1
				startPosition: 100
				elements: 'there' asAboraContent.

	"test"
	splitNode := SplitNode 
				branch: 1
				split: 20
				left: dataLeaf1
				leftDsp: 14
				right: dataLeaf2
				rightDsp: -80.
	self should: [splitNode isLeft: 18].
	self should: [splitNode isLeft: 19].
	self shouldnt: [splitNode isLeft: 20].
	self shouldnt: [splitNode isLeft: 21]!

testSingleRotateLeftDifferentForRevision
	| split1 split2 root1 root2 |
	split1 := SplitNode 
				branch: 1
				split: 2
				left: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'a' asAboraContent)
				leftDsp: 1
				right: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'b' asAboraContent)
				rightDsp: 2.
	split2 := SplitNode 
				branch: 2
				split: 6
				left: split1
				leftDsp: 3
				right: (CollectionLeaf 
						branch: 2
						startPosition: 0
						elements: 'c' asAboraContent)
				rightDsp: 6.
	root1 := RootNode 
				edition: nil
				branch: 1
				with: split1.
	root2 := RootNode 
				edition: nil
				branch: 2
				with: split2
				dsp: 4.
	self should: [(root2 contentsAt: 8) = $a codePoint].
	self should: [(root2 contentsAt: 9) = $b codePoint].
	self should: [(root2 contentsAt: 10) = $c codePoint].
	self should: [(root1 contentsAt: 1) = $a codePoint].
	self should: [(root1 contentsAt: 2) = $b codePoint].
	split2 singleRotateLeftFor: 2.
	"split2 should have been duplicated due to the version difference between split1 & split2"
	self should: [root2 child ~~ split1].
	self should: [root2 child ~~ split2].
	self should: [root2 child right == split2].
	self should: [root1 child == split1].
	self should: [(root2 contentsAt: 8) = $a codePoint].
	self should: [(root2 contentsAt: 9) = $b codePoint].
	self should: [(root2 contentsAt: 10) = $c codePoint].
	self should: [(root1 contentsAt: 1) = $a codePoint].
	self should: [(root1 contentsAt: 2) = $b codePoint]!

testSingleRotateLeftFor
	| split1 split2 root |
	split1 := SplitNode 
				branch: 1
				split: 2
				left: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'a' asAboraContent)
				leftDsp: 1
				right: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'b' asAboraContent)
				rightDsp: 2.
	split2 := SplitNode 
				branch: 1
				split: 6
				left: split1
				leftDsp: 3
				right: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'c' asAboraContent)
				rightDsp: 6.
	root := RootNode 
				edition: nil
				branch: 1
				with: split2
				dsp: 4.
	self should: [(root contentsAt: 8) = $a codePoint].
	self should: [(root contentsAt: 9) = $b codePoint].
	self should: [(root contentsAt: 10) = $c codePoint].
	split2 singleRotateLeftFor: 1.
	self should: [root child == split1].
	self should: [split1 right == split2].
	self should: [(root contentsAt: 8) = $a codePoint].
	self should: [(root contentsAt: 9) = $b codePoint].
	self should: [(root contentsAt: 10) = $c codePoint]!

testSingleRotateRightFor
	| split1 split2 root |
	split1 := SplitNode 
				branch: 1
				split: -1
				left: (CollectionLeaf 
						branch: 1
						startPosition: -4
						elements: 'b' asAboraContent)
				leftDsp: 2
				right: (CollectionLeaf 
						branch: 1
						startPosition: -7
						elements: 'c' asAboraContent)
				rightDsp: 6.
	split2 := SplitNode 
				branch: 1
				split: 2
				left: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'a' asAboraContent)
				leftDsp: 1
				right: split1
				rightDsp: 4.
	root := RootNode 
				edition: nil
				branch: 1
				with: split2
				dsp: 5.
	self should: [(root contentsAt: 6) = $a codePoint].
	self should: [(root contentsAt: 7) = $b codePoint].
	self should: [(root contentsAt: 8) = $c codePoint].
	split2 singleRotateRightFor: 1.
	self should: [root child == split1].
	self should: [split1 left == split2].
	self should: [(root contentsAt: 6) = $a codePoint].
	self should: [(root contentsAt: 7) = $b codePoint].
	self should: [(root contentsAt: 8) = $c codePoint]!

testSingleRotateRightForDifferentRevision
	| split1 split2 root1 root2 |
	split1 := SplitNode 
				branch: 1
				split: -1
				left: (CollectionLeaf 
						branch: 1
						startPosition: -4
						elements: 'b' asAboraContent)
				leftDsp: 2
				right: (CollectionLeaf 
						branch: 1
						startPosition: -7
						elements: 'c' asAboraContent)
				rightDsp: 6.
	split2 := SplitNode 
				branch: 2
				split: 2
				left: (CollectionLeaf 
						branch: 1
						startPosition: 0
						elements: 'a' asAboraContent)
				leftDsp: 1
				right: split1
				rightDsp: 4.
	root1 := RootNode 
				edition: nil
				branch: 1
				with: split1.
	root2 := RootNode 
				edition: nil
				branch: 2
				with: split2
				dsp: 5.
	self should: [(root2 contentsAt: 6) = $a codePoint].
	self should: [(root2 contentsAt: 7) = $b codePoint].
	self should: [(root2 contentsAt: 8) = $c codePoint].
	self should: [(root1 contentsAt: -2) = $b codePoint].
	self should: [(root1 contentsAt: -1) = $c codePoint].
	split2 singleRotateRightFor: 2.
	"split2 should have been duplicated due to the version difference between split1 & split2"
	self should: [root2 child ~~ split1].
	self should: [root2 child ~~ split2].
	self should: [root2 child left == split2].
	self should: [root1 child == split1].
	self should: [(root2 contentsAt: 6) = $a codePoint].
	self should: [(root2 contentsAt: 7) = $b codePoint].
	self should: [(root2 contentsAt: 8) = $c codePoint].
	self should: [(root1 contentsAt: -2) = $b codePoint].
	self should: [(root1 contentsAt: -1) = $c codePoint]! !
!SplitNodeTest categoriesFor: #testAssertIsChild!public! !
!SplitNodeTest categoriesFor: #testChildren!public! !
!SplitNodeTest categoriesFor: #testContents!public! !
!SplitNodeTest categoriesFor: #testContentsAt!public! !
!SplitNodeTest categoriesFor: #testContentsAtBadPosition!public! !
!SplitNodeTest categoriesFor: #testContentsFromExtentDo!public! !
!SplitNodeTest categoriesFor: #testCount!public! !
!SplitNodeTest categoriesFor: #testCreate!public! !
!SplitNodeTest categoriesFor: #testCreateDsp!public! !
!SplitNodeTest categoriesFor: #testDspForChild!public! !
!SplitNodeTest categoriesFor: #testDspSetForChild!public! !
!SplitNodeTest categoriesFor: #testDuplicate!public! !
!SplitNodeTest categoriesFor: #testDuplicateAndParents!public! !
!SplitNodeTest categoriesFor: #testDuplicateAndParentsSameRevision!public! !
!SplitNodeTest categoriesFor: #testDuplicateBadRevision!public! !
!SplitNodeTest categoriesFor: #testDuplicateSameRevision!public! !
!SplitNodeTest categoriesFor: #testIsLeft!public! !
!SplitNodeTest categoriesFor: #testSingleRotateLeftDifferentForRevision!public! !
!SplitNodeTest categoriesFor: #testSingleRotateLeftFor!public! !
!SplitNodeTest categoriesFor: #testSingleRotateRightFor!public! !
!SplitNodeTest categoriesFor: #testSingleRotateRightForDifferentRevision!public! !

