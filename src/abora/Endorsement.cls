"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #Endorsement
	instanceVariableNames: 'endorseeId itemId'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Endorsement guid: (GUID fromString: '{D3BD3200-521C-4B4F-AB54-1A6275EDF022}')!
Endorsement comment: ''!
!Endorsement categoriesForClass!Kernel-Objects! !
!Endorsement methodsFor!

= anEndorsement
	^self species == anEndorsement species 
		and: [endorseeId = anEndorsement endorseeId and: [itemId = anEndorsement itemId]]!

checkIntegrity
	^true!

endorsee
	#todo "WorksStorage references only make sense on server. Review!!!!!!".
	^WorksStorage current lookupId: endorseeId!

endorseeId
	^endorseeId!

hash
	^(endorseeId hash bitShift: 1) bitXor: itemId hash!

initializeWithEndorseeID: setEndorseeId itemId: setItemId
	endorseeId := setEndorseeId.
	itemId := setItemId.!

itemId
	^itemId!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(endorseeId='.
	self endorseeId displayOn: aStream.
	aStream nextPutAll: ', itemId='.
	self itemId displayOn: aStream.
	aStream nextPutAll: ')'
! !
!Endorsement categoriesFor: #=!accessing!public! !
!Endorsement categoriesFor: #checkIntegrity!accessing!public! !
!Endorsement categoriesFor: #endorsee!accessing!public! !
!Endorsement categoriesFor: #endorseeId!accessing!public! !
!Endorsement categoriesFor: #hash!accessing!public! !
!Endorsement categoriesFor: #initializeWithEndorseeID:itemId:!private! !
!Endorsement categoriesFor: #itemId!accessing!public! !
!Endorsement categoriesFor: #printOn:!accessing!public! !

!Endorsement class methodsFor!

endorseeId: endorseeId itemId: itemId
	^(self new)
		initializeWithEndorseeID: endorseeId itemId: itemId;
		yourself! !
!Endorsement class categoriesFor: #endorseeId:itemId:!public! !

