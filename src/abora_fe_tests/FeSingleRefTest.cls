"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeSingleRefTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeSingleRefTest guid: (GUID fromString: '{E70363DA-13FC-4CE2-B41B-F40870CA6173}')!
FeSingleRefTest comment: ''!
!FeSingleRefTest categoriesForClass!SUnit! !
!FeSingleRefTest methodsFor!

testCreateOnFromExtentTo
	| edition hyperRef |
	edition := FeEdition contents: '1234567890' asAboraContent.
	hyperRef := FeSingleRef 
				createOn: edition
				from: 2
				extent: 5.
	self should: [hyperRef edition endorsements size = 1].
	self should: [hyperRef edition endorsements includes: SystemIds singleRefEndorsement].
	self should: [edition transclusions includes: hyperRef edition].
	self should: 
			[(edition transclusionsFilteredBy: (Array with: SystemIds singleRefEndorsement)) 
				includes: hyperRef edition]!

testHyperLink
	| edition hyperRef hyperLink |
	edition := FeEdition contents: '1234567890' asAboraContent.
	hyperRef := FeSingleRef 
				createOn: edition
				from: 2
				extent: 5.
	hyperLink := FeHyperLink createWithAll: (Array with: hyperRef).
	self should: [hyperRef hyperLink edition = hyperLink edition]!

testHyperLinkEdition
	| edition hyperRef hyperLink |
	edition := FeEdition contents: '1234567890' asAboraContent.
	hyperRef := FeSingleRef 
				createOn: edition
				from: 2
				extent: 5.
	hyperLink := FeHyperLink createWithAll: (Array with: hyperRef).
	self should: [hyperRef hyperLinkEdition = hyperLink edition]! !
!FeSingleRefTest categoriesFor: #testCreateOnFromExtentTo!public! !
!FeSingleRefTest categoriesFor: #testHyperLink!public! !
!FeSingleRefTest categoriesFor: #testHyperLinkEdition!public! !

