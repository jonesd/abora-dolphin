"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #BeDataHolderTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeDataHolderTest guid: (GUID fromString: '{F22B6F79-45B6-4CC0-82AE-1D0F3D4705AF}')!
BeDataHolderTest comment: ''!
!BeDataHolderTest categoriesForClass!Kernel-Objects! !
!BeDataHolderTest methodsFor!

testCreate
	| dataHolder |
	dataHolder := BeDataHolder value: 'hello'.

	self should: [dataHolder value  = 'hello'].!

testPrintOn
	| dataHolder |
	dataHolder := BeDataHolder value: 123.

	self should: [dataHolder printString = 'a BeDataHolder(123)'].! !
!BeDataHolderTest categoriesFor: #testCreate!public! !
!BeDataHolderTest categoriesFor: #testPrintOn!public! !

