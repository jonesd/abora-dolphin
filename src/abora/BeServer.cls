"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #BeServer
	instanceVariableNames: 'sessions serverLoop'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeServer guid: (GUID fromString: '{3D2A2C07-E84A-432A-A05B-5734DED46C14}')!
BeServer comment: ''!
!BeServer categoriesForClass!Kernel-Objects! !
!BeServer methodsFor!

initialize
	super initialize.

	sessions := LookupTable new.
	serverLoop := ServerLoop new.!

listener
	^BeNetworkListener current!

removeSession: beSession
	sessions removeKey:  beSession feHash!

removeSession: beSession ifAbsent: niladicValuable
	sessions removeKey:  beSession feHash ifAbsent: niladicValuable
!

serverLoop
	^serverLoop!

sessionFor: feHash
	^sessions at: feHash!

sessionFor: feHash ifAbsentPut: valuable
	^sessions at: feHash ifAbsentPut: valuable!

sessions
	^sessions values! !
!BeServer categoriesFor: #initialize!private! !
!BeServer categoriesFor: #listener!public! !
!BeServer categoriesFor: #removeSession:!public! !
!BeServer categoriesFor: #removeSession:ifAbsent:!public! !
!BeServer categoriesFor: #serverLoop!accessing!public! !
!BeServer categoriesFor: #sessionFor:!public! !
!BeServer categoriesFor: #sessionFor:ifAbsentPut:!public! !
!BeServer categoriesFor: #sessions!public! !

!BeServer class methodsFor!

current
	^Current!

initialize
"Private - 
self initialize
"
	Current := self new.! !
!BeServer class categoriesFor: #current!public! !
!BeServer class categoriesFor: #initialize!private! !

