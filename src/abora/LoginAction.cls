"Filed out from Dolphin Smalltalk 2002 release 5.00"!

RemoteAction subclass: #LoginAction
	instanceVariableNames: 'feHash clubId'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LoginAction guid: (GUID fromString: '{1A8264EC-5BDA-4662-8C52-58F2D4854092}')!
LoginAction comment: ''!
!LoginAction categoriesForClass!Kernel-Objects! !
!LoginAction methodsFor!

clubId
	^clubId!

clubId: anObject
	clubId := anObject!

feHash
	^feHash!

feHash: anObject
	feHash := anObject! !
!LoginAction categoriesFor: #clubId!accessing!public! !
!LoginAction categoriesFor: #clubId:!accessing!private! !
!LoginAction categoriesFor: #feHash!accessing!public! !
!LoginAction categoriesFor: #feHash:!accessing!private! !

!LoginAction class methodsFor!

clubId: clubId feHash: feHash
	^(self new)
		clubId: clubId;
		feHash: feHash;
		yourself! !
!LoginAction class categoriesFor: #clubId:feHash:!public! !

