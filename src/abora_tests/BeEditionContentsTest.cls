"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BeEditionContentsTest
	instanceVariableNames: 'edition'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeEditionContentsTest guid: (GUID fromString: '{7D2C3C42-36F7-467B-A00F-4DF95132687C}')!
BeEditionContentsTest comment: ''!
!BeEditionContentsTest categoriesForClass!SUnit! !
!BeEditionContentsTest methodsFor!

setUp
	edition := BeEdition new.!

testAppendMultiple
	edition := edition append: 'Hello ' asAboraContent.
	edition := edition append: 'there ' asAboraContent.
	edition := edition append: 'today!!' asAboraContent.
	self assertTextContentsOf: edition is: 'Hello there today!!'!

testAppendToEmpty
	edition := edition append: 'Hello' asAboraContent.
	self assertTextContentsOf: edition is: 'Hello'!

testEmpty
	| newEdition |
	newEdition := BeEdition new.
	self should: [newEdition contents isEmpty]!

testFindElementAt
	edition := edition append: '123' asAboraContent.
	edition := edition append: '456' asAboraContent.
	self should: [(edition findElementAt: 1) elements = '123' asAboraContent].
	self should: [(edition findElementAt: 2) elements = '123' asAboraContent].
	self should: [(edition findElementAt: 3) elements = '123' asAboraContent].
	self should: [(edition findElementAt: 4) elements = '456' asAboraContent].
	self should: [(edition findElementAt: 5) elements = '456' asAboraContent].
	self should: [(edition findElementAt: 6) elements = '456' asAboraContent].
!

testFindElementAtAfterEnd
	edition := edition append: '123' asAboraContent.
	self should: [edition findElementAt: 4] raise: BoundsError!

testFindElementAtBeforeStart
	edition := edition append: '123' asAboraContent.
	self should: [edition findElementAt: 0] raise: BoundsError!

testFindElementAtIndividual
	edition := edition append: '1' asAboraContent.
	edition := edition append: '2' asAboraContent.
	edition := edition append: '3' asAboraContent.
	edition := edition append: '4' asAboraContent.
	self should: [(edition findElementAt: 1) contents = '1' asAboraContent].
	self should: [(edition findElementAt: 2) contents = '2' asAboraContent].
	self should: [(edition findElementAt: 3) contents = '3' asAboraContent].
	self should: [(edition findElementAt: 4) contents = '4' asAboraContent].
!

testFindElementAtPairs
	edition := edition append: '12' asAboraContent.
	edition := edition append: '34' asAboraContent.
	edition := edition append: '56' asAboraContent.
	self should: [(edition findElementAt: 1) contents = '12' asAboraContent].
	self should: [(edition findElementAt: 2) contents = '12' asAboraContent].
	self should: [(edition findElementAt: 3) contents = '34' asAboraContent].
	self should: [(edition findElementAt: 4) contents = '34' asAboraContent].
	self should: [(edition findElementAt: 5) contents = '56' asAboraContent].
	self should: [(edition findElementAt: 6) contents = '56' asAboraContent].
!

testInsert
	edition := edition append: '123456' asAboraContent.
	edition := edition insert: 'abc' asAboraContent at: 3.
	self assertTextContentsOf: edition is: '12abc3456'!

testInsertAfterEnd
	edition := edition append: '123456' asAboraContent.
	self should: [edition insert: 'abc' asAboraContent at: 8] raise: BoundsError!

testInsertAtBeginning
	edition := edition append: '123456' asAboraContent.
	edition := edition insert: 'abc' asAboraContent at: 1.
	self assertTextContentsOf: edition is: 'abc123456'!

testInsertAtEndOfSubsequentElement
	edition := edition append: '123' asAboraContent.
	edition := edition append: '456' asAboraContent.
	edition := edition insert: 'abcdef' asAboraContent at: 3.
	self assertTextContentsOf: edition is: '12abcdef3456'!

testInsertAtStartOfSubsequentElement
	edition := edition append: '123' asAboraContent.
	edition := edition append: '456' asAboraContent.
	edition := edition insert: 'abc' asAboraContent at: 4.
	self assertTextContentsOf: edition is: '123abc456'!

testInsertBeforeStart
	edition := edition append: '123456' asAboraContent.
	self should: [edition insert: 'abc' asAboraContent at: 0] raise: BoundsError!

testInsertImmedatelyAfterEnd
	edition := edition append: '123456' asAboraContent.
	edition := edition insert: 'abc' asAboraContent at: 7.	"should add"
	self assertTextContentsOf: edition is: '123456abc'!

