"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #LoggerLevel
	instanceVariableNames: 'name value'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LoggerLevel guid: (GUID fromString: '{19064AB3-357A-4F7C-BBDC-14C97886A651}')!
LoggerLevel comment: ''!
!LoggerLevel categoriesForClass!Kernel-Objects! !
!LoggerLevel methodsFor!

initializeWithName: setName value: setValue
	name := setName.
	value := setValue.
	!

isSufficientLevel: level
	^value >= level value!

name
	^name!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '('.
	self name displayOn: aStream.
	aStream nextPutAll: ')'.!

value
	^value! !
!LoggerLevel categoriesFor: #initializeWithName:value:!private! !
!LoggerLevel categoriesFor: #isSufficientLevel:!accessing!public! !
!LoggerLevel categoriesFor: #name!accessing!public! !
!LoggerLevel categoriesFor: #printOn:!accessing!private! !
!LoggerLevel categoriesFor: #value!accessing!private! !

!LoggerLevel class methodsFor!

name: setName value: value
	^self new initializeWithName: setName value: value! !
!LoggerLevel class categoriesFor: #name:value:!public! !

