"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BeEditionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeEditionTest guid: (GUID fromString: '{1A0FD390-2F2C-4E86-82DF-338E53FA6B43}')!
BeEditionTest comment: ''!
!BeEditionTest categoriesForClass!SUnit! !
!BeEditionTest methodsFor!

testAddWork
	| work edition |
	edition := BeEdition new.

	work := BeWork new.

	edition addWork: work.

	self should: [edition works size = 1].
	self should: [edition works includes: work].!

testAppendOldEdition
	| work edition1 edition11 edition2 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition1 := edition1 append: '123' asAboraContent.
	edition2 := edition1 append: '4' asAboraContent.

	"test"
	edition11 := edition1 append: '5' asAboraContent.
	self assertTextContentsOf: edition1 is: '123'.
	self assertTextContentsOf: edition11 is: '1235'.
	self assertTextContentsOf: edition2 is: '1234'!

testCombineMappings
	| edition mappings combinedMappings |
	edition := BeEdition new.

	mappings := OrderedCollection new.
	combinedMappings := edition combineMappings: mappings.
	self should: [combinedMappings isEmpty].

	mappings := OrderedCollection with: (OrderedCollection with: (IntegerRegion startPosition: 1 extent: 2) with: (IntegerRegion startPosition: 3 extent: 2)).
	combinedMappings := edition combineMappings: mappings.
	self should: [combinedMappings size = 1].
	self should: [combinedMappings first first = (IntegerRegion startPosition: 1 extent: 2)].
	self should: [combinedMappings first last = (IntegerRegion startPosition: 3 extent: 2)].

	mappings := OrderedCollection with: (OrderedCollection with: (IntegerRegion startPosition: 1 extent: 2) with: (IntegerRegion startPosition: 3 extent: 2)) with: (OrderedCollection with: (IntegerRegion startPosition: 4 extent: 5) with: (IntegerRegion startPosition: 6 extent: 5)) with: (OrderedCollection with: (IntegerRegion startPosition: 3 extent: 1) with: (IntegerRegion startPosition: 5 extent: 1)).
	combinedMappings := edition combineMappings: mappings.
	self should: [combinedMappings size = 1].
	self should: [combinedMappings first first = (IntegerRegion startPosition: 1 extent: 8)].
	self should: [combinedMappings first last = (IntegerRegion startPosition: 3 extent: 8)].

	mappings := OrderedCollection with: (OrderedCollection with: (IntegerRegion startPosition: 1 extent: 2) with: (IntegerRegion startPosition: 3 extent: 2)) with: (OrderedCollection with: (IntegerRegion startPosition: 6 extent: 5) with: (IntegerRegion startPosition: 8 extent: 5)) with: (OrderedCollection with: (IntegerRegion startPosition: 4 extent: 1) with: (IntegerRegion startPosition: 6 extent: 1)).
	combinedMappings := edition combineMappings: mappings.
	self should: [combinedMappings size = 3].
	self should: [combinedMappings first first = (IntegerRegion startPosition: 1 extent: 2)].
	self should: [combinedMappings first last = (IntegerRegion startPosition: 3 extent: 2)].
	self should: [combinedMappings second first = (IntegerRegion startPosition: 4 extent: 1)].
	self should: [combinedMappings second last = (IntegerRegion startPosition: 6 extent: 1)].
	self should: [combinedMappings third first = (IntegerRegion startPosition: 6 extent: 5)].
	self should: [combinedMappings third last = (IntegerRegion startPosition: 8 extent: 5)].

!

testCount
	| work edition |
	edition := BeEdition new.
	self should: [edition count = 0].

	edition := BeEdition contents: '123' asAboraContent.
	self should: [edition count = 3].

	edition := BeEdition contents: BeEdition new.
	self should: [edition count = 1].!

testCreate
	| work edition |
	edition := BeEdition new.

	self assertTextContentsOf: edition is: ''.
	self should: [edition branch  = 1].
	self should: [edition works isEmpty].!

