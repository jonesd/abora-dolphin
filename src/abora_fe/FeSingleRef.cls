"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeEditionWrapper subclass: #FeSingleRef
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeSingleRef guid: (GUID fromString: '{BCD40A38-3B1A-479B-9565-DCC1963B6F43}')!
FeSingleRef comment: ''!
!FeSingleRef categoriesForClass!MVP-Models! !
!FeSingleRef methodsFor!

hyperLink
	| hyperLinkEdition |
	hyperLinkEdition := self hyperLinkEdition.
	^FeHyperLink on: hyperLinkEdition!

hyperLinkEdition
	| transclusions |
	transclusions := self edition 
				transclusionsDirectFilteredBy: (Array with: SystemIds hyperLinkEndorsement).
	#todo.	"shouldnt have this limitation of a single transclusion"
	transclusions size = 1 
		ifTrue: [^transclusions asArray first]
		ifFalse: 
			[transclusions isEmpty 
				ifTrue: [Error signal: 'cant find hyperLink for singleRef']
				ifFalse: [Error signal: 'more than one hyperLink for singleRef']]! !
!FeSingleRef categoriesFor: #hyperLink!accessing!public! !
!FeSingleRef categoriesFor: #hyperLinkEdition!accessing!public! !

!FeSingleRef class methodsFor!

createOn: transcludeEdition from: from extent: extent
	| edition |
	edition := FeEdition empty.
	edition := edition transcludeEdition: transcludeEdition from: from extent: extent to: 1.
	edition endorse: SystemIds singleRefEndorsement.
	^self on: edition!

requiredEndorsements
	^Array with: (SystemIds singleRefEndorsement).! !
!FeSingleRef class categoriesFor: #createOn:from:extent:!public! !
!FeSingleRef class categoriesFor: #requiredEndorsements!private! !

