"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeEditionWrapper
	instanceVariableNames: 'edition'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeEditionWrapper guid: (GUID fromString: '{3AFF53AF-504E-4F6C-9BA2-F2767C9B629D}')!
FeEditionWrapper comment: ''!
!FeEditionWrapper categoriesForClass!MVP-Models! !
!FeEditionWrapper methodsFor!

edition
	^edition!

edition: anObject
	edition := anObject!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '('.
	self edition displayOn: aStream.
	aStream nextPutAll: ')'! !
!FeEditionWrapper categoriesFor: #edition!accessing!private! !
!FeEditionWrapper categoriesFor: #edition:!accessing!private! !
!FeEditionWrapper categoriesFor: #printOn:!public! !

!FeEditionWrapper class methodsFor!

ensureMatchesEndorsements: feEdition
	| requiredEndorsements satisfaction |
	requiredEndorsements := self requiredEndorsements.
	satisfaction := requiredEndorsements 
				allSatisfy: [:endorsement | feEdition endorsements includes: endorsement].
	satisfaction ifFalse: [FeError signal: 'Missing required endorsement']!

on: feEdition
	self ensureMatchesEndorsements: feEdition.
	^(self new)
		edition: feEdition;
		yourself!

requiredEndorsements
	^#()! !
!FeEditionWrapper class categoriesFor: #ensureMatchesEndorsements:!private! !
!FeEditionWrapper class categoriesFor: #on:!public! !
!FeEditionWrapper class categoriesFor: #requiredEndorsements!private! !

