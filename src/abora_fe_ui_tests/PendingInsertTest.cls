"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #PendingInsertTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PendingInsertTest guid: (GUID fromString: '{685B548C-0D61-452B-B64E-6E8B4E8EE866}')!
PendingInsertTest comment: ''!
!PendingInsertTest categoriesForClass!SUnit! !
!PendingInsertTest methodsFor!

testCanInsertAt
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.

	self should: [pending canInsert: '1' at: 5].
	self should: [pending canInsert: '1' at: 6].
	self should: [pending canInsert: '1' at: 7].
	self should: [pending canInsert: '1' at: 8].

	self shouldnt: [pending canInsert: '1' at: 4].
	self shouldnt: [pending canInsert: '1' at: 9].

!

testCanRemoveFromExtent
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.

	self should: [pending canRemoveFrom: 5 extent: 1].
	self should: [pending canRemoveFrom: 5 extent: 3].
	self should: [pending canRemoveFrom: 6 extent: 1].
	self should: [pending canRemoveFrom: 6 extent: 2].
	self should: [pending canRemoveFrom: 7 extent: 1].

	self shouldnt: [pending canRemoveFrom: 4 extent: 1].
	self shouldnt: [pending canRemoveFrom: 8 extent: 1].
	self shouldnt: [pending canRemoveFrom: 4 extent: 2].
	self shouldnt: [pending canRemoveFrom: 4 extent: 4].
	self shouldnt: [pending canRemoveFrom: 7 extent: 2].!

testContents
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	self should: [pending contents = '1234abc567890'].

	pending := PendingInsert textEdition: textEdition position: 1 text: 'abc'.
	self should: [pending contents = 'abc1234567890'].

	pending := PendingInsert textEdition: textEdition position: 10 text: 'abc'.
	self should: [pending contents = '123456789abc0'].

	pending := PendingInsert textEdition: textEdition position: 11 text: 'abc'.
	self should: [pending contents = '1234567890abc'].

	pending := PendingInsert textEdition: textEdition position: 5 text: String lineDelimiter, String lineDelimiter.
	self should: [pending contents = ('1234', String lineDelimiter, String lineDelimiter, '567890')].

!

testContentsFromExtent
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.

	self should: [(pending contentsFrom: 1 extent: 13) = '1234abc567890'].
	self should: [(pending contentsFrom: 1 extent: 10) = '1234abc567'].
	self should: [(pending contentsFrom: 1 extent: 1) = '1'].
	self should: [(pending contentsFrom: 2 extent: 3) = '234'].
	self should: [(pending contentsFrom: 13 extent: 1) = '0'].
	self should: [(pending contentsFrom: 10 extent: 3) = '789'].
	self should: [(pending contentsFrom: 5 extent: 3) = 'abc'].
	self should: [(pending contentsFrom: 5 extent: 1) = 'a'].
	self should: [(pending contentsFrom: 6 extent: 1) = 'b'].
	self should: [(pending contentsFrom: 7 extent: 1) = 'c'].
	self should: [(pending contentsFrom: 3 extent: 5) = '34abc'].
	self should: [(pending contentsFrom: 3 extent: 3) = '34a'].
	self should: [(pending contentsFrom: 5 extent: 5) = 'abc56'].
	self should: [(pending contentsFrom: 7 extent: 3) = 'c56'].
	self should: [(pending contentsFrom: 6 extent: 5) = 'bc567'].
	self should: [(pending contentsFrom: 8 extent: 3) = '567'].
	self should: [(pending contentsFrom: 8 extent: 1) = '5'].
!

testCount
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.

	self should: [pending count  = 13].!

testFlushChanges
	| edition textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	edition := pending flushChanges.

	self should: [edition contents = '1234abc567890' asAboraContent].!

testInsertAt
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending insert: '1' at: 5.
	self should: [pending text = '1abc'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending insert: '1' at: 6.
	self should: [pending text = 'a1bc'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending insert: '1' at: 7.
	self should: [pending text = 'ab1c'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending insert: '1' at: 8.
	self should: [pending text = 'abc1'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending insert: '12345' at: 5.
	self should: [pending text = '12345abc'].
!

testRemoveFromExtent
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 5 extent: 1.
	self should: [pending contents = '1234bc567890'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 5 extent: 2.
	self should: [pending contents = '1234c567890'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 5 extent: 3.
	self should: [pending contents = '1234567890'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 6 extent: 1.
	self should: [pending contents = '1234ac567890'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 6 extent: 2.
	self should: [pending contents = '1234a567890'].

	pending := PendingInsert textEdition: textEdition position: 5 text: 'abc'.
	pending removeFrom: 7 extent: 1.
	self should: [pending contents = '1234ab567890'].
! !
!PendingInsertTest categoriesFor: #testCanInsertAt!public! !
!PendingInsertTest categoriesFor: #testCanRemoveFromExtent!public! !
!PendingInsertTest categoriesFor: #testContents!public! !
!PendingInsertTest categoriesFor: #testContentsFromExtent!public! !
!PendingInsertTest categoriesFor: #testCount!public! !
!PendingInsertTest categoriesFor: #testFlushChanges!public! !
!PendingInsertTest categoriesFor: #testInsertAt!public! !
!PendingInsertTest categoriesFor: #testRemoveFromExtent!public! !

