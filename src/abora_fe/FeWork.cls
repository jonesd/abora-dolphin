"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeContentElement subclass: #FeWork
	instanceVariableNames: 'beWork cachedRevision cachedRevisionTime'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeWork guid: (GUID fromString: '{11AD5E92-268F-4AEF-B41E-88185130D4C1}')!
FeWork comment: ''!
!FeWork categoriesForClass!MVP-Models! !
!FeWork methodsFor!

beWork
	^beWork!

beWork: anObject
	beWork := anObject!

clearCached
	cachedRevisionTime := nil.
	cachedRevision := nil.!

edition
	^FeEdition on: beWork edition!

id
	^beWork id!

isFrozen
	^beWork isFrozen!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(id='.
	self id displayOn: aStream.
	aStream nextPutAll: ')'
!

revise: feEdition
	self clearCached.
	^beWork revise: feEdition beEdition!

revision
	cachedRevision isNil ifTrue: [cachedRevision := beWork revision].
	^cachedRevision!

revisions
	^FeEdition on: beWork revisions!

revisionTime
	cachedRevisionTime isNil ifTrue: [cachedRevisionTime := beWork revisionTime].
	^cachedRevisionTime! !
!FeWork categoriesFor: #beWork!accessing!public! !
!FeWork categoriesFor: #beWork:!accessing!private! !
!FeWork categoriesFor: #clearCached!private! !
!FeWork categoriesFor: #edition!public! !
!FeWork categoriesFor: #id!public! !
!FeWork categoriesFor: #isFrozen!public! !
!FeWork categoriesFor: #printOn:!public! !
!FeWork categoriesFor: #revise:!public! !
!FeWork categoriesFor: #revision!public! !
!FeWork categoriesFor: #revisions!public! !
!FeWork categoriesFor: #revisionTime!public! !

!FeWork class methodsFor!

edition: feEdition
	| beWork |
	beWork := FeServer current createWorkWithEdition: feEdition beEdition.
	^self on: beWork!

on: beWork
	| feWork |
	feWork := FeIdLookup current lookupId: beWork id
				ifAbsentPut: 
					[(self new)
						beWork: beWork;
						yourself].
	self assert: [feWork isKindOf: self].
	^feWork! !
!FeWork class categoriesFor: #edition:!public! !
!FeWork class categoriesFor: #on:!public! !

