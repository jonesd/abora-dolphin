"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeConnection subclass: #FeBackgroundConnection
	instanceVariableNames: 'requests sendingProcess connection receivingProcess sentRequests'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeBackgroundConnection guid: (GUID fromString: '{26924188-BCCE-438F-97FB-9D4F7D5DC34C}')!
FeBackgroundConnection comment: ''!
!FeBackgroundConnection categoriesForClass!Kernel-Objects! !
!FeBackgroundConnection methodsFor!

close
	connection notNil 
		ifTrue: 
			[connection close.
			connection := nil].
	sendingProcess notNil 
		ifTrue: 
			[sendingProcess terminate.
			sendingProcess := nil].
	receivingProcess notNil 
		ifTrue: 
			[receivingProcess terminate.
			receivingProcess := nil].
!

connection
	^connection!

connectionPriority
	^Processor userBackgroundPriority!

forkReceivingProcess
	^
	[
	[| request answer |
	answer := connection basicReceive.
	request := sentRequests next.
	request at: 3 put: answer.
	request second signal] 
			repeat] 
			forkAt: self connectionPriority!

forkSendingProcess
	^
	[
	[| request |
	request := requests next.
	connection basicSend: request first.
	sentRequests nextPut: request] 
			repeat] 
			forkAt: self connectionPriority!

initialize
	super initialize.

	requests := SharedQueue new.
	sentRequests := SharedQueue new.!

initializeWithConnection: feConnection
	self close.
	connection := feConnection.
	sendingProcess := self forkSendingProcess.
	receivingProcess := self forkReceivingProcess.!

sendAndReceive: message
	| semaphore request answer |
	Processor forkMainIfMain.
	semaphore := Semaphore new.
	request := Array 
				with: message
				with: semaphore
				with: nil.
	requests nextPut: request.
	semaphore wait.
	answer := request third.
	(answer isKindOf: Exception) ifTrue: [answer signal].
	^answer! !
!FeBackgroundConnection categoriesFor: #close!public! !
!FeBackgroundConnection categoriesFor: #connection!accessing!private! !
!FeBackgroundConnection categoriesFor: #connectionPriority!private! !
!FeBackgroundConnection categoriesFor: #forkReceivingProcess!accessing!private! !
!FeBackgroundConnection categoriesFor: #forkSendingProcess!accessing!private! !
!FeBackgroundConnection categoriesFor: #initialize!private! !
!FeBackgroundConnection categoriesFor: #initializeWithConnection:!accessing!private! !
!FeBackgroundConnection categoriesFor: #sendAndReceive:!public! !

!FeBackgroundConnection class methodsFor!

onConnection: connection
	^(self new)
		initializeWithConnection: connection;
		yourself! !
!FeBackgroundConnection class categoriesFor: #onConnection:!public! !