testEndorse
	| work edition endorsement1 endorsement2 edition2 endorsements |
	edition := BeEdition new.
	edition2 := BeEdition new.
	endorsement1 := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds textEdition.
	endorsement2 := Endorsement endorseeId: SystemIds universalPublicClub itemId: edition2 id.
	endorsements := edition endorsements.
	self should: [edition endorsements isEmpty].
	edition endorse: endorsement1.
	endorsements := edition endorsements.
	self should: [endorsements size = 1].
	self should: [endorsements includes: endorsement1].
	edition endorse: endorsement2.
	endorsements := edition endorsements.
	self should: [edition endorsements size = 2].
	self should: [endorsements includes: endorsement1].
	self should: [endorsements includes: endorsement2].
	edition endorse: endorsement2.
	endorsements := edition endorsements.
	self should: [edition endorsements size = 2]!

testEndorsements
	| edition |
	edition := BeEdition new.

	self should: [edition endorsements isEmpty].!

testInsertEditions
	| edition editionA editionB editionC|
	edition := BeEdition new.

	editionA := BeEdition contents: '123' asAboraContent.
	editionB := BeEdition contents: '4567' asAboraContent.
	editionC := BeEdition contents: '89' asAboraContent.

	edition := edition insert: editionA at: 1.

	self should: [edition contents = (Array with: editionA)].
	edition := edition insert: editionC at: 2.
	edition := edition insert: editionB at: 2.

	self should: [edition contents = (Array with: editionA with: editionB with: editionC)].
	self should: [edition count = 3].

	edition := edition removeFrom: 1 extent: 2.
	self should: [edition contents = (Array with: editionC)].!

testInsertOldEdition
	| work edition1 edition11 edition2 edition3 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition1 := edition1 append: '123' asAboraContent.
	edition2 := edition1 append: '4' asAboraContent.
	edition3 := edition2 insert: 'c' asAboraContent at: 3.

	"test"
	edition11 := edition1 insert: '5' asAboraContent at: 2.
	self assertTextContentsOf: edition1 is: '123'.
	self assertTextContentsOf: edition11 is: '1523'.
	self assertTextContentsOf: edition2 is: '1234'.
	self assertTextContentsOf: edition3 is: '12c34'.
!

testIsEmpty
	| work edition |
	edition := BeEdition new.
	self should: [edition isEmpty].

	edition := BeEdition contents: '123' asAboraContent.
	self shouldnt: [edition isEmpty].

	edition := BeEdition contents: BeEdition new.
	self shouldnt: [edition isEmpty].!

testNewEdition
	| work edition1 edition2 edition3 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition1 := edition1 append: '123' asAboraContent.
	edition1 := edition1 append: '4' asAboraContent.
	edition1 := edition1 append: '5' asAboraContent.
	edition2 := BeEdition edition: edition1.
	self assertTextContentsOf: edition1 root is: '12345'.
	self assertTextContentsOf: edition2 root is: '12345'.
	self should: [edition1 branch  = 4].
	self should: [edition2 branch = 5].

	"changes should now be independent"
	edition2 := edition2 insert: 'abc' asAboraContent at: 3.
	self assertTextContentsOf: edition1 root is: '12345'.
	self assertTextContentsOf: edition2 root is: '12abc345'.
	edition3 := BeEdition edition: edition2.
	edition3 := edition3 removeFrom: 5 extent: 2.
	self assertTextContentsOf: edition1 root is: '12345'.
	self assertTextContentsOf: edition2 root is: '12abc345'.
	self assertTextContentsOf: edition3 root is: '12ab45'!

testNewEditionEmpty
	| work edition1 edition2 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition2 := BeEdition edition: edition1.
	self assertTextContentsOf: edition1 is: ''.
	self assertTextContentsOf: edition2 is: ''.

	"changes should now be independent"
	edition2 := edition2 append: '123' asAboraContent.
	self assertTextContentsOf: edition2 is: '123'.
	self assertTextContentsOf: edition1 is: ''!

