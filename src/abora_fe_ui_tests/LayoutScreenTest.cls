"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #LayoutScreenTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LayoutScreenTest guid: (GUID fromString: '{6A670A33-C015-426C-887E-2B6209BD9759}')!
LayoutScreenTest comment: ''!
!LayoutScreenTest categoriesForClass!SUnit! !
!LayoutScreenTest methodsFor!

assertVisibleLine: actual is: expected
	self should: [actual position = expected position].
	self should: [actual extent = expected extent].
	self should: [actual isWrapped = expected isWrapped].
	self should: [actual lineNumber = expected lineNumber].
	!

assertVisibleLines: actual is: expected
	self should: [actual size = expected size].
	actual with: expected
		do: [:actualElement :expectedElement | self assertVisibleLine: actualElement is: expectedElement]!

testAlienLineDelimiter
	| text visibleLines |
	text := '12345' , Character cr asString , '6' , Character lf asString , '7' 
				, Character lf asString , Character cr asString 
				, '8'.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array 
				with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1)
				with: (VisibleLine 
						position: 7
						extent: 1
						isWrapped: false
						lineNumber: 2)
				with: (VisibleLine 
						position: 9
						extent: 1
						isWrapped: false
						lineNumber: 3)
				with: (VisibleLine 
						position: 12
						extent: 1
						isWrapped: false
						lineNumber: 4))!

testEmpty
	| text visibleLines |
	text := ''.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array with: (VisibleLine 
						position: 1
						extent: 0
						isWrapped: false
						lineNumber: 1))!

testEmptyLines
	| text visibleLines |
	text := '12345' , String lineDelimiter , String lineDelimiter , '890'.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array 
				with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1)
				with: (VisibleLine 
						position: 8
						extent: 0
						isWrapped: false
						lineNumber: 2)
				with: (VisibleLine 
						position: 10
						extent: 3
						isWrapped: false
						lineNumber: 3))!

testFirstLine
	| text visibleLines |
	text := '12345'.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1))!

testMultipleLines
	| text visibleLines |
	text := '12345' , String lineDelimiter , '67' , String lineDelimiter , '890'.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array 
				with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1)
				with: (VisibleLine 
						position: 8
						extent: 2
						isWrapped: false
						lineNumber: 2)
				with: (VisibleLine 
						position: 12
						extent: 3
						isWrapped: false
						lineNumber: 3))!

testTrailingEmptyLine
	| text visibleLines |
	text := '12345' , String lineDelimiter.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array 
				with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1)
				with: (VisibleLine 
						position: 8
						extent: 0
						isWrapped: false
						lineNumber: 2))!

testTrailingEmptyLines
	| text visibleLines |
	text := '12345' , String lineDelimiter , String lineDelimiter.

	"operation"
	visibleLines := LayoutScreen new 
				createVisibleLines: text
				startPosition: 1
				visibleExtent: 20 @ 20.
	self assertVisibleLines: visibleLines
		is: (Array 
				with: (VisibleLine 
						position: 1
						extent: 5
						isWrapped: false
						lineNumber: 1)
				with: (VisibleLine 
						position: 8
						extent: 0
						isWrapped: false
						lineNumber: 2)
				with: (VisibleLine 
						position: 10
						extent: 0
						isWrapped: false
						lineNumber: 3))! !
!LayoutScreenTest categoriesFor: #assertVisibleLine:is:!private! !
!LayoutScreenTest categoriesFor: #assertVisibleLines:is:!private! !
!LayoutScreenTest categoriesFor: #testAlienLineDelimiter!public! !
!LayoutScreenTest categoriesFor: #testEmpty!public! !
!LayoutScreenTest categoriesFor: #testEmptyLines!public! !
!LayoutScreenTest categoriesFor: #testFirstLine!public! !
!LayoutScreenTest categoriesFor: #testMultipleLines!public! !
!LayoutScreenTest categoriesFor: #testTrailingEmptyLine!public! !
!LayoutScreenTest categoriesFor: #testTrailingEmptyLines!public! !

