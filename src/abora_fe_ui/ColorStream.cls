"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #ColorStream
	instanceVariableNames: 'colors colorIndex'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ColorStream guid: (GUID fromString: '{B7FC18DA-AA62-4F4C-A4C7-57A631103AF8}')!
ColorStream comment: ''!
!ColorStream categoriesForClass!Kernel-Objects! !
!ColorStream methodsFor!

brush
	| brush |
	brush := self current at: 2.
	brush isNil 
		ifTrue: 
			[brush := Brush color: self color.
			self current at: 2 put: brush].
	^brush!

color
	^self current at: 1
!

current
	^colors at: colorIndex
!

initialize: simplyColors
	colorIndex := 1.
	simplyColors isEmpty ifTrue: [self error: 'must specify at least 1 color'].
	colors := simplyColors collect: [:color | Array with: color with: nil with: nil]!

next
	colorIndex := colorIndex + 1.
	colorIndex > colors size ifTrue: [colorIndex := 1].
!

pen
	| pen |
	pen := self current at: 3.
	pen isNil 
		ifTrue: 
			[pen := Pen color: self color.
			self current at: 3 put: pen].
	^pen! !
!ColorStream categoriesFor: #brush!public! !
!ColorStream categoriesFor: #color!public! !
!ColorStream categoriesFor: #current!private! !
!ColorStream categoriesFor: #initialize:!private! !
!ColorStream categoriesFor: #next!public! !
!ColorStream categoriesFor: #pen!public! !

!ColorStream class methodsFor!

colors: colors
	^(self new)
		initialize: colors;
		yourself! !
!ColorStream class categoriesFor: #colors:!public! !