testInsertMultiple
	edition := edition append: '123456' asAboraContent.
	edition := edition insert: 'abc' asAboraContent at: 3.
	self assertTextContentsOf: edition is: '12abc3456'.
	edition := edition insert: 'd' asAboraContent at: 6.
	self assertTextContentsOf: edition is: '12abcd3456'.
	edition := edition insert: 'e' asAboraContent at: 7.
	self assertTextContentsOf: edition is: '12abcde3456'.
	edition := edition insert: 'f' asAboraContent at: 8.
	self assertTextContentsOf: edition is: '12abcdef3456'.
	edition := edition insert: 'xy' asAboraContent at: 8.
	self assertTextContentsOf: edition is: '12abcdexyf3456'.
	edition := edition insert: 'z' asAboraContent at: 8.
	self assertTextContentsOf: edition is: '12abcdezxyf3456'!

testInsertRandom
	| random expected |
	random := Random seed: 12345678.
	expected := 'x'.
	edition := edition insert: 'x' asAboraContent at: 1.
	1 to: 50
		do: 
			[:i | 
			| index |
			index := (random next * expected size) floor + 1.
			expected := (expected copyFrom: 1 to: index - 1) , i printString 
						, (expected copyFrom: index to: expected size).
			edition := edition insert: i printString asAboraContent at: index.
			"edition root inspectNodes."
			self assertTextContentsOf: edition root is: expected]!

testRemoveFromExtent
	edition := edition append: '123456' asAboraContent.
	edition := edition removeFrom: 2 extent: 3.
	self assertTextContentsOf: edition is: '156'!

testRemoveFromExtentFirst
	edition := edition append: '123456' asAboraContent.
	edition := edition append: '789' asAboraContent.
	edition := edition removeFrom: 1 extent: 3.
	self assertTextContentsOf: edition is: '456789'!

testRemoveFromExtentLast
	edition := edition append: '123' asAboraContent.
	edition := edition append: '456789' asAboraContent.
	edition := edition removeFrom: 7 extent: 3.
	self assertTextContentsOf: edition is: '123456'!

testRemoveFromExtentMiddle
	edition := edition append: '123456' asAboraContent.
	edition := edition removeFrom: 2 extent: 3.
	self assertTextContentsOf: edition is: '156'!

testRemoveFromExtentMultiple
	edition := edition append: '123' asAboraContent.
	edition := edition append: '456' asAboraContent.
	edition := edition append: '789' asAboraContent.
	edition := edition removeFrom: 3 extent: 5.
	self assertTextContentsOf: edition is: '1289'!

testRemoveFromIndividuals
	edition := edition append: '1' asAboraContent.
	edition := edition append: '2' asAboraContent.
	edition := edition append: '3' asAboraContent.
	edition := edition append: '4' asAboraContent.
	edition := edition append: '5' asAboraContent.
	edition := edition append: '6' asAboraContent.
	edition := edition append: '7' asAboraContent.
	edition := edition removeFrom: 4 extent: 2.
	self assertTextContentsOf: edition is: '12367'!

testRemoveRandom
	| random expected |
	random := Random seed: 12345678.
	expected := 'x'.
	edition := edition insert: 'x' asAboraContent at: 1.
	1 to: 50
		do: 
			[:i | 
			| index |
			index := (random next * expected size) floor + 1.
			expected := (expected copyFrom: 1 to: index - 1) , i printString 
						, (expected copyFrom: index to: expected size).
			edition := edition insert: i printString asAboraContent at: index.
			"edition root inspectNodes."
			self assertTextContentsOf: edition is: expected].
	[expected notEmpty] whileTrue: 
			[| index size |
			index := (random next * expected size) floor + 1.
			size := (random next * 5) floor + 1 min: expected size - index + 1.
			expected := (expected copyFrom: 1 to: index - 1) 
						, (expected copyFrom: index + size to: expected size).
			edition := edition removeFrom: index extent: size.
			self assertTextContentsOf: edition is: expected]!

testTextContentsFromExtent
	edition := edition append: '123' asAboraContent.
	edition := edition append: '4' asAboraContent.
	edition := edition append: '5' asAboraContent.
	self should: [(edition contentsFrom: 1 extent: 1) = '1' asAboraContent].
	self should: [(edition contentsFrom: 1 extent: 5) = '12345' asAboraContent].
	self should: [(edition contentsFrom: 2 extent: 3) = '234' asAboraContent].
	self should: [(edition contentsFrom: 5 extent: 1) = '5' asAboraContent]!

testTextContentSizeEmpty
	self should: [edition count = 0]!

