"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeEditionWrapper subclass: #FeTextEdition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextEdition guid: (GUID fromString: '{EC318336-FF2A-4B66-BD0F-B787235E94DA}')!
FeTextEdition comment: ''!
!FeTextEdition categoriesForClass!MVP-Models! !
!FeTextEdition methodsFor!

contents
	^self toTextContent: edition contents!

contentsFrom: position extent: extent
	^self toTextContent: (edition contentsFrom: position extent: extent)!

count
	^edition count!

edition: anObject
	edition notNil ifTrue: [edition removeEventsTriggeredFor: self].
	super edition: anObject.
	edition 
		when: #editionUpdatedTo:
		send: #onEditionUpdatedTo:
		to: self!

insert: text at: position
	#todo "should the return FeEdition in fact be a wrapped FeTextEdition?".
	^edition insert: (self toServerContent: text) at: position!

onEditionUpdatedTo: newEdition
	newEdition endorse: SystemIds textEditionEndorsement.
!

printOn: target
	"Append, to the <puttableStream>, target, a string whose characters are a 
	the same as those which would result from sending a #printString
	message to the receiver.
	N.B. This is really intended for development use. #displayOn: and #displayString
	are complementary methods for generating strings for presentation to an
	end-user."

	| name |
	name := self class name.
	target 
		nextPutAll: (name first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: name!

removeFrom: position extent: extent
	^edition removeFrom: position extent: extent!

toServerContent: text
	^text asAboraContent!

toTextContent: array
	^array asAboraText!

transcludeEdition: transcludeEdition from: from extent: extent to: to
	#todo "trancludeEdition should just be a normal FeEdition rather than FeTextEdition. Confusing?".
	^edition 
		transcludeEdition: transcludeEdition
		from: from
		extent: extent
		to: to! !
!FeTextEdition categoriesFor: #contents!public! !
!FeTextEdition categoriesFor: #contentsFrom:extent:!public! !
!FeTextEdition categoriesFor: #count!public! !
!FeTextEdition categoriesFor: #edition:!public! !
!FeTextEdition categoriesFor: #insert:at:!public! !
!FeTextEdition categoriesFor: #onEditionUpdatedTo:!private! !
!FeTextEdition categoriesFor: #printOn:!printing!public! !
!FeTextEdition categoriesFor: #removeFrom:extent:!public! !
!FeTextEdition categoriesFor: #toServerContent:!private! !
!FeTextEdition categoriesFor: #toTextContent:!private! !
!FeTextEdition categoriesFor: #transcludeEdition:from:extent:to:!public! !

!FeTextEdition class methodsFor!

contents: text
	| feEdition |
	feEdition := FeEdition contents: text asAboraContent.
	feEdition endorse: SystemIds textEditionEndorsement.
	^self on: feEdition!

empty
	| feEdition |
	feEdition := FeEdition empty.
	feEdition endorse: SystemIds textEditionEndorsement.
	^self on: feEdition!

requiredEndorsements
	^Array with: (SystemIds textEditionEndorsement)! !
!FeTextEdition class categoriesFor: #contents:!public! !
!FeTextEdition class categoriesFor: #empty!public! !
!FeTextEdition class categoriesFor: #requiredEndorsements!public! !

