"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeEditionWrapper subclass: #FeHyperLink
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeHyperLink guid: (GUID fromString: '{4C25274F-DBBF-49E1-A787-1B2BC29D7074}')!
FeHyperLink comment: ''!
!FeHyperLink categoriesForClass!MVP-Models! !
!FeHyperLink methodsFor!

homeEditions
	^self edition transclusionsDirect!

hyperRefs
	| hyperRefs |
	hyperRefs := OrderedCollection new.
	self edition contents do: 
			[:childEdition | 
			(childEdition endorsements includes: SystemIds singleRefEndorsement) 
				ifFalse: [Error signal: 'non-single ref edition child of FeHyperLink'].
			hyperRefs add: (FeSingleRef on: childEdition)].
	^hyperRefs! !
!FeHyperLink categoriesFor: #homeEditions!public! !
!FeHyperLink categoriesFor: #hyperRefs!public! !

!FeHyperLink class methodsFor!

createWithAll: singleRefs
	| edition |
	edition := FeEdition contents: (singleRefs collect: [:singleRef | singleRef edition]).
	edition endorse: SystemIds hyperLinkEndorsement.
	^self on: edition!

createWithAll: singleRefs linkType: linkTypeEndorsement
	| edition |
	edition := FeEdition contents: (singleRefs collect: [:singleRef | singleRef edition]).
	edition endorse: SystemIds hyperLinkEndorsement.
	edition endorse: linkTypeEndorsement.
	singleRefs do: [:singleRef | singleRef edition endorse: linkTypeEndorsement].
	^self on: edition!

requiredEndorsements
	^Array with: (SystemIds hyperLinkEndorsement).! !
!FeHyperLink class categoriesFor: #createWithAll:!public! !
!FeHyperLink class categoriesFor: #createWithAll:linkType:!public! !
!FeHyperLink class categoriesFor: #requiredEndorsements!private! !

