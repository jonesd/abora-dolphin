"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #VisibleLine
	instanceVariableNames: 'position isWrapped extent lineNumber'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
VisibleLine guid: (GUID fromString: '{6F456875-784B-47AB-B1E1-ED8319EF1E87}')!
VisibleLine comment: ''!
!VisibleLine categoriesForClass!Kernel-Objects! !
!VisibleLine methodsFor!

extent
	^extent!

extent: anObject
	extent := anObject!

isWrapped
	^isWrapped!

isWrapped: anObject
	isWrapped := anObject!

lineNumber
	^lineNumber!

lineNumber: anObject
	lineNumber := anObject!

position
	^position!

position: anObject
	position := anObject!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(pos='.
	self position printOn: aStream.
	aStream nextPutAll: ', extent='.
	self extent printOn: aStream.
	aStream nextPutAll: ', isWrapped='.
	self isWrapped printOn: aStream.
	aStream nextPutAll: ', line='.
	self lineNumber printOn: aStream.
	aStream nextPutAll: ')'! !
!VisibleLine categoriesFor: #extent!accessing!private! !
!VisibleLine categoriesFor: #extent:!accessing!private! !
!VisibleLine categoriesFor: #isWrapped!accessing!private! !
!VisibleLine categoriesFor: #isWrapped:!accessing!private! !
!VisibleLine categoriesFor: #lineNumber!accessing!private! !
!VisibleLine categoriesFor: #lineNumber:!accessing!private! !
!VisibleLine categoriesFor: #position!accessing!private! !
!VisibleLine categoriesFor: #position:!accessing!private! !
!VisibleLine categoriesFor: #printOn:!accessing!private! !

!VisibleLine class methodsFor!

position: position extent: extent isWrapped: isWrapped lineNumber: lineNumber
	^(self new)
		position: position;
		extent: extent;
		isWrapped: isWrapped;
		lineNumber: lineNumber;
		yourself! !
!VisibleLine class categoriesFor: #position:extent:isWrapped:lineNumber:!public! !

