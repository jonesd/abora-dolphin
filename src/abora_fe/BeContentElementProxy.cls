"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ProtoObject subclass: #BeContentElementProxy
	instanceVariableNames: 'id class'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeContentElementProxy guid: (GUID fromString: '{EBEDF59B-895E-4ADE-8BB7-93CAD2567EAC}')!
BeContentElementProxy comment: 'A proxy present on the client side for communicating with the actual BeContentElement present on the server side.'!
!BeContentElementProxy categoriesForClass!Kernel-Objects! !
!BeContentElementProxy methodsFor!

class
	^class!

doesNotUnderstand: failedMessage
	"Private - Sent to the receiver by the VM when a message sent to the receiver was not implemented
	by the receiver or its superclasses (i.e. it has no appropriate behaviour).
	Signal a <MessageNotUnderstood> exception corresponding to the <failedMessage> argument,
	message."

	| message |
	message := MessageSend 
				receiver: self
				selector: failedMessage selector
				arguments: failedMessage arguments.
	^[FeServer current sendAndReceive: message] on: Error
		do: 
			[:error | 
			"self halt."
			error signal]!

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
	anSTBOutFiler context == #forBe 
		ifTrue: [anSTBOutFiler saveObject: self as: (STBBeContentElementForBE forId: id)]
		ifFalse: [self error: 'should only be forBe']! !
!BeContentElementProxy categoriesFor: #class!public! !
!BeContentElementProxy categoriesFor: #doesNotUnderstand:!private! !
!BeContentElementProxy categoriesFor: #hash!private! !
!BeContentElementProxy categoriesFor: #id!public! !
!BeContentElementProxy categoriesFor: #initializeWithId:class:!private! !
!BeContentElementProxy categoriesFor: #stbSaveOn:!private! !

!BeContentElementProxy class methodsFor!

for: be
	"Note: Only called by test cases"
	^self forId: be id class: be class!

forId: id class: aClass
	^(self new)
		initializeWithId: id class: aClass! !
!BeContentElementProxy class categoriesFor: #for:!public! !
!BeContentElementProxy class categoriesFor: #forId:class:!public! !

