"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeServer
	instanceVariableNames: ''
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeServer guid: (GUID fromString: '{F8C9B4A1-49E6-4D41-9B76-ACFC092724D6}')!
FeServer comment: ''!
!FeServer categoriesForClass!Kernel-Objects! !
!FeServer methodsFor!

connection
	^FeConnection current!

createEditionEmpty
	^self sendAndReceive: (MessageSend receiver: BeEdition selector: #new)!

createEditionFromEdition: beEdition
	^self sendAndReceive: (MessageSend 
				receiver: BeEdition
				selector: #edition:
				argument: beEdition)!

createEditionWithContents: beContents
	^self sendAndReceive: (MessageSend 
				receiver: BeEdition
				selector: #contents:
				argument: beContents)!

createWorkWithEdition: beEdition
	^self sendAndReceive: (MessageSend 
				receiver: BeWork
				selector: #edition:
				argument: beEdition)!

lookupId: id
	#todo.
	^self sendAndReceive: id!

sendAndReceive: message
	^self connection sendAndReceive: message!

userHome
	^FeWork on: (self sendAndReceive: #userHome)! !
!FeServer categoriesFor: #connection!private! !
!FeServer categoriesFor: #createEditionEmpty!public! !
!FeServer categoriesFor: #createEditionFromEdition:!public! !
!FeServer categoriesFor: #createEditionWithContents:!public! !
!FeServer categoriesFor: #createWorkWithEdition:!public! !
!FeServer categoriesFor: #lookupId:!public! !
!FeServer categoriesFor: #sendAndReceive:!public! !
!FeServer categoriesFor: #userHome!public! !

!FeServer class methodsFor!

current
	^Current!

initialize
"Private - 
self initialize.
"

	Current := self new! !
!FeServer class categoriesFor: #current!public! !
!FeServer class categoriesFor: #initialize!private! !

