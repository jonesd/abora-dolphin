"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ProtoObject subclass: #FeContentElementProxy
	instanceVariableNames: 'id class'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeContentElementProxy guid: (GUID fromString: '{2EA984F0-92E2-4D1D-AAB4-A019C7A200CD}')!
FeContentElementProxy comment: 'A proxy present on the server side for communicating with the actual FeContentElement present on the client side.'!
!FeContentElementProxy categoriesForClass!System-Support! !
!FeContentElementProxy methodsFor!

class
	^class!

hash
	"Required to stop Sets with FeProxy elements trying to send hash, which forces a call to the server, but we
	cant process the resulting hash value until we can read the previous Set, but that cant be finished until
	the hash is had.... Review the requirement for this method."
	
	<primitive: 75>
	^self primitiveFailed!

id
	^id!

initializeWithId: beId class: beClass
	id := beId.
	class := beClass.!

stbSaveOn: anSTBOutFiler
	anSTBOutFiler context == #forFe 
		ifTrue: [anSTBOutFiler saveObject: self as: (STBBeContentElementForBE forId: id)]
		ifFalse: [self error: 'should only be forFe']! !
!FeContentElementProxy categoriesFor: #class!public! !
!FeContentElementProxy categoriesFor: #hash!private! !
!FeContentElementProxy categoriesFor: #id!public! !
!FeContentElementProxy categoriesFor: #initializeWithId:class:!private! !
!FeContentElementProxy categoriesFor: #stbSaveOn:!private! !

!FeContentElementProxy class methodsFor!

for: be
	^self forId: be id class: be class!

forId: id class: aClass
	^(self new)
		initializeWithId: id class: aClass! !
!FeContentElementProxy class categoriesFor: #for:!public! !
!FeContentElementProxy class categoriesFor: #forId:class:!public! !

