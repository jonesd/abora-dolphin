"Filed out from Dolphin Smalltalk 2002 release 5.00"!

SequenceMagnitude subclass: #BranchingNumber
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BranchingNumber guid: (GUID fromString: '{DCBE6FA6-2E00-458B-9901-D5575964F501}')!
BranchingNumber comment: ''!
!BranchingNumber categoriesForClass!Magnitude-General! !
!BranchingNumber methodsFor!

< number
	| sequence |
	sequence := number asBranchingNumber.
	self digits size > sequence digits size ifTrue: [^false].
	1 to: self digits size - 1
		do: [:index | (self digits at: index) ~= (sequence digits at: index) ifTrue: [^false]].
	^self digits size < sequence digits size 
		ifTrue: [self digits last <= (sequence digits at: self digits size)]
		ifFalse: [self digits last < (sequence digits at: self digits size)]!

asBranchingNumber
	^self
!

greaterThanInteger: integer
	^self > integer asBranchingNumber!

isBeforeOrEqual: comperand
	^self < comperand or: [self = comperand]!

subtractFromInteger: anInteger
	"Private - Answer the result of subtracting the receiver from the known integer,
	 anInteger, by coercing the less general of it and the receiver. Overridden by 
	subclasses which can implement more efficiently."

	| newDigits |
	newDigits := OrderedCollection new.
	anInteger asBranchingNumber digitsWith: self do: [:digit1 :digit2 | newDigits add: digit1 - digit2].
	^self class withAll: newDigits asArray.
! !
!BranchingNumber categoriesFor: #<!public! !
!BranchingNumber categoriesFor: #asBranchingNumber!public! !
!BranchingNumber categoriesFor: #greaterThanInteger:!public! !
!BranchingNumber categoriesFor: #isBeforeOrEqual:!public! !
!BranchingNumber categoriesFor: #subtractFromInteger:!public! !