testTextContentsSize
	edition := edition append: '123' asAboraContent.
	edition := edition append: '4' asAboraContent.
	edition := edition append: '5' asAboraContent.
	self should: [edition count = 5]!

testTranscludeEditionFromExtentTo
	edition := edition append: '123456' asAboraContent.
	edition := edition 
		transcludeEdition: edition
		from: 2
		extent: 3
		to: 7.
	self assertTextContentsOf: edition is: '123456234'!

testTranscludeEditionFromExtentToIndividuals
	| work edition1 edition2 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition1 := edition1 append: '1' asAboraContent.
	edition1 := edition1 append: '2' asAboraContent.
	edition1 := edition1 append: '3' asAboraContent.
	edition1 := edition1 append: '4' asAboraContent.
	edition1 := edition1 append: '5' asAboraContent.
	edition2 := edition1
		transcludeEdition: edition1
		from: 2
		extent: 3
		to: 3.
	self assertTextContentsOf: edition2 is: '12234345'.
	self assertTextContentsOf: edition1 is: '12345'!

testTranscludeEditionFromExtentToOtherEdition
	| edition1 edition2 |
	edition1 := BeEdition new.
	edition1 := edition1 append: '1' asAboraContent.
	edition1 := edition1 append: '2' asAboraContent.
	edition1 := edition1 append: '3' asAboraContent.
	edition1 := edition1 append: '4' asAboraContent.
	edition1 := edition1 append: '5' asAboraContent.
	"test"
	edition2 := BeEdition new.
	edition2 := edition2
		transcludeEdition: edition1
		from: 2
		extent: 3
		to: 1.
	self assertTextContentsOf: edition1 is: '12345'.
	self assertTextContentsOf: edition2 is: '234'.

	"ensure edition1 modifications dont show through"
	edition2 := edition2 insert: 'a' asAboraContent at: 3.
	self assertTextContentsOf: edition1 is: '12345'.
	self assertTextContentsOf: edition2 is: '23a4'.

	edition1 := edition1 insert: 'xy' asAboraContent at: 1.
	self assertTextContentsOf: edition1 is: 'xy12345'.
	self assertTextContentsOf: edition2 is: '23a4'
! !
!BeEditionContentsTest categoriesFor: #setUp!private! !
!BeEditionContentsTest categoriesFor: #testAppendMultiple!public! !
!BeEditionContentsTest categoriesFor: #testAppendToEmpty!public! !
!BeEditionContentsTest categoriesFor: #testEmpty!public! !
!BeEditionContentsTest categoriesFor: #testFindElementAt!public! !
!BeEditionContentsTest categoriesFor: #testFindElementAtAfterEnd!public! !
!BeEditionContentsTest categoriesFor: #testFindElementAtBeforeStart!public! !
!BeEditionContentsTest categoriesFor: #testFindElementAtIndividual!public! !
!BeEditionContentsTest categoriesFor: #testFindElementAtPairs!public! !
!BeEditionContentsTest categoriesFor: #testInsert!public! !
!BeEditionContentsTest categoriesFor: #testInsertAfterEnd!public! !
!BeEditionContentsTest categoriesFor: #testInsertAtBeginning!public! !
!BeEditionContentsTest categoriesFor: #testInsertAtEndOfSubsequentElement!public! !
!BeEditionContentsTest categoriesFor: #testInsertAtStartOfSubsequentElement!public! !
!BeEditionContentsTest categoriesFor: #testInsertBeforeStart!public! !
!BeEditionContentsTest categoriesFor: #testInsertImmedatelyAfterEnd!public! !
!BeEditionContentsTest categoriesFor: #testInsertMultiple!public! !
!BeEditionContentsTest categoriesFor: #testInsertRandom!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromExtent!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromExtentFirst!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromExtentLast!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromExtentMiddle!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromExtentMultiple!public! !
!BeEditionContentsTest categoriesFor: #testRemoveFromIndividuals!public! !
!BeEditionContentsTest categoriesFor: #testRemoveRandom!public! !
!BeEditionContentsTest categoriesFor: #testTextContentsFromExtent!public! !
!BeEditionContentsTest categoriesFor: #testTextContentSizeEmpty!public! !
!BeEditionContentsTest categoriesFor: #testTextContentsSize!public! !
!BeEditionContentsTest categoriesFor: #testTranscludeEditionFromExtentTo!public! !
!BeEditionContentsTest categoriesFor: #testTranscludeEditionFromExtentToIndividuals!public! !
!BeEditionContentsTest categoriesFor: #testTranscludeEditionFromExtentToOtherEdition!public! !

