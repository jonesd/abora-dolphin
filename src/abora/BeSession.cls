"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #BeSession
	instanceVariableNames: 'feHash club feContentElements connections'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeSession guid: (GUID fromString: '{EA316B80-5510-4814-B373-18BE33EDC6CB}')!
BeSession comment: ''!
!BeSession categoriesForClass!Kernel-Objects! !
!BeSession methodsFor!

addConnection: beConnection
	connections add: beConnection!

addFeContentElementFor: beContentElement
	^feContentElements at: beContentElement ifAbsentPut: [beContentElement makeFeProxy]!

clearAll
	#todo "concurrent access?".
	BeServer current removeSession: self ifAbsent: [#todo "log this problem"].
	feContentElements copy keysDo: [:beContentElement | self removeFeContentElementFor: beContentElement].!

club
	^club!

club: anObject
	club := anObject!

feHash
	^feHash!

feHash: anObject
	feHash := anObject!

initialize
	super initialize.

	feContentElements := IdentityDictionary new.
	connections := IdentitySet new.!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(feHash='.
	self feHash displayOn: aStream.
	aStream nextPutAll: ', clubId='.
	self club id displayOn: aStream.
	aStream nextPutAll: ')'
!

removeConnection: beConnection
	connections remove: beConnection.
	#todo "there really should be some time delay or something before removingAllElements".
	self clearAll.!

removeFeContentElementFor: beContentElement
	feContentElements removeKey: beContentElement! !
!BeSession categoriesFor: #addConnection:!accessing!public! !
!BeSession categoriesFor: #addFeContentElementFor:!accessing!public! !
!BeSession categoriesFor: #clearAll!accessing!public! !
!BeSession categoriesFor: #club!accessing!public! !
!BeSession categoriesFor: #club:!accessing!private! !
!BeSession categoriesFor: #feHash!accessing!private! !
!BeSession categoriesFor: #feHash:!accessing!private! !
!BeSession categoriesFor: #initialize!accessing!private! !
!BeSession categoriesFor: #printOn:!accessing!public! !
!BeSession categoriesFor: #removeConnection:!accessing!public! !
!BeSession categoriesFor: #removeFeContentElementFor:!accessing!public! !

!BeSession class methodsFor!

club: club feHash: feHash
	^(self new)
		club: club;
		feHash: feHash;
		yourself! !
!BeSession class categoriesFor: #club:feHash:!public! !

