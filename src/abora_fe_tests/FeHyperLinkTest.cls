"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeHyperLinkTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeHyperLinkTest guid: (GUID fromString: '{F13E7223-E924-45AD-AA0F-52018255713E}')!
FeHyperLinkTest comment: ''!
!FeHyperLinkTest categoriesForClass!SUnit! !
!FeHyperLinkTest methodsFor!

testHomeEdition
	| edition singleRef1 singleRef2 hyperLink document |
	edition := FeEdition contents: '1234567890' asAboraContent.
	singleRef1 := FeSingleRef 
				createOn: edition
				from: 1
				extent: 3.
	singleRef2 := FeSingleRef 
				createOn: edition
				from: 5
				extent: 4.
	hyperLink := FeHyperLink createWithAll: (Array with: singleRef1 with: singleRef2).
	document := FeEdition contents: hyperLink edition.
	self should: [hyperLink homeEditions includes: document]!

testLowLevelDifferentEditions
	| edition1 edition2 hyperLink singleRef1 singleRef2 transclusions |
	edition1 := BeEdition contents: '1234567890' asAboraContent.
	edition2 := BeEdition contents: 'abcdefghij' asAboraContent.

	singleRef1 := BeEdition new transcludeEdition: edition1 from: 2 extent: 5 to: 1.
	singleRef1 endorse: SystemIds singleRefEndorsement.
	singleRef2 := BeEdition new transcludeEdition: edition2 from: 1 extent: 3 to: 1.
	singleRef2 endorse: SystemIds singleRefEndorsement.

	hyperLink := BeEdition contents: (Array with: singleRef1 with: singleRef2).
	hyperLink endorse: SystemIds hyperLinkEndorsement.

	transclusions := edition1 transclusionsFilteredBy: (Array with: SystemIds singleRefEndorsement).
	self should: [transclusions size = 1].
	self should: [transclusions includes: singleRef1].
	
	transclusions := singleRef1 transclusionsDirectFilteredBy: (Array with: SystemIds hyperLinkEndorsement).
	self should: [transclusions size = 1].
	self should: [transclusions includes: hyperLink].



	
	
	!

testWithAll
	| edition singleRef1 singleRef2 hyperLink |
	edition := FeEdition contents: '1234567890' asAboraContent.
	singleRef1 := FeSingleRef 
				createOn: edition
				from: 1
				extent: 3.
	singleRef2 := FeSingleRef 
				createOn: edition
				from: 5
				extent: 4.
	hyperLink := FeHyperLink createWithAll: (Array with: singleRef1 with: singleRef2).
	self should: [hyperLink edition endorsements includes: SystemIds hyperLinkEndorsement]! !
!FeHyperLinkTest categoriesFor: #testHomeEdition!public! !
!FeHyperLinkTest categoriesFor: #testLowLevelDifferentEditions!public! !
!FeHyperLinkTest categoriesFor: #testWithAll!public! !

