"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #SequenceMagnitudeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SequenceMagnitudeTest guid: (GUID fromString: '{CA612640-4AF8-4D56-B053-68D7B1E70987}')!
SequenceMagnitudeTest comment: ''!
!SequenceMagnitudeTest categoriesForClass!Kernel-Objects! !
!SequenceMagnitudeTest methodsFor!

testCopyWith
	self should: [((SequenceMagnitude with: 1) copyWith: 0) digits = #(1 0)].
	self should: [((SequenceMagnitude with: 3) copyWith: 1) digits = #(3 1)].
	self should: [((SequenceMagnitude with: 1 with: 2) copyWith: 3) digits = #(1 2 3)].
!

testCreate
	self should: [(SequenceMagnitude with: 1) digits = #(1)].
	self should: [(SequenceMagnitude with: 1 with: 2) digits = #(1 2)].
	self should: [(SequenceMagnitude with: 1 with: 2 with: 3) digits = #(1 2 3)].
	self should: [(SequenceMagnitude withAll: #(1 2 3)) digits = #(1 2 3)].

!

testDisplayString
	self should: [(SequenceMagnitude with: 1) displayString  = '1'].
	self should: [(SequenceMagnitude with: 1 with: 2) displayString = '1:2'].
	self should: [(SequenceMagnitude withAll: #(1 2 3)) displayString = '1:2:3'].

!

testEquals
	self should: [(SequenceMagnitude with: 1) = (SequenceMagnitude with: 1)].
	self shouldnt: [(SequenceMagnitude with: 1) = (SequenceMagnitude with: 2)].
	self shouldnt: [(SequenceMagnitude with: 1) = (SequenceMagnitude with: 0)].

	self should: [(SequenceMagnitude with: 1) = (SequenceMagnitude with: 1.0)].
	self should: [(SequenceMagnitude with: 1.0) = (SequenceMagnitude with: 1)].
	self shouldnt: [(SequenceMagnitude with: 1) = (SequenceMagnitude with: 1.1)].

	self should: [(SequenceMagnitude with: 1 with: 2 with: 3) = (SequenceMagnitude with: 1 with: 2 with: 3)].
	self shouldnt: [(SequenceMagnitude with: 1 with: 2 with: 3) = (SequenceMagnitude with: 1 with: 2 with: 30)].!

testEqualsInteger
	self should: [1 = (SequenceMagnitude with: 1)].
	self shouldnt: [1 = (SequenceMagnitude with: 2)].
	self shouldnt: [1 = (SequenceMagnitude with: 0)].

	self should: [1 = (SequenceMagnitude with: 1.0)].
	self shouldnt: [1 = (SequenceMagnitude with: 1.1)].
!

testHash
	| sequence |
	sequence := SequenceMagnitude with: 1.
	self should: [sequence hash  = sequence hash].
	self should: [(SequenceMagnitude with: 1) hash = (SequenceMagnitude with: 1) hash].
	self shouldnt: [(SequenceMagnitude with: 1) hash = (SequenceMagnitude with: 2) hash].
	self shouldnt: [(SequenceMagnitude with: 1) hash = (SequenceMagnitude with: 0) hash].

	self should: [(SequenceMagnitude with: 1 with: 2 with: 3) hash = (SequenceMagnitude with: 1 with: 2 with: 3) hash].
	self shouldnt: [(SequenceMagnitude with: 1 with: 2 with: 3) hash = (SequenceMagnitude with: 1 with: 2 with: 30) hash].!

testIncrementLast
	self should: [(SequenceMagnitude with: 1) incrementLast digits = #(2)].
	self should: [(SequenceMagnitude with: 1 with: 2) incrementLast digits = #(1 3)].
!

testIsZero
	self should: [(SequenceMagnitude withAll: #()) isZero].
	self should: [(SequenceMagnitude with: 0) isZero].
	self should: [(SequenceMagnitude with: 0 with: 0 with: 0) isZero].

	self shouldnt: [(SequenceMagnitude with: 1) isZero].
	self shouldnt: [(SequenceMagnitude with: 0 with: 0 with: 1) isZero].
	self shouldnt: [(SequenceMagnitude with: 1 with: 2 with: 3) isZero].
!

testLessThan
	self should: [(SequenceMagnitude with: 1) < (SequenceMagnitude with: 2)].
	self shouldnt: [(SequenceMagnitude with: 1) < (SequenceMagnitude with: 1)].
	self shouldnt: [(SequenceMagnitude with: 1) < (SequenceMagnitude with: 0)].

	self should: [(SequenceMagnitude with: 1) < (SequenceMagnitude with: 1 with: 1)].
	self shouldnt: [(SequenceMagnitude with: 1) < (SequenceMagnitude with: 1 with: 0)].
	self should: [(SequenceMagnitude withAll: #(2 2 1 1 1)) < (SequenceMagnitude withAll: #(2 2 2))].


	self should: [(SequenceMagnitude with: 1 with: 2 with: 3) < (SequenceMagnitude with: 1 with: 3 with: 1)].
!

testLessThanInteger
	self should: [1 < (SequenceMagnitude with: 2)].
	self shouldnt: [1 < (SequenceMagnitude with: 1)].
	self shouldnt: [1 < (SequenceMagnitude with: 0)].

	self should: [1 < (SequenceMagnitude with: 1.1)].
	self shouldnt: [1 < (SequenceMagnitude with: 1.0)].
!

testPrintString
	self should: [(SequenceMagnitude with: 1) printString  = 'a SequenceMagnitude(1)'].
	self should: [(SequenceMagnitude with: 1 with: 2) printString = 'a SequenceMagnitude(1:2)'].
	self should: [(SequenceMagnitude withAll: #(1 2 3)) printString = 'a SequenceMagnitude(1:2:3)'].

! !
!SequenceMagnitudeTest categoriesFor: #testCopyWith!public! !
!SequenceMagnitudeTest categoriesFor: #testCreate!public! !
!SequenceMagnitudeTest categoriesFor: #testDisplayString!public! !
!SequenceMagnitudeTest categoriesFor: #testEquals!public! !
!SequenceMagnitudeTest categoriesFor: #testEqualsInteger!public! !
!SequenceMagnitudeTest categoriesFor: #testHash!public! !
!SequenceMagnitudeTest categoriesFor: #testIncrementLast!public! !
!SequenceMagnitudeTest categoriesFor: #testIsZero!public! !
!SequenceMagnitudeTest categoriesFor: #testLessThan!public! !
!SequenceMagnitudeTest categoriesFor: #testLessThanInteger!public! !
!SequenceMagnitudeTest categoriesFor: #testPrintString!public! !

