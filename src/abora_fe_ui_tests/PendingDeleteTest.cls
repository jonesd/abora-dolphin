"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #PendingDeleteTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
PendingDeleteTest guid: (GUID fromString: '{AC8D0380-8A85-4C61-913C-EC72A3897F47}')!
PendingDeleteTest comment: ''!
!PendingDeleteTest categoriesForClass!SUnit! !
!PendingDeleteTest methodsFor!

testCanInsertAt
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.

	self shouldnt: [pending canInsert: 'abc' asAboraContent at: 5].!

testCanRemoveFromExtent
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.

	self should: [pending canRemoveFrom: 5 extent: 1].
	self should: [pending canRemoveFrom: 5 extent: 2].
	self should: [pending canRemoveFrom: 4 extent: 1].
	self should: [pending canRemoveFrom: 4 extent: 4].
	self should: [pending canRemoveFrom: 3 extent: 2].

	self shouldnt: [pending canRemoveFrom: 6 extent: 1].
	self shouldnt: [pending canRemoveFrom: 3 extent: 1].
!

testContents
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.
	self should: [pending contents = '1234890'].

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 1.
	self should: [pending contents = '123467890'].

	pending := PendingDelete textEdition: textEdition startPosition: 1 extent: 1.
	self should: [pending contents = '234567890'].

	pending := PendingDelete textEdition: textEdition startPosition: 1 extent: 2.
	self should: [pending contents = '34567890'].

	pending := PendingDelete textEdition: textEdition startPosition: 10 extent: 1.
	self should: [pending contents = '123456789'].

	pending := PendingDelete textEdition: textEdition startPosition: 9 extent: 2.
	self should: [pending contents = '12345678'].

	pending := PendingDelete textEdition: textEdition startPosition: 1 extent: 10.
	self should: [pending contents = ''].

!

testContentsFromExtent
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.
	self should: [(pending contentsFrom: 1 extent: 7) = '1234890'].
	self should: [(pending contentsFrom: 1 extent: 1) = '1'].
	self should: [(pending contentsFrom: 1 extent: 3) = '123'].
	self should: [(pending contentsFrom: 1 extent: 4) = '1234'].
	self should: [(pending contentsFrom: 5 extent: 3) = '890'].
	self should: [(pending contentsFrom: 5 extent: 1) = '8'].
	self should: [(pending contentsFrom: 7 extent: 1) = '0'].
	self should: [(pending contentsFrom: 4 extent: 1) = '4'].
	self should: [(pending contentsFrom: 4 extent: 2) = '48'].
	self should: [(pending contentsFrom: 4 extent: 4) = '4890'].

	pending := PendingDelete textEdition: textEdition startPosition: 1 extent: 1.
	self should: [(pending contentsFrom: 1 extent: 9) = '234567890'].
	self should: [(pending contentsFrom: 1 extent: 1) = '2'].

	pending := PendingDelete textEdition: textEdition startPosition: 10 extent: 1.
	self should: [(pending contentsFrom: 1 extent: 9) = '123456789'].
	self should: [(pending contentsFrom: 9 extent: 1) = '9'].

!

testCount
	| textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.

	self should: [pending  count = 7].!

testFlushChanges
	| edition  textEdition pending |
	textEdition := FeTextEdition contents: '1234567890'.

	pending := PendingDelete textEdition: textEdition startPosition: 5 extent: 3.
	edition := pending flushChanges.

	self should: [edition contents = '1234890' asAboraContent].
! !
!PendingDeleteTest categoriesFor: #testCanInsertAt!public! !
!PendingDeleteTest categoriesFor: #testCanRemoveFromExtent!public! !
!PendingDeleteTest categoriesFor: #testContents!public! !
!PendingDeleteTest categoriesFor: #testContentsFromExtent!public! !
!PendingDeleteTest categoriesFor: #testCount!public! !
!PendingDeleteTest categoriesFor: #testFlushChanges!public! !

