"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #Id
	instanceVariableNames: 'value'
	classVariableNames: 'NextValue'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
Id guid: (GUID fromString: '{CAD60426-A7B8-4714-BA6B-E0DB7FC492E3}')!
Id comment: ''!
!Id categoriesForClass!Kernel-Objects! !
!Id methodsFor!

= anId
	^self species == anId species and: [self value = anId value]!

hash
	^self value hash!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPut: $(.
	self value displayOn: aStream.
	aStream nextPut: $)!

value
	^value!

value: anObject
	value := anObject! !
!Id categoriesFor: #=!public! !
!Id categoriesFor: #hash!public! !
!Id categoriesFor: #printOn:!public! !
!Id categoriesFor: #value!accessing!public! !
!Id categoriesFor: #value:!accessing!private! !

!Id class methodsFor!

initialize
"Private - 
Id initialize
"

	NextValue := 1.!

nextId
	| id |
	id := (self new)
				value: NextValue;
				yourself.
	NextValue := NextValue + 1.
	^id!

nextIdFor: anObject
	| id |
	id := self nextId.
	WorksStorage current addId: id with: anObject.
	^id! !
!Id class categoriesFor: #initialize!private! !
!Id class categoriesFor: #nextId!public! !
!Id class categoriesFor: #nextIdFor:!public! !

