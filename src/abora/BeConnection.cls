"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #BeConnection
	instanceVariableNames: 'session totalCalls transport'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeConnection guid: (GUID fromString: '{3B99C962-E3B3-4A09-A593-DD24BA9A6ED3}')!
BeConnection comment: ''!
!BeConnection categoriesForClass!Kernel-Objects! !
!BeConnection methodsFor!

close
	transport notNil 
		ifTrue: 
			[transport close.
			transport := nil].
	session notNil 
		ifTrue: 
			[session removeConnection: self.
			session := nil]!

defaultLogger
	^AboraLogger connection!

hasLoggedIn
	^session notNil!

initialize
	super initialize.
	totalCalls := 0.!

next
	^transport next!

nextPut: object
	transport nextPut: object!

process: niladicValuable
	^BeServer current serverLoop addActionAndWait: niladicValuable!

processLogin
	"authenticate"

	^self process: 
			[| feHash clubId club |
			#todo.
			feHash := self next.
			clubId := self next.
			club := WorksStorage current lookupId: clubId.
			session := BeServer current sessionFor: feHash
						ifAbsentPut: [BeSession club: club feHash: feHash].
			session addConnection: self.
			transport outContext: session.
			self defaultLogger info: ['Successful login: ' , clubId displayString].
			'ok']!

processLookupId: received
	^self process: [WorksStorage current lookupId: received]!

processRequest: received
	received == #login ifTrue: [^self processLogin].
	^self hasLoggedIn 
		ifTrue: 
			[received == #userHome 
				ifTrue: [self processUserHome]
				ifFalse: 
					[(received isKindOf: Id) 
						ifTrue: [self processLookupId: received]
						ifFalse: [self processValue: received]]]
		ifFalse: [AboraNotAuthorizedError new]!

processUserHome
	^self process: [WorksStorage current userHome]!

processValue: received
	^self process: [received value]!

receiveAndProcess
	| request |
	request := self next.
	totalCalls := totalCalls + 1.
	self defaultLogger debug: ['received: ' , request printString].
	#todo.	"what to do about this special reciveds?"
	^self processRequest: request!

respond: answer
	self defaultLogger debug: ['replying: ' , answer printString].
	self nextPut: answer!

respondWithException: exception
	| exceptionProxy |
	self defaultLogger debug: ['error thrown: ' , exception printString].
	"Should not send an exception as it will contain this VM specific details and possible reference to BE only objects"
	exceptionProxy := AboraRemoteError fromError: exception.
	self nextPut: exceptionProxy! !
!BeConnection categoriesFor: #close!public! !
!BeConnection categoriesFor: #defaultLogger!accessing!private! !
!BeConnection categoriesFor: #hasLoggedIn!private! !
!BeConnection categoriesFor: #initialize!private! !
!BeConnection categoriesFor: #next!accessing!private! !
!BeConnection categoriesFor: #nextPut:!accessing!private! !
!BeConnection categoriesFor: #process:!private! !
!BeConnection categoriesFor: #processLogin!private! !
!BeConnection categoriesFor: #processLookupId:!private! !
!BeConnection categoriesFor: #processRequest:!private! !
!BeConnection categoriesFor: #processUserHome!private! !
!BeConnection categoriesFor: #processValue:!private! !
!BeConnection categoriesFor: #receiveAndProcess!public! !
!BeConnection categoriesFor: #respond:!public! !
!BeConnection categoriesFor: #respondWithException:!public! !

