"Filed out from Dolphin Smalltalk 2002 release 5.00"!

BeConnection subclass: #BeNetworkConnection
	instanceVariableNames: 'socket serverMonitor'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeNetworkConnection guid: (GUID fromString: '{6CE597CB-AB81-4A51-ACAB-E39541E8E68F}')!
BeNetworkConnection comment: ''!
!BeNetworkConnection categoriesForClass!Kernel-Objects! !
!BeNetworkConnection methodsFor!

close
	| listener |
	socket notNil 
		ifTrue: 
			[socket close.
			socket := nil].
	#todo "linking back to BeNetworkListener".
	listener := BeServer current listener.
	listener notNil  ifTrue: [listener removeConnection: self].
	super close.
	"terminating the serverMonitor should be the last item as we are probably running within this process"
	serverMonitor notNil 
		ifTrue: 
			[serverMonitor terminate.
			serverMonitor := nil].
!

handleError: error
	Sound bell.
"	self halt."
	^(error isKindOf: SocketError) 
		ifTrue: 
			[self defaultLogger debug: ['server socket error: ' , error printString].
			[self close] on: SocketError
				do: 
					[:terminateError | 
					self defaultLogger 
						warn: ['server socket error: [Failed to terminate] ' , terminateError printString]]]
		ifFalse: [self respondWithException: error]!

listenOn: listenSocket
	socket := listenSocket.
	transport := StbTransport readStream: socket readStream writeStream: socket writeStream.
	serverMonitor := BlockingCallMonitor new.
	serverMonitor callBlock: [self receiveAndProcess].
	serverMonitor completionBlock: [:answer | self respond: answer].
	serverMonitor errorBlock: [:error | self handleError: error].
	serverMonitor monitor! !
!BeNetworkConnection categoriesFor: #close!public! !
!BeNetworkConnection categoriesFor: #handleError:!private! !
!BeNetworkConnection categoriesFor: #listenOn:!public! !

!BeNetworkConnection class methodsFor!

listenOn: socket
	^self new listenOn: socket; yourself! !
!BeNetworkConnection class categoriesFor: #listenOn:!public! !

