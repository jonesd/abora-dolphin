"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #LayoutScreen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LayoutScreen guid: (GUID fromString: '{848212D5-ABD9-4C65-B67A-77E3BA94C83D}')!
LayoutScreen comment: ''!
!LayoutScreen categoriesForClass!Kernel-Objects! !
!LayoutScreen methodsFor!

createVisibleLines: contents startPosition: startPosition visibleExtent: visibleExtent
	| visibleLines position nextBreak eoln lineNumber |
	visibleLines := OrderedCollection new.
	lineNumber := 1.
	position := 1.
	nextBreak := 0.
	[position ~= 0 and: [position <= contents size]] whileTrue: 
			[nextBreak := self startOfBreak: contents from: position.
			eoln := nextBreak.
			eoln = 0 ifTrue: [eoln := contents size + 1].
			visibleLines add: (VisibleLine 
						position: position
						extent: eoln - position
						isWrapped: false
						lineNumber: lineNumber).
			position := nextBreak > 0 
				ifTrue: [self skipFirstBreak: contents from: nextBreak]
				ifFalse: [eoln].
			lineNumber := lineNumber + 1].
	(visibleLines isEmpty or: [nextBreak > 0])
		ifTrue: 
			[visibleLines add: (VisibleLine 
						position: position
						extent: 0
						isWrapped: false
						lineNumber: lineNumber)].
	^visibleLines!

isBreakChar: char
	^char = Character lf or: [char = Character cr]!

skipFirstBreak: contents from: from
	"Private - Answer the index after the break at from. A break is either cr, lf, crlf, lfcr"

	| char |
	char := contents at: from.
	self assert: [self isBreakChar: char].
	contents size > from 
		ifTrue: 
			[| nextChar |
			nextChar := contents at: from + 1.
			((self isBreakChar: nextChar) and: [nextChar ~= char]) ifTrue: [^from + 2]].
	^from + 1!

startOfBreak: contents from: position
	^contents indexOfAnyOf: String lineDelimiter startingAt: position.! !
!LayoutScreen categoriesFor: #createVisibleLines:startPosition:visibleExtent:!public! !
!LayoutScreen categoriesFor: #isBreakChar:!private! !
!LayoutScreen categoriesFor: #skipFirstBreak:from:!private! !
!LayoutScreen categoriesFor: #startOfBreak:from:!private! !