testNextRevision
	| work edition edition2 |
	edition := BeEdition new.
	self should: [edition branch  = 1].
	self should: [edition nextBranch = 2].
	self should: [edition nextBranch = (BranchingNumber withAll: #(1 1 1))].
	self should: [edition nextBranch = (BranchingNumber withAll: #(1 2 1))].
	edition2 := BeEdition edition: edition.
	self should: [edition2 branch  = (BranchingNumber withAll: #(1 3 1))].
	self should: [edition2 nextBranch = (BranchingNumber withAll: #(1 3 2))].
	self should: [edition2 nextBranch = (BranchingNumber withAll: #(1 3 1 1 1))].
	self should: [edition2 nextBranch = (BranchingNumber withAll: #(1 3 1 2 1))]!

testRemoveOldEdition
	| work edition1 edition11 edition2 |
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	edition1 := edition1 append: '123' asAboraContent.
	edition2 := edition1 removeFrom: 2 extent: 1.

	"test"
	edition11 := edition1 removeFrom: 1 extent: 1.

	self assertTextContentsOf: edition1 is: '123'.
	self assertTextContentsOf: edition11 is: '23'.
	self assertTextContentsOf: edition2 is: '13'.
!

testRemoveWork
	| work1 work2 edition |
	edition := BeEdition new.

	work1 := BeWork new.
	work2 := BeWork new.
	edition addWork: work1.
	edition addWork: work2.

	edition removeWork: work1.

	self should: [edition works size = 1].
	self should: [edition works includes: work2].

	edition removeWork: work2.

	self should: [edition works isEmpty].
!

testRetract
	| work edition endorsement1 endorsement2 edition2 endorsements |
	edition := BeEdition new.
	edition2 := BeEdition new.
	endorsement1 := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds textEdition.
	endorsement2 := Endorsement endorseeId: SystemIds universalPublicClub itemId: edition2 id.
	edition endorse: endorsement1.
	edition endorse: endorsement2.
	endorsements := edition endorsements.
	self should: [edition endorsements size = 2].
	self should: [endorsements includes: endorsement1].
	self should: [endorsements includes: endorsement2].
	edition retract: endorsement2.
	endorsements := edition endorsements.
	self should: [edition endorsements size = 1].
	self should: [endorsements includes: endorsement1].
	self should: [edition retract: endorsement2] raise: NotFoundError.
	edition retract: endorsement1.
	endorsements := edition endorsements.
	self should: [edition endorsements isEmpty]!

testSharedWith
	| edition1 edition2 edition3 edition4 mappings |
	edition1 := BeEdition contents: '1234567890' asAboraContent.
	edition2 := edition1 insert: 'abcd' asAboraContent at: 4. 
	edition3 := edition2 removeFrom: 6 extent: 4.
	edition4 := edition3 transcludeEdition: edition1 from: 8 extent: 2 to: 1.

	self should: [edition1 contents = '1234567890' asAboraContent].
	self should: [edition2 contents = '123abcd4567890' asAboraContent].
	self should: [edition3 contents = '123ab67890' asAboraContent].
	self should: [edition4 contents = '89123ab67890' asAboraContent].


	mappings := edition1 sharedWith: edition1.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 10)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 10)].

	mappings := edition1 sharedWith: edition2.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings second first = (IntegerRegion startPosition: 4 extent: 7)].
	self should: [mappings second last = (IntegerRegion startPosition: 8 extent: 7)].

	mappings := edition2 sharedWith: edition3.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings second first = (IntegerRegion startPosition: 10 extent: 5)].
	self should: [mappings second last = (IntegerRegion startPosition: 6 extent: 5)].

	mappings := edition1 sharedWith: edition3.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings second first = (IntegerRegion startPosition: 6 extent: 5)].
	self should: [mappings second last = (IntegerRegion startPosition: 6 extent: 5)].

	mappings := edition3 sharedWith: edition4.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 10)].
	self should: [mappings first last = (IntegerRegion startPosition: 3 extent: 10)].
	self should: [mappings second first = (IntegerRegion startPosition: 8 extent: 2)].
	self should: [mappings second last = (IntegerRegion startPosition: 1 extent: 2)].

	mappings := edition1 sharedWith: edition4.
	self should: [mappings size = 3].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 3 extent: 3)].
	self should: [mappings second first = (IntegerRegion startPosition: 6 extent: 5)].
	self should: [mappings second last = (IntegerRegion startPosition: 8 extent: 5)].
	self should: [mappings third first = (IntegerRegion startPosition: 8 extent: 2)].
	self should: [mappings third last = (IntegerRegion startPosition: 1 extent: 2)].

!

testSharedWith1
	| edition1 edition2 mappings work |
	edition1 := BeEdition contents: 'Hello' asAboraContent.
	work := BeWork edition: edition1.
	edition2 := edition1 transcludeEdition: edition1 from: 1 extent: 5 to: 6.
	work revise: edition2.

	self should: [edition1 contents = 'Hello' asAboraContent].
	self should: [edition2 contents = 'HelloHello' asAboraContent].

	mappings := edition1 sharedWith: edition1.
	self should: [mappings size = 1].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 5)].

	mappings := edition1 sharedWith: edition2.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings second first = (IntegerRegion startPosition: 1 extent: 5)].
	self should: [mappings second last = (IntegerRegion startPosition: 6 extent: 5)].
