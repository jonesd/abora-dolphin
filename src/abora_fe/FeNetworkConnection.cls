"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeConnection subclass: #FeNetworkConnection
	instanceVariableNames: 'ip port socket transport'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeNetworkConnection guid: (GUID fromString: '{5FB8C6C2-B0A7-479F-939E-589EFAB234D1}')!
FeNetworkConnection comment: ''!
!FeNetworkConnection categoriesForClass!Kernel-Objects! !
!FeNetworkConnection methodsFor!

basicReceive
	| answer |
	answer := transport next.
	^answer!

basicSend: object
	(object isKindOf: BlockClosure) 
		ifTrue: 
			["self halt"

			].
	"Transcript
				show: self identityHash displayString,'# sending';
				cr."
	transport nextPut: object.
!

close
	transport notNil 
		ifTrue: 
			[transport close.
			transport := nil].
	socket notNil 
		ifTrue: 
			[socket close.
			socket := nil]!

connect
	self close.
	socket := Socket port: self port address: (InternetAddress fromString: self ip).
	socket connect.
	transport := StbTransport readStream: socket readStream writeStream: socket writeStream.
	transport outContext: #forBe.
	self loginToServer!

ip
	^ip!

ip: anObject
	ip := anObject!

loginToServer
	| result |
	#todo.	"feHash"
	transport
		nextPut: #login;
		nextPut: Random new next;
		nextPut: SystemIds universalPublicClub.
	result := transport next.
	self assert: [result = 'ok']!

port
	^port!

port: anObject
	port := anObject!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(ip='.
	self ip displayOn: aStream.
	aStream nextPutAll: ', port='.
	self port displayOn: aStream.
	aStream nextPutAll: ')'
! !
!FeNetworkConnection categoriesFor: #basicReceive!private! !
!FeNetworkConnection categoriesFor: #basicSend:!private! !
!FeNetworkConnection categoriesFor: #close!public! !
!FeNetworkConnection categoriesFor: #connect!public! !
!FeNetworkConnection categoriesFor: #ip!accessing!private! !
!FeNetworkConnection categoriesFor: #ip:!accessing!private! !
!FeNetworkConnection categoriesFor: #loginToServer!private! !
!FeNetworkConnection categoriesFor: #port!accessing!private! !
!FeNetworkConnection categoriesFor: #port:!accessing!private! !
!FeNetworkConnection categoriesFor: #printOn:!public! !

!FeNetworkConnection class methodsFor!

fromSpec: spec
	^self ip: spec ip port: spec port!

ip: ipAddress
	^self ip: ipAddress port: BeNetworkListener defaultPort!

ip: ipAddress port: port
	^(self new)
		ip: ipAddress;
		port: port;
		yourself! !
!FeNetworkConnection class categoriesFor: #fromSpec:!public! !
!FeNetworkConnection class categoriesFor: #ip:!public! !
!FeNetworkConnection class categoriesFor: #ip:port:!public! !

