"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraRegion subclass: #IntegerRegion
	instanceVariableNames: 'startPosition extent'
	classVariableNames: 'EmptyRegion'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
IntegerRegion guid: (GUID fromString: '{5E4CA68D-C0C4-4D36-8FC8-92EBF8487432}')!
IntegerRegion comment: ''!
!IntegerRegion categoriesForClass!Kernel-Objects! !
!IntegerRegion methodsFor!

= comperand
	^self species == comperand species 
		and: [self startPosition = comperand startPosition and: [self extent = comperand extent]]!

beyondPosition
	^self startPosition + self extent!

displayOn: aStream
	
	aStream nextPut: $[.
	self startPosition printOn: aStream.
	aStream nextPutAll: ', '.
	self endPosition printOn: aStream.
	aStream nextPut: $]!

do: operation
	^self startPosition to: self endPosition do: [:position | operation value: position]!

endPosition
	^self startPosition + self extent - 1!

extent
	^extent!

extent: anObject
	extent := anObject!

hash
	^(self startPosition hash bitShift: 1) bitXor: self extent hash!

includes: position
	| relativePosition |
	relativePosition := self relativePosition: position.
	^relativePosition between: 0 and: self extent - 1!

intersection: anotherRegion
	"Answer a region with positions the receiver and anotherRegion have in common."

	^(self intersects: anotherRegion) 
		ifTrue: 
			[self class startPosition: (self startPosition max: anotherRegion startPosition)
				endPosition: (self endPosition min: anotherRegion endPosition)]
		ifFalse: [self class empty]!

intersects: anotherRegion
	"Answer whether any position of the receiver can be found in anotherRegion."

	^self startPosition <= anotherRegion endPosition and: [self endPosition >= anotherRegion startPosition]!

isEmpty
	^self extent <= 0!

printOn: aStream
	aStream nextPutAll: 'IntegerRegion(pos='.
	self startPosition printOn: aStream.
	aStream nextPutAll: ', extent='.
	self extent printOn: aStream.
	aStream nextPutAll: ')'!

relativePosition: position
	^position - self startPosition!

startPosition
	^startPosition!

startPosition: anObject
	startPosition := anObject! !
!IntegerRegion categoriesFor: #=!accessing!public! !
!IntegerRegion categoriesFor: #beyondPosition!accessing!public! !
!IntegerRegion categoriesFor: #displayOn:!accessing!public! !
!IntegerRegion categoriesFor: #do:!accessing!public! !
!IntegerRegion categoriesFor: #endPosition!accessing!public! !
!IntegerRegion categoriesFor: #extent!accessing!public! !
!IntegerRegion categoriesFor: #extent:!accessing!private! !
!IntegerRegion categoriesFor: #hash!accessing!public! !
!IntegerRegion categoriesFor: #includes:!accessing!public! !
!IntegerRegion categoriesFor: #intersection:!public! !
!IntegerRegion categoriesFor: #intersects:!public! !
!IntegerRegion categoriesFor: #isEmpty!public! !
!IntegerRegion categoriesFor: #printOn:!accessing!public! !
!IntegerRegion categoriesFor: #relativePosition:!accessing!public! !
!IntegerRegion categoriesFor: #startPosition!accessing!public! !
!IntegerRegion categoriesFor: #startPosition:!accessing!private! !

!IntegerRegion class methodsFor!

empty
	^EmptyRegion!

initialize
"Private - 
IntegerRegion initialize
"

	EmptyRegion := self startPosition: 0 extent: 0.!

startPosition: startPosition endPosition: endPosition
	^self startPosition: startPosition extent: endPosition - startPosition + 1!

startPosition: startPosition extent: extent
	^(self new)
		startPosition: startPosition;
		extent: extent;
		yourself! !
!IntegerRegion class categoriesFor: #empty!public! !
!IntegerRegion class categoriesFor: #initialize!private! !
!IntegerRegion class categoriesFor: #startPosition:endPosition:!public! !
!IntegerRegion class categoriesFor: #startPosition:extent:!public! !

