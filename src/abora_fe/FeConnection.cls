"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeConnection
	instanceVariableNames: ''
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeConnection guid: (GUID fromString: '{0F3034E8-CCCD-44CD-AD1A-68B4F9E085B2}')!
FeConnection comment: ''!
!FeConnection categoriesForClass!Kernel-Objects! !
!FeConnection methodsFor!

basicReceive
	self subclassResponsibility!

basicSend: object
	self subclassResponsibility!

close
	^self!

receive
	| answer |
	answer := self basicReceive.
	(answer isKindOf: Exception) ifTrue: [answer signal].
	^answer
!

send: object
	self basicSend: object!

sendAndReceive: object
	| answer |
	self send: object.
	answer := self receive.
	^answer
! !
!FeConnection categoriesFor: #basicReceive!private! !
!FeConnection categoriesFor: #basicSend:!private! !
!FeConnection categoriesFor: #close!public! !
!FeConnection categoriesFor: #receive!public! !
!FeConnection categoriesFor: #send:!public! !
!FeConnection categoriesFor: #sendAndReceive:!public! !

!FeConnection class methodsFor!

current
	^Current!

current: feConnection
	Current notNil ifTrue: [Current close].
	Current := feConnection! !
!FeConnection class categoriesFor: #current!public! !
!FeConnection class categoriesFor: #current:!public! !

