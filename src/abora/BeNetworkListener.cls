"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #BeNetworkListener
	instanceVariableNames: 'port serverSocket acceptanceMonitor connections'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeNetworkListener guid: (GUID fromString: '{50EE386D-79D8-4ECB-8D0D-A12EDE2829A9}')!
BeNetworkListener comment: ''!
!BeNetworkListener categoriesForClass!Kernel-Objects! !
!BeNetworkListener methodsFor!

accept
	self close.
	serverSocket := ServerSocket port: port.
	acceptanceMonitor := BlockingCallMonitor new.
	acceptanceMonitor callBlock: [serverSocket accept].
	acceptanceMonitor completionBlock: [:socket | self onConnection: socket].
	acceptanceMonitor monitor!

addConnection: connection
	connections add: connection!

close
	connections do: [:connection |
		connection close].
	connections := connections copyEmpty.
	acceptanceMonitor notNil ifTrue: [
		acceptanceMonitor terminate.
		acceptanceMonitor := nil].
	serverSocket notNil ifTrue: [
		serverSocket close.
		serverSocket := nil].!

connections
	^connections!

initialize
	super initialize.
	"Connections elements are held firmly by the server monitor background process they use."
	connections := WeakIdentitySet new.!

onConnection: socket
	| connection |
	Sound bell.
	connection := BeNetworkConnection listenOn: socket.
	self addConnection: connection.
	connection := nil!

port
	^port!

port: anObject
	port := anObject!

removeConnection: connection
	connections remove: connection!

totalCalls
	^connections inject: 0 into: [:total :connection | total + connection totalCalls]! !
!BeNetworkListener categoriesFor: #accept!public! !
!BeNetworkListener categoriesFor: #addConnection:!accessing!private! !
!BeNetworkListener categoriesFor: #close!public! !
!BeNetworkListener categoriesFor: #connections!accessing!private! !
!BeNetworkListener categoriesFor: #initialize!accessing!private! !
!BeNetworkListener categoriesFor: #onConnection:!private! !
!BeNetworkListener categoriesFor: #port!accessing!private! !
!BeNetworkListener categoriesFor: #port:!accessing!private! !
!BeNetworkListener categoriesFor: #removeConnection:!accessing!private! !
!BeNetworkListener categoriesFor: #totalCalls!public! !

!BeNetworkListener class methodsFor!

current
	^Current!

current: serverConnection
	Current notNil ifTrue: [Current close].
	Current := serverConnection!

defaultPort
	^23879!

port: port
	^(self new)
		port: port;
		yourself! !
!BeNetworkListener class categoriesFor: #current!public! !
!BeNetworkListener class categoriesFor: #current:!public! !
!BeNetworkListener class categoriesFor: #defaultPort!public! !
!BeNetworkListener class categoriesFor: #port:!public! !

