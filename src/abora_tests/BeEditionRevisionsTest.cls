"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BeEditionRevisionsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeEditionRevisionsTest guid: (GUID fromString: '{1EE1497F-63CB-498C-976B-677E4CF14E57}')!
BeEditionRevisionsTest comment: ''!
!BeEditionRevisionsTest categoriesForClass!Unclassified! !
!BeEditionRevisionsTest methodsFor!

testInsertRandomDifferentRevisions
	| work edition random expected expecteds |
	edition := BeEdition new.
	random := Random seed: 12345678.
	expected := 'x'.
	expecteds := OrderedCollection with: expected.
	edition := edition insert: expected asAboraContent at: 1.
	work := BeWork edition: edition.
	1 to: 20
		do: 
			[:i | 
			| index |
			index := (random next * expected size) floor + 1.
			expected := (expected copyFrom: 1 to: index - 1) , i printString 
						, (expected copyFrom: index to: expected size).
			expecteds add: expected.
			edition := edition insert: i printString asAboraContent at: index.
			work revise: edition.
			"edition root inspectNodes."
			(work  revisions contents copyWith: work) with: expecteds
				do: [:revision :exp | self assertTextContentsOf: revision edition root is: exp]]!

testRemoveRandomDifferentRevisions
	| work edition random expected expecteds |
	edition := BeEdition new.
	random := Random seed: 12345678.
	expected := 'x'.
	expecteds := OrderedCollection with: expected.
	edition := edition insert: expected asAboraContent at: 1.
	work := BeWork edition: edition.
	1 to: 20
		do: 
			[:i | 
			| index |
			index := (random next * expected size) floor + 1.
			expected := (expected copyFrom: 1 to: index - 1) , i printString 
						, (expected copyFrom: index to: expected size).
			expecteds add: expected.
			edition := edition insert: i printString asAboraContent at: index.
			work revise: edition.
			"edition root inspectNodes."
			(work revisions contents copyWith: work) with: expecteds
				do: [:revision :exp | self assertTextContentsOf: revision edition root is: exp]].
	[expected notEmpty] whileTrue: 
			[| index size |
			index := (random next * expected size) floor + 1.
			size := (random next * 5) floor + 1 min: expected size - index + 1.
			expected := (expected copyFrom: 1 to: index - 1) 
						, (expected copyFrom: index + size to: expected size).
			expecteds add: expected.
			edition := edition removeFrom: index extent: size.
			work revise: edition.
			(work revisions contents copyWith: work) with: expecteds
				do: [:revision :exp | self assertTextContentsOf: revision edition root is: exp]]! !
!BeEditionRevisionsTest categoriesFor: #testInsertRandomDifferentRevisions!public! !
!BeEditionRevisionsTest categoriesFor: #testRemoveRandomDifferentRevisions!public! !

