"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #MockEventReceiver
	instanceVariableNames: 'actualEvents expectedEvents'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
MockEventReceiver guid: (GUID fromString: '{266CDF16-198A-4D2E-9314-79252A28424C}')!
MockEventReceiver comment: ''!
!MockEventReceiver categoriesForClass!Kernel-Objects! !
!MockEventReceiver methodsFor!

addExpectedEvent: symbol with: object
	expectedEvents add: (Message selector: symbol argument: object)!

doesNotUnderstand: failedMessage
	"Sent to the receiver by the VM when a message sent to the receiver was not implemented
	by the receiver or its superclasses (i.e. it has no appropriate behaviour).
	Signal a <MessageNotUnderstood> exception corresponding to the <failedMessage> argument,
	message."

	actualEvents add: failedMessage!

initialize
	super initialize.
	actualEvents := OrderedCollection new.
	expectedEvents := OrderedCollection new.!

verify: testCase
	testCase should: [actualEvents = expectedEvents].
! !
!MockEventReceiver categoriesFor: #addExpectedEvent:with:!public! !
!MockEventReceiver categoriesFor: #doesNotUnderstand:!public! !
!MockEventReceiver categoriesFor: #initialize!public! !
!MockEventReceiver categoriesFor: #verify:!public! !

!MockEventReceiver class methodsFor!

new
	^(super new)
		initialize;
		yourself! !
!MockEventReceiver class categoriesFor: #new!public! !

