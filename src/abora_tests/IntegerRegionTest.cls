"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #IntegerRegionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IntegerRegionTest guid: (GUID fromString: '{CD2915BE-FD10-45F1-9E10-F0C1970FEB7B}')!
IntegerRegionTest comment: ''!
!IntegerRegionTest categoriesForClass!Kernel-Objects! !
!IntegerRegionTest methodsFor!

testBeyondPosition
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [region beyondPosition = 13].
!

testCreate
	| region |
	region := IntegerRegion startPosition: 10 extent: 2.
	
	self should: [region startPosition = 10].
	self should: [region extent = 2].!

testCreate2
	| region |
	region := IntegerRegion startPosition: 10 endPosition: 11.
	
	self should: [region startPosition = 10].
	self should: [region extent = 2].!

testDisplayOn
	self should: [(IntegerRegion startPosition: 10 endPosition: 11) displayString = '[10, 11]'].
	self should: [(IntegerRegion startPosition: 10 extent: 1) displayString = '[10, 10]'].
!

testEndPosition
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [region endPosition = 12].
!

testEquals
	| region |
	region := IntegerRegion startPosition: 10 extent: 2.
	
	self should: [region = region].
	self should: [region = (IntegerRegion startPosition: 10 extent: 2)].

	self shouldnt: [region = (IntegerRegion startPosition: 10 extent: 3)].
	self shouldnt: [region = (IntegerRegion startPosition: 10 extent: 1)].
	self shouldnt: [region = (IntegerRegion startPosition: 9 extent: 2)].
	self shouldnt: [region = (IntegerRegion startPosition: 9 extent: 3)].
	self shouldnt: [region = (IntegerRegion startPosition: 10 extent: 0)].
!

testHash
	| region |
	region := IntegerRegion startPosition: 10 extent: 2.

	self should: [region hash isInteger].	
	self should: [region hash  = region hash].
	self should: [region hash = (IntegerRegion startPosition: 10 extent: 2) hash].

	self shouldnt: [region hash = (IntegerRegion startPosition: 10 extent: 3) hash].
	self shouldnt: [region hash = (IntegerRegion startPosition: 10 extent: 0) hash].!

testIncludes
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [region includes: 10].
	self should: [region includes: 11].
	self should: [region includes: 12].

	self should: [(region includes: 9) not].
	self should: [(region includes: 13) not].
!

testIntersection
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [(region intersection: region) = region].
	self should: [(region intersection: (IntegerRegion startPosition: 9 extent: 5)) = (IntegerRegion startPosition: 10 extent: 3)].
	self should: [(region intersection: (IntegerRegion startPosition: 9 extent: 2)) = (IntegerRegion startPosition: 10 extent: 1)].
	self should: [(region intersection: (IntegerRegion startPosition: 12 extent: 4)) = (IntegerRegion startPosition: 12 extent: 1)].
	self should: [(region intersection: (IntegerRegion startPosition: 11 extent: 1)) = (IntegerRegion startPosition: 11 extent: 1)].

	self should: [(region intersection: (IntegerRegion startPosition: 9 extent: 1)) = IntegerRegion empty].
	self should: [(region intersection: (IntegerRegion startPosition: 13 extent: 4)) = IntegerRegion empty].
!

testIntersects
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [region intersects: region].
	self should: [region intersects: (IntegerRegion startPosition: 9 extent: 5)].
	self should: [region intersects: (IntegerRegion startPosition: 9 extent: 2)].
	self should: [region intersects: (IntegerRegion startPosition: 12 extent: 4)].
	self should: [region intersects: (IntegerRegion startPosition: 11 extent: 1)].

	self shouldnt: [region intersects: (IntegerRegion startPosition: 9 extent: 1)].
	self shouldnt: [region intersects: (IntegerRegion startPosition: 13 extent: 4)].
!

testIsEmpty
	self should: [(IntegerRegion startPosition: 10 extent: 0) isEmpty].
	self should: [(IntegerRegion startPosition: 10 extent: -1) isEmpty].
	self shouldnt: [(IntegerRegion startPosition: 10 extent: 1) isEmpty].
!

testRelativePosition
	| region |
	region := IntegerRegion startPosition: 10 extent: 3.
	
	self should: [(region relativePosition: 9) = -1].
	self should: [(region relativePosition: 10) = 0].
	self should: [(region relativePosition: 11) = 1].
	self should: [(region relativePosition: 12) = 2].
	self should: [(region relativePosition: 13) = 3].
! !
!IntegerRegionTest categoriesFor: #testBeyondPosition!public! !
!IntegerRegionTest categoriesFor: #testCreate!public! !
!IntegerRegionTest categoriesFor: #testCreate2!public! !
!IntegerRegionTest categoriesFor: #testDisplayOn!public! !
!IntegerRegionTest categoriesFor: #testEndPosition!public! !
!IntegerRegionTest categoriesFor: #testEquals!public! !
!IntegerRegionTest categoriesFor: #testHash!public! !
!IntegerRegionTest categoriesFor: #testIncludes!public! !
!IntegerRegionTest categoriesFor: #testIntersection!public! !
!IntegerRegionTest categoriesFor: #testIntersects!public! !
!IntegerRegionTest categoriesFor: #testIsEmpty!public! !
!IntegerRegionTest categoriesFor: #testRelativePosition!public! !

