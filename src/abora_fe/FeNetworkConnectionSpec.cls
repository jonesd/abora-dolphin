"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeNetworkConnectionSpec
	instanceVariableNames: 'ip port'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeNetworkConnectionSpec guid: (GUID fromString: '{D91823A5-3148-437F-95B2-5314FF3F84A6}')!
FeNetworkConnectionSpec comment: ''!
!FeNetworkConnectionSpec categoriesForClass!Kernel-Objects! !
!FeNetworkConnectionSpec methodsFor!

ip
	^ip!

ip: anObject
	ip := anObject!

port
	^port!

port: anObject
	port := anObject! !
!FeNetworkConnectionSpec categoriesFor: #ip!accessing!private! !
!FeNetworkConnectionSpec categoriesFor: #ip:!accessing!private! !
!FeNetworkConnectionSpec categoriesFor: #port!accessing!private! !
!FeNetworkConnectionSpec categoriesFor: #port:!accessing!private! !

!FeNetworkConnectionSpec class methodsFor!

ip: ipAddress
	^self ip: ipAddress port: BeNetworkListener defaultPort!

ip: ipAddress port: port
	^(self new)
		ip: ipAddress;
		port: port;
		yourself! !
!FeNetworkConnectionSpec class categoriesFor: #ip:!public! !
!FeNetworkConnectionSpec class categoriesFor: #ip:port:!public! !

