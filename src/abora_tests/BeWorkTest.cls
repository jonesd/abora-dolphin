"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BeWorkTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeWorkTest guid: (GUID fromString: '{4DED7631-7038-4466-90D3-6E82385448A9}')!
BeWorkTest comment: ''!
!BeWorkTest categoriesForClass!SUnit! !
!BeWorkTest methodsFor!

testEndorse
	| work endorsement1 endorsement2 work2 endorsements |
	work := BeWork new.
	work2 := BeWork new.
	endorsement1 := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds textEdition.
	endorsement2 := Endorsement endorseeId: SystemIds universalPublicClub itemId: work2 id.
	endorsements := work endorsements.
	self should: [work endorsements isEmpty].
	work endorse: endorsement1.
	endorsements := work endorsements.
	self should: [endorsements size = 1].
	self should: [endorsements includes: endorsement1].
	work endorse: endorsement2.
	endorsements := work endorsements.
	self should: [work endorsements size = 2].
	self should: [endorsements includes: endorsement1].
	self should: [endorsements includes: endorsement2].
	work endorse: endorsement2.
	endorsements := work endorsements.
	self should: [work endorsements size = 2]!

testEndorsements
	| work |
	work := BeWork new.
	self should: [work endorsements isEmpty]!

testNew
	| work edition1 start |
	start := TimeStamp current.
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	self should: [work edition == edition1].
	self should: [work revision = 0].
	self should: [work revisions isEmpty].
	self should: [work revisionTime >= start and: [work revisionTime <= TimeStamp current]].
	self shouldnt: [work isFrozen]!

testNewFrozen
	| work edition start |
	start := TimeStamp current.
	edition := BeEdition new.
	work := BeWork 
				frozenEdition: edition
				revision: 2
				revisionTime: TimeStamp current.
	self should: [work edition == edition].
	self should: [work revision = 2].
	self should: [work revisions isEmpty].
	self should: [work revisionTime >= start and: [work revisionTime <= TimeStamp current]].
	self should: [work isFrozen]!

testRetract
	| work endorsement1 endorsement2 work2 endorsements |
	work := BeWork new.
	work2 := BeWork new.
	endorsement1 := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds textEdition.
	endorsement2 := Endorsement endorseeId: SystemIds universalPublicClub itemId: work2 id.
	work endorse: endorsement1.
	work endorse: endorsement2.
	endorsements := work endorsements.
	self should: [work endorsements size = 2].
	self should: [endorsements includes: endorsement1].
	self should: [endorsements includes: endorsement2].
	work retract: endorsement2.
	endorsements := work endorsements.
	self should: [work endorsements size = 1].
	self should: [endorsements includes: endorsement1].
	self should: [work retract: endorsement2] raise: NotFoundError.
	work retract: endorsement1.
	endorsements := work endorsements.
	self should: [work endorsements isEmpty]!

testRevise
	| work edition1 edition2 start frozenWork createTime |
	start := TimeStamp current.
	edition1 := BeEdition new.
	work := BeWork edition: edition1.
	self should: [work edition == edition1].
	self should: [work revision = 0].
	self should: [work revisions isEmpty].
	self should: [work revisionTime >= start and: [work revisionTime <= TimeStamp current]].
	createTime := work revisionTime.
	self shouldnt: [work isFrozen].
	edition2 := BeEdition new.
	work revise: edition2.
	self should: [work edition == edition2].
	self should: [work revision = 1].
	self should: [work revisionTime >= start and: [work revisionTime <= TimeStamp current]].
	self shouldnt: [work isFrozen].
	self should: [work revisions count = 1].
	frozenWork := work revisions contents first.
	self should: [frozenWork edition == edition1].
	self should: [frozenWork revision = 0].
	self should: [frozenWork revisionTime == createTime].
	self should: [frozenWork revisions isEmpty].
	self should: [frozenWork isFrozen]!

testReviseFrozen
	| work edition start |
	start := TimeStamp current.
	edition := BeEdition new.
	work := BeWork 
				frozenEdition: edition
				revision: 2
				revisionTime: TimeStamp current.
	self should: [work edition == edition].
	self should: [work revision = 2].
	self should: [work revisions isEmpty].
	self should: [work revisionTime >= start and: [work revisionTime <= TimeStamp current]].
	self should: [work isFrozen].
	self 
		should: [work revise: BeEdition new]
		raise: Error
		description: 'work is frozen'! !
!BeWorkTest categoriesFor: #testEndorse!public! !
!BeWorkTest categoriesFor: #testEndorsements!public! !
!BeWorkTest categoriesFor: #testNew!public! !
!BeWorkTest categoriesFor: #testNewFrozen!public! !
!BeWorkTest categoriesFor: #testRetract!public! !
!BeWorkTest categoriesFor: #testRevise!public! !
!BeWorkTest categoriesFor: #testReviseFrozen!public! !

