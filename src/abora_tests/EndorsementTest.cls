"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #EndorsementTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EndorsementTest guid: (GUID fromString: '{CA60A143-42A4-4FEB-AE35-4150956AA436}')!
EndorsementTest comment: ''!
!EndorsementTest categoriesForClass!Kernel-Objects! !
!EndorsementTest methodsFor!

testCreate
	| endorsement |
	endorsement := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink.
	self should: [endorsement notNil].
	self should: [endorsement endorseeId = SystemIds systemAdminClub].
	self should: [endorsement itemId = SystemIds hyperLink].!

testEndorsee
	| endorsement |
	endorsement := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink.
	#todo "lame test".
	self should: [endorsement endorsee == (WorksStorage current lookupId: SystemIds systemAdminClub)].!

testEquals
	| endorsement |
	endorsement := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink.
	self should: [endorsement = endorsement].
	self should: [endorsement = (Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink)].
	self shouldnt: [endorsement = (Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds singleRef)].
	self shouldnt: [endorsement = (Endorsement endorseeId: SystemIds systemAccessClub itemId: SystemIds hyperLink)].
	self shouldnt: [endorsement = (Endorsement endorseeId: SystemIds systemAccessClub itemId: SystemIds singleRef)].
	self shouldnt: [endorsement = 'anything else'].
!

testHash
	| endorsement |
	endorsement := Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink.
	self should: [endorsement hash = endorsement hash].
	self should: [endorsement hash = (Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds hyperLink) hash].
	self shouldnt: [endorsement hash = (Endorsement endorseeId: SystemIds systemAdminClub itemId: SystemIds singleRef) hash].
	self shouldnt: [endorsement hash = (Endorsement endorseeId: SystemIds systemAccessClub itemId: SystemIds hyperLink) hash].
	self shouldnt: [endorsement hash = (Endorsement endorseeId: SystemIds systemAccessClub itemId: SystemIds singleRef) hash].
! !
!EndorsementTest categoriesFor: #testCreate!public! !
!EndorsementTest categoriesFor: #testEndorsee!public! !
!EndorsementTest categoriesFor: #testEquals!public! !
!EndorsementTest categoriesFor: #testHash!public! !

