"Filed out from Dolphin Smalltalk 2002 release 5.00"!

BeContentElement subclass: #BeWork
	instanceVariableNames: 'edition id history revision revisionTime isFrozen endorsements'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeWork guid: (GUID fromString: '{1F30AA29-A2F3-467A-8D8F-E69512A3F592}')!
BeWork comment: ''!
!BeWork categoriesForClass!Kernel-Objects! !
!BeWork methodsFor!

edition
	^edition!

endorse: endorsementPair
	endorsements add: endorsementPair!

endorsements
	^endorsements!

freezeSelfToHistory
	| frozenWork |
	frozenWork := self class 
				frozenEdition: self edition
				revision: self revision
				revisionTime: self revisionTime.
	history := history append: frozenWork.!

id
	^id!

initialize
	super initialize.
	id := Id nextIdFor: self.
	revision := 0.
	revisionTime := TimeStamp current.
	history := BeEdition new.
	isFrozen := false.
	endorsements := Set new.
!

initializeWithEdition: setEdition
	edition := setEdition.
	setEdition addWork: self.
!

initializeWithFrozenEdition: setEdition revision: setRevision revisionTime: setRevisionTime
	isFrozen := true.
	edition := setEdition.
	revision := setRevision.
	revisionTime := setRevisionTime.!

isFrozen
	^isFrozen!

makeFeProxy
	^FeContentElementProxy forId: self id class: #FeWork!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(id='.
	self id printOn: aStream.
	self isFrozen ifTrue: [
		aStream nextPutAll: ', frozen, '].
	aStream nextPutAll: 'rev='.
	self revision printOn: aStream.
	aStream nextPutAll: ', time='.
	self revisionTime printOn: aStream.
	aStream nextPutAll: ')'!

retract: endorsementPair
	endorsements remove: endorsementPair!

revise: newEdition
	self isFrozen ifTrue: [Error signal: 'Frozen work'].
	self edition notNil ifTrue: [self edition removeWork: self].
	self freezeSelfToHistory.
	edition := newEdition.
	newEdition addWork: self.
	revision := revision + 1.
	revisionTime := TimeStamp current!

revision
	^revision!

revisions
	^history!

revisionTime
	^revisionTime! !
!BeWork categoriesFor: #edition!must not strip!public! !
!BeWork categoriesFor: #endorse:!must not strip!public! !
!BeWork categoriesFor: #endorsements!must not strip!public! !
!BeWork categoriesFor: #freezeSelfToHistory!private! !
!BeWork categoriesFor: #id!accessing!must not strip!public! !
!BeWork categoriesFor: #initialize!private! !
!BeWork categoriesFor: #initializeWithEdition:!private! !
!BeWork categoriesFor: #initializeWithFrozenEdition:revision:revisionTime:!private! !
!BeWork categoriesFor: #isFrozen!accessing!must not strip!public! !
!BeWork categoriesFor: #makeFeProxy!must not strip!private! !
!BeWork categoriesFor: #printOn:!must not strip!public! !
!BeWork categoriesFor: #retract:!must not strip!public! !
!BeWork categoriesFor: #revise:!must not strip!public! !
!BeWork categoriesFor: #revision!must not strip!public! !
!BeWork categoriesFor: #revisions!must not strip!public! !
!BeWork categoriesFor: #revisionTime!must not strip!public! !

!BeWork class methodsFor!

edition: currentEdition
	^(self new)
		initializeWithEdition: currentEdition;
		yourself!

frozenEdition: currentEdition revision: setRevision revisionTime: setRevisionTime
	^(self new)
		initializeWithFrozenEdition: currentEdition revision: setRevision revisionTime: setRevisionTime;
		yourself!

icon
	^Icon fromId: 4 in: ShellLibrary default!

in: worksStorage edition: currentEdition
	| work |
	work := self edition: currentEdition.
	worksStorage addWork: work.
	^work! !
!BeWork class categoriesFor: #edition:!public! !
!BeWork class categoriesFor: #frozenEdition:revision:revisionTime:!public! !
!BeWork class categoriesFor: #icon!public! !
!BeWork class categoriesFor: #in:edition:!public! !

