"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #ConnectionTransport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ConnectionTransport guid: (GUID fromString: '{45B51A02-B87B-409F-BBDE-430F152E7D95}')!
ConnectionTransport comment: ''!
!ConnectionTransport categoriesForClass!Kernel-Objects! !
!ConnectionTransport methodsFor!

close
	"ignore"!

inContext: context
	"ignore"!

next
	self subclassResponsibility!

nextPut: object
	self subclassResponsibility!

outContext: context
	"ignore"! !
!ConnectionTransport categoriesFor: #close!public! !
!ConnectionTransport categoriesFor: #inContext:!public! !
!ConnectionTransport categoriesFor: #next!public! !
!ConnectionTransport categoriesFor: #nextPut:!public! !
!ConnectionTransport categoriesFor: #outContext:!public! !

