"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #WorksStorage
	instanceVariableNames: 'works idLookup userHome'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WorksStorage guid: (GUID fromString: '{3780118B-512A-44D1-BB08-8BEA994E899B}')!
WorksStorage comment: ''!
!WorksStorage categoriesForClass!Kernel-Objects! !
!WorksStorage methodsFor!

addId: id with: value
	#todo "this should probably be somewhere else".
	idLookup at: id put: value!

addWork: work
	works add: work
!

idLookup
	^idLookup!

initialize
	super initialize.

	works := OrderedCollection new.
	idLookup := WeakLookupTable new.!

knownIds
	^idLookup size
!

lookupId: id
	#todo "this should probably be somewhere else".
	^idLookup at: id
!

removeWork: work
	works remove: work
!

userHome
	^userHome!

userHome: anObject
	userHome := anObject!

works
	^works
! !
!WorksStorage categoriesFor: #addId:with:!public! !
!WorksStorage categoriesFor: #addWork:!public! !
!WorksStorage categoriesFor: #idLookup!private! !
!WorksStorage categoriesFor: #initialize!private! !
!WorksStorage categoriesFor: #knownIds!public! !
!WorksStorage categoriesFor: #lookupId:!public! !
!WorksStorage categoriesFor: #removeWork:!public! !
!WorksStorage categoriesFor: #userHome!accessing!public! !
!WorksStorage categoriesFor: #userHome:!accessing!private! !
!WorksStorage categoriesFor: #works!public! !

!WorksStorage class methodsFor!

current
	^Current!

current: newWorksStorage
	Current := newWorksStorage!

initialize
"Private - 
WorksStorage initialize
"

	Current := self new.! !
!WorksStorage class categoriesFor: #current!public! !
!WorksStorage class categoriesFor: #current:!public! !
!WorksStorage class categoriesFor: #initialize!private! !

