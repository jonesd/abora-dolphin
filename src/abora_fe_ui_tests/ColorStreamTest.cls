"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #ColorStreamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ColorStreamTest guid: (GUID fromString: '{6F818234-53C1-480F-B953-9EDFE68B9E14}')!
ColorStreamTest comment: ''!
!ColorStreamTest categoriesForClass!SUnit! !
!ColorStreamTest methodsFor!

testBrush
	| stream |
	stream := ColorStream colors: (Array with: Color white with: Color black).
	#todo.
	self should: [stream brush notNil].!

testColor
	| stream |
	stream := ColorStream colors: (Array with: Color white with: Color black).
	self should: [stream color = Color white].!

testCreate
	| stream |
	stream := ColorStream colors: (Array with: Color white with: Color black).
	self should: [stream notNil].!

testCreateEmpty
	| stream |
	self should: [ColorStream colors: #()] raise: Error!

testNext
	| stream |
	stream := ColorStream colors: (Array with: Color white with: Color black).
	self should: [stream color = Color white].
	stream next.
	self should: [stream color = Color black].
	stream next.
	self should: [stream color = Color white].!

testNextSizeOne
	| stream |
	stream := ColorStream colors: (Array with: Color white).
	self should: [stream color = Color white].
	stream next.
	self should: [stream color = Color white].
!

testPen
	| stream |
	stream := ColorStream colors: (Array with: Color white with: Color black).
	self should: [stream pen color  = Color white].! !
!ColorStreamTest categoriesFor: #testBrush!public! !
!ColorStreamTest categoriesFor: #testColor!public! !
!ColorStreamTest categoriesFor: #testCreate!public! !
!ColorStreamTest categoriesFor: #testCreateEmpty!public! !
!ColorStreamTest categoriesFor: #testNext!public! !
!ColorStreamTest categoriesFor: #testNextSizeOne!public! !
!ColorStreamTest categoriesFor: #testPen!public! !