!

testSharedWithEmpty
	| edition1 edition2 |
	edition1 := BeEdition new.
	edition2 := BeEdition new.

	self should: [(edition1 sharedWith: edition2) isEmpty].!

testTransclusionsCollection
	| editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions |
	editionA1 := BeEdition contents: '12345' asAboraContent.
	editionA2 := editionA1 append: 'abc' asAboraContent.
	editionA3 := editionA2 removeFrom: 2 extent: 4.
	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition contents: 'hello' asAboraContent.
	editionB2 := editionB1 transcludeEdition: editionA2 from: 5 extent: 2 to: 6.

	transclusions := editionA1 transclusions.
	self should: [transclusions size = 3].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionA3].	
	self should: [transclusions includes: editionB2].
!

testTransclusionsData
	| editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions Work1 Work2 Work3 |
	Work1 := BeWork new.
	Work2 := BeWork new.
	Work3 := BeWork new.

	editionA1 := BeEdition contents: Work1.
	editionA2 := editionA1 append: Work2.
	editionA3 := editionA2 removeFrom: 2 extent: 1.
	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition contents: Work3.
	editionB2 := editionB1 
				transcludeEdition: editionA2
				from: 1
				extent: 2
				to: 2.
	transclusions := editionA1 transclusions.
	self should: [transclusions size = 3].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionA3].
	self should: [transclusions includes: editionB2]!

testTransclusionsDirect
	| editionX editionY editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions |
	editionX := BeEdition new.
	editionY := BeEdition contents: 'hello' asAboraContent.

	editionA1 := BeEdition contents: editionX.
	editionA2 := editionA1 append: editionY.
	editionA3 := editionA2 removeFrom: 1 extent: 1.
	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition new.
	editionB2 := editionB1 transcludeEdition: editionA2 from: 1 extent: 2 to: 1.

	transclusions := editionY transclusions.
	self should: [transclusions isEmpty].

	transclusions := editionY transclusionsDirect.
	self should: [transclusions size = 3].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionA3].	
	self should: [transclusions includes: editionB2].
!

testTransclusionsDirectFilteredBy
	| editionX editionY editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions |
	editionX := BeEdition new.
	editionY := BeEdition contents: 'hello' asAboraContent.

	editionA1 := BeEdition contents: editionX.
	editionA1 endorse: SystemIds textEditionEndorsement.
	editionA2 := editionA1 append: editionY.
	editionA2 endorse: SystemIds textEditionEndorsement.
	editionA3 := editionA2 removeFrom: 1 extent: 1.

	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition new.
	editionB2 := editionB1 transcludeEdition: editionA2 from: 1 extent: 2 to: 1.
	editionB2 endorse: FeIds linkUrlEndorsement.

	transclusions := editionY transclusions.
	self should: [transclusions isEmpty].

	transclusions := editionY transclusionsDirectFilteredBy: (Array with: SystemIds textEditionEndorsement).
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionA2].

	transclusions := editionY transclusionsDirectFilteredBy: (Array with: FeIds linkUrlEndorsement).
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionB2].
!

testTransclusionsEmpty
	| work edition endorsement1 endorsement2 edition2 endorsements |
	edition := BeEdition new.

	self should: [edition transclusions isEmpty].!

