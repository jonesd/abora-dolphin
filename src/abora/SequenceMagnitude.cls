"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Magnitude subclass: #SequenceMagnitude
	instanceVariableNames: 'digits'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SequenceMagnitude guid: (GUID fromString: '{5F7EFFD3-5A53-434A-B6DB-6A96AAFDF9AF}')!
SequenceMagnitude comment: ''!
!SequenceMagnitude categoriesForClass!Magnitude-General! !
!SequenceMagnitude methodsFor!

< number
	| sequence |
	sequence := number asSequenceMagnitude.
	self digitsWith: sequence do: [:digit1 :digit2 | digit1 = digit2 ifFalse: [^digit1 < digit2]].
	^false
	!

= number
	| sequence |
	self == number ifTrue: [^true].
	sequence := number asSequenceMagnitude.
	self digitsWith: sequence do: [:digit1 :digit2 | digit1 = digit2 ifFalse: [^false]].
	^true
	!

asSequenceMagnitude
	^self!

copyWith: newDigit
	^self class withAll: (self digits copyWith: newDigit)!

digits
	^digits!

digits: anObject
	digits := anObject!

digitsWith: sequence do: duadic
	^1 to: (self digits size max: sequence digits size) do: [:index |  | digit1 digit2 |
		digit1 := index > self digits size ifTrue: [0] ifFalse: [self digits at: index].
		digit2 := index > sequence digits size ifTrue: [0] ifFalse: [sequence digits at: index].
		duadic value: digit1 value: digit2].!

displayOn: aStream
	self digits inject: true
		into: 
			[:isFirst :digit | 
			isFirst ifFalse: [aStream nextPut: $:].
			digit printOn: aStream.
			false].!

greaterThanInteger: integer
	^self > integer asSequenceMagnitude!

hash
	^digits inject: 0 into: [:hash :digit | (hash bitShift: 1) bitXor: digit]
!

incrementLast
	| newDigits |
	newDigits := self digits copy.
	newDigits at: newDigits size put: newDigits last + 1.
	^self class withAll: newDigits!

isZero
	"Answer whether the receiver is zero. Many subclasses cannot be zero, since
	there is a more compact representation for zero in SmallInteger (e.g. 
	Fraction and LargeIntegers)"

	^self digits allSatisfy: [:digit | digit = 0]!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '('.
	self displayOn: aStream.
	aStream nextPutAll: ')'!

subtractFromInteger: anInteger
	"Private - Answer the result of subtracting the receiver from the known integer,
	 anInteger, by coercing the less general of it and the receiver. Overridden by 
	subclasses which can implement more efficiently."

	| newDigits |
	newDigits := OrderedCollection new.
	anInteger asSequenceMagnitude digitsWith: self do: [:digit1 :digit2 | newDigits add: digit1 - digit2].
	^self class withAll: newDigits asArray.
!

understandsArithmetic
	"Answer whether the receiver understands basic arithmetic (+, -, etc). 
	All Numbers do."

	^true! !
!SequenceMagnitude categoriesFor: #<!accessing!public! !
!SequenceMagnitude categoriesFor: #=!accessing!public! !
!SequenceMagnitude categoriesFor: #asSequenceMagnitude!public! !
!SequenceMagnitude categoriesFor: #copyWith:!public! !
!SequenceMagnitude categoriesFor: #digits!accessing!private! !
!SequenceMagnitude categoriesFor: #digits:!accessing!private! !
!SequenceMagnitude categoriesFor: #digitsWith:do:!accessing!private! !
!SequenceMagnitude categoriesFor: #displayOn:!public! !
!SequenceMagnitude categoriesFor: #greaterThanInteger:!accessing!public! !
!SequenceMagnitude categoriesFor: #hash!accessing!public! !
!SequenceMagnitude categoriesFor: #incrementLast!public! !
!SequenceMagnitude categoriesFor: #isZero!public! !
!SequenceMagnitude categoriesFor: #printOn:!public! !
!SequenceMagnitude categoriesFor: #subtractFromInteger:!private! !
!SequenceMagnitude categoriesFor: #understandsArithmetic!public! !

!SequenceMagnitude class methodsFor!

with: digit1
	^self withAll: (Array with: digit1)!

with: digit1 with: digit2
	^self withAll: (Array with: digit1 with: digit2)!

with: digit1 with: digit2 with: digit3
	^self withAll: (Array with: digit1 with: digit2 with: digit3)!

withAll: digits
	^(self new)
		digits: digits;
		yourself! !
!SequenceMagnitude class categoriesFor: #with:!public! !
!SequenceMagnitude class categoriesFor: #with:with:!public! !
!SequenceMagnitude class categoriesFor: #with:with:with:!public! !
!SequenceMagnitude class categoriesFor: #withAll:!public! !

