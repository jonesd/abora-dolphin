"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BranchingMagnitudeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BranchingMagnitudeTest guid: (GUID fromString: '{13BC36A1-58F1-4535-B3F9-FB4A9E5A4D9B}')!
BranchingMagnitudeTest comment: ''!
!BranchingMagnitudeTest categoriesForClass!Kernel-Objects! !
!BranchingMagnitudeTest methodsFor!

testCreate
	self should: [(BranchingNumber with: 1) digits = #(1)].
	self should: [(BranchingNumber with: 1 with: 2) digits = #(1 2)].
	self should: [(BranchingNumber with: 1 with: 2 with: 3) digits = #(1 2 3)].
	self should: [(BranchingNumber withAll: #(1 2 3)) digits = #(1 2 3)].

!

testLessThan
	self should: [(BranchingNumber with: 1) < (BranchingNumber with: 2)].
	self shouldnt: [(BranchingNumber with: 1) < (BranchingNumber with: 1)].
	self shouldnt: [(BranchingNumber with: 1) < (BranchingNumber with: 0)].

	self should: [(BranchingNumber with: 1) < (BranchingNumber with: 1 with: 1)].
	self should: [(BranchingNumber with: 1) < (BranchingNumber with: 1 with: 0)].

	self should: [(BranchingNumber withAll: #(2 2 1)) < (BranchingNumber withAll: #(2 2 2))].
	self should: [(BranchingNumber withAll: #(2 2 1)) < (BranchingNumber withAll: #(2 2 1 1 1))].
	self shouldnt: [(BranchingNumber withAll: #(2 2 1 1 1)) < (BranchingNumber withAll: #(2 2 2))].
	self shouldnt: [(BranchingNumber withAll: #(2 2 1 1 1)) < (BranchingNumber withAll: #(2 2 2 1 1))].

	self shouldnt: [(BranchingNumber with: 1 with: 2 with: 3) < (BranchingNumber with: 1 with: 3 with: 1)].
! !
!BranchingMagnitudeTest categoriesFor: #testCreate!public! !
!BranchingMagnitudeTest categoriesFor: #testLessThan!public! !

