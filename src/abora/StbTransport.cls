"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ConnectionTransport subclass: #StbTransport
	instanceVariableNames: 'inFiler outFiler'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
StbTransport guid: (GUID fromString: '{56F33F22-0C3A-4FEB-8CDF-E15F8F65BC53}')!
StbTransport comment: 'readStream: readStream writeStream: writeStream
	^self new initializeWithReadStream readStream writeStream: writeStream; yourself'!
!StbTransport categoriesForClass!Kernel-Objects! !
!StbTransport methodsFor!

inContext: context
	inFiler context: context!

initializeWithReadStream: readStream writeStream: writeStream
	outFiler := STBOutFiler on: writeStream.
	outFiler stream flush.
	inFiler := STBInFiler on: readStream!

next
	^inFiler next!

nextPut: object
	outFiler nextPut: object.
	outFiler stream flush!

outContext: context
	outFiler context: context! !
!StbTransport categoriesFor: #inContext:!public! !
!StbTransport categoriesFor: #initializeWithReadStream:writeStream:!private! !
!StbTransport categoriesFor: #next!public! !
!StbTransport categoriesFor: #nextPut:!public! !
!StbTransport categoriesFor: #outContext:!public! !

!StbTransport class methodsFor!

readStream: readStream writeStream: writeStream
	^(self new)
		initializeWithReadStream: readStream writeStream: writeStream;
		yourself! !
!StbTransport class categoriesFor: #readStream:writeStream:!public! !