testTransclusionsFilteredBy
	| editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions work |
	editionA1 := BeEdition contents: '12345' asAboraContent.
	editionA2 := editionA1 append: 'abc' asAboraContent.
	editionA3 := editionA2 removeFrom: 2 extent: 4.
	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition contents: 'hello' asAboraContent.
	editionB2 := editionB1 transcludeEdition: editionA2 from: 5 extent: 2 to: 6.

	transclusions := editionA1 transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement).
	self should: [transclusions isEmpty].

	editionA2 endorse: SystemIds textEditionEndorsement.
	transclusions := editionA1 transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement).
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionA2].
	
	work := BeWork new.
	editionB2 endorse: SystemIds textEditionEndorsement.
	editionA3 endorse: (Array with: SystemIds universalPublicClub with: work id).
	transclusions := editionA1 transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement).
	self should: [transclusions size = 2].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionB2].

	transclusions := editionA1 transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement with: (Array with: SystemIds universalPublicClub with: work id)).
	self should: [transclusions isEmpty].

	editionA3 endorse: SystemIds textEditionEndorsement.
	transclusions := editionA1 transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement with: (Array with: SystemIds universalPublicClub with: work id)).
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionA3].
!

testTransclusionsFromExtentCollection
	| editionA1 editionA2 editionA3 editionA4 editionB1 editionB2 transclusions |
	editionA1 := BeEdition contents: '12345' asAboraContent.
	editionA2 := editionA1 append: 'abc' asAboraContent.
	editionA3 := editionA2 removeFrom: 2 extent: 4.
	editionA4 := editionA3 removeFrom: 1 extent: 1.
	editionB1 := BeEdition contents: 'hello' asAboraContent.
	editionB2 := editionB1 transcludeEdition: editionA2 from: 5 extent: 2 to: 6.

	transclusions := editionA1 transclusionsFrom: 1 extent: editionA1 count.
	self should: [transclusions size = 3].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionA3].	
	self should: [transclusions includes: editionB2].

	transclusions := editionA1 transclusionsFrom: 2 extent: 2.
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionA2].

	transclusions := editionA1 transclusionsFrom: 1 extent: 1.
	self should: [transclusions size = 2].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionA3].

	transclusions := editionA1 transclusionsFrom: 5 extent: 1.
	self should: [transclusions size = 2].
	self should: [transclusions includes: editionA2].
	self should: [transclusions includes: editionB2].

!

testTransclusionsNewEdition
	| editionA1 editionB1 transclusions |
	editionA1 := BeEdition contents: '12345' asAboraContent.
	editionB1 := BeEdition edition: editionA1.

	transclusions := editionA1 transclusions.
	self should: [transclusions size = 1].
	self should: [transclusions includes: editionB1].
! !
!BeEditionTest categoriesFor: #testAddWork!public! !
!BeEditionTest categoriesFor: #testAppendOldEdition!public! !
!BeEditionTest categoriesFor: #testCombineMappings!public! !
!BeEditionTest categoriesFor: #testCount!public! !
!BeEditionTest categoriesFor: #testCreate!public! !
!BeEditionTest categoriesFor: #testEndorse!public! !
!BeEditionTest categoriesFor: #testEndorsements!public! !
!BeEditionTest categoriesFor: #testInsertEditions!public! !
!BeEditionTest categoriesFor: #testInsertOldEdition!public! !
!BeEditionTest categoriesFor: #testIsEmpty!public! !
!BeEditionTest categoriesFor: #testNewEdition!public! !
!BeEditionTest categoriesFor: #testNewEditionEmpty!public! !
!BeEditionTest categoriesFor: #testNextRevision!public! !
!BeEditionTest categoriesFor: #testRemoveOldEdition!public! !
!BeEditionTest categoriesFor: #testRemoveWork!public! !
!BeEditionTest categoriesFor: #testRetract!public! !
!BeEditionTest categoriesFor: #testSharedWith!public! !
!BeEditionTest categoriesFor: #testSharedWith1!public! !
!BeEditionTest categoriesFor: #testSharedWithEmpty!public! !
!BeEditionTest categoriesFor: #testTransclusionsCollection!public! !
!BeEditionTest categoriesFor: #testTransclusionsData!public! !
!BeEditionTest categoriesFor: #testTransclusionsDirect!public! !
!BeEditionTest categoriesFor: #testTransclusionsDirectFilteredBy!public! !
!BeEditionTest categoriesFor: #testTransclusionsEmpty!public! !
!BeEditionTest categoriesFor: #testTransclusionsFilteredBy!public! !
!BeEditionTest categoriesFor: #testTransclusionsFromExtentCollection!public! !
!BeEditionTest categoriesFor: #testTransclusionsNewEdition!public! !

