"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #SystemIds
	instanceVariableNames: ''
	classVariableNames: 'Cache'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SystemIds guid: (GUID fromString: '{A65608F2-AEEE-435E-9DC5-22078FB241FD}')!
SystemIds comment: ''!
!SystemIds categoriesForClass!Kernel-Objects! !
!SystemIds class methodsFor!

cached: symbol
	^Cache at: symbol!

createId: value
	^(Id new)
		value: value;
		yourself!

hyperLink
	^self cached: #hyperLink!

hyperLinkEndorsement
	^self cached: #hyperLinkEndorsement!

initialize
"Private - 
	SystemIds initialize.
"

	Cache := IdentityDictionary new.

	Cache at: #textEdition put: (self createId: 1).
	Cache at: #hyperLink put: (self createId: 2).
	Cache at: #singleRef put: (self createId: 3).

	Cache at: #universalEmptyClub put: (self createId: 6).
	Cache at: #universalPublicClub put: (self createId: 10).
	Cache at: #systemAccessClub put: (self createId: 14).
	Cache at: #systemAdminClub put: (self createId: 18).
	Cache at: #systemArchiveClub put: (self createId: 22).

	Cache at: #hyperLinkEndorsement put: (Endorsement endorseeId: self systemAdminClub itemId: self hyperLink).
	Cache at: #singleRefEndorsement put: (Endorsement endorseeId: self systemAdminClub itemId: self singleRef).
	Cache at: #textEditionEndorsement put: (Endorsement endorseeId: self systemAdminClub itemId: self textEdition).!

singleRef
	^self cached: #singleRef!

singleRefEndorsement
	^self cached: #singleRefEndorsement!

systemAccessClub
	^self cached: #systemAccessClub!

systemAdminClub
	^self cached: #systemAdminClub!

systemArchiveClub
	^self cached: #systemArchiveClub!

textEdition
	^self cached: #textEdition!

textEditionEndorsement
	^self cached: #textEditionEndorsement!

universalEmptyClub
	^self cached: #universalEmptyClub!

universalPublicClub
	^self cached: #universalPublicClub! !
!SystemIds class categoriesFor: #cached:!private! !
!SystemIds class categoriesFor: #createId:!private! !
!SystemIds class categoriesFor: #hyperLink!public! !
!SystemIds class categoriesFor: #hyperLinkEndorsement!public! !
!SystemIds class categoriesFor: #initialize!private! !
!SystemIds class categoriesFor: #singleRef!public! !
!SystemIds class categoriesFor: #singleRefEndorsement!public! !
!SystemIds class categoriesFor: #systemAccessClub!public! !
!SystemIds class categoriesFor: #systemAdminClub!public! !
!SystemIds class categoriesFor: #systemArchiveClub!public! !
!SystemIds class categoriesFor: #textEdition!public! !
!SystemIds class categoriesFor: #textEditionEndorsement!public! !
!SystemIds class categoriesFor: #universalEmptyClub!public! !
!SystemIds class categoriesFor: #universalPublicClub!public! !

