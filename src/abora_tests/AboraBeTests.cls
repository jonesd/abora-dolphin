"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraTests subclass: #AboraBeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraBeTests guid: (GUID fromString: '{8B40BB18-EAF8-4BB9-8BBD-4644045F1CBE}')!
AboraBeTests comment: ''!
!AboraBeTests categoriesForClass!Kernel-Objects! !
!AboraBeTests methodsFor!

assertTextContentsOf: root is: expectedText
	| actualText |
	actualText := root contents asAboraText.
	self should: [actualText = expectedText].
	expectedText
		keysAndValuesDo: [:i :char | self should: [(root contentsAt: i) = char codePoint]]!

createBalanced12345678
	| splitC1 splitC2 splitC3 splitA splitC4 splitB1 splitB2 |
	splitC1 := SplitNode 
				branch: 1
				split: 2
				left: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '1' asAboraContent)
				right: (CollectionLeaf 
						branch: 1
						startPosition: 2
						elements: '2' asAboraContent).
	splitC2 := SplitNode 
				branch: 1
				split: 4
				left: (CollectionLeaf 
						branch: 1
						startPosition: 3
						elements: '3' asAboraContent)
				right: (CollectionLeaf 
						branch: 1
						startPosition: 4
						elements: '4' asAboraContent).
	splitC3 := SplitNode 
				branch: 1
				split: 6
				left: (CollectionLeaf 
						branch: 1
						startPosition: 5
						elements: '5' asAboraContent)
				right: (CollectionLeaf 
						branch: 1
						startPosition: 6
						elements: '6' asAboraContent).
	splitC4 := SplitNode 
				branch: 1
				split: 8
				left: (CollectionLeaf 
						branch: 1
						startPosition: 7
						elements: '7' asAboraContent)
				right: (CollectionLeaf 
						branch: 1
						startPosition: 8
						elements: '8' asAboraContent).
	splitB1 := SplitNode 
				branch: 1
				split: 3
				left: splitC1
				right: splitC2.
	splitB2 := SplitNode 
				branch: 1
				split: 7
				left: splitC3
				right: splitC4.
	splitA := SplitNode 
				branch: 1
				split: 5
				left: splitB1
				right: splitB2.
	^RootNode 
		edition: nil
		branch: 1
		with: splitA!

createSourceEdition12345678
	| edition |
	edition := BeEdition new.
	edition root insert: (CollectionLeaf 
				branch: 1
				startPosition: 1
				elements: '12345678' asAboraContent).
	^edition! !
!AboraBeTests categoriesFor: #assertTextContentsOf:is:!public! !
!AboraBeTests categoriesFor: #createBalanced12345678!private! !
!AboraBeTests categoriesFor: #createSourceEdition12345678!private! !

!AboraBeTests class methodsFor!

isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self name = #AboraBeTests! !
!AboraBeTests class categoriesFor: #isAbstract!public! !

