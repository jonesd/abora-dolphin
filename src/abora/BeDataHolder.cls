"Filed out from Dolphin Smalltalk 2002 release 5.00"!

BeContentElement subclass: #BeDataHolder
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeDataHolder guid: (GUID fromString: '{E7A180D5-EAC0-4DEB-B9E0-6ACDFA73FB06}')!
BeDataHolder comment: ''!
!BeDataHolder categoriesForClass!Kernel-Objects! !
!BeDataHolder methodsFor!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '('.
	self value displayOn: aStream.
	aStream nextPutAll: ')'!

value
	^value!

value: anObject
	value := anObject! !
!BeDataHolder categoriesFor: #printOn:!public! !
!BeDataHolder categoriesFor: #value!accessing!private! !
!BeDataHolder categoriesFor: #value:!accessing!private! !

!BeDataHolder class methodsFor!

value: dataValue
	^(self new)
		value: dataValue;
		yourself! !
!BeDataHolder class categoriesFor: #value:!public! !

