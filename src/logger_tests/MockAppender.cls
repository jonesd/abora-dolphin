"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #MockAppender
	instanceVariableNames: 'actualLogItems expectedLogItems'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
MockAppender guid: (GUID fromString: '{A305C4D8-7750-4364-AC8E-DBAFABD9DE94}')!
MockAppender comment: ''!
!MockAppender categoriesForClass!Kernel-Objects! !
!MockAppender methodsFor!

addExpected: level name: name message: message
	expectedLogItems add: (self 
				logItem: level
				name: name
				message: message)!

append: level name: name message: message
	actualLogItems add: (self 
				logItem: level
				name: name
				message: message)!

expectedLogItems
	^expectedLogItems!

expectedLogItems: anObject
	expectedLogItems := anObject!

initialize
	super initialize.

	expectedLogItems := OrderedCollection new.
	actualLogItems := OrderedCollection new.!

logItem: level name: name message: message
	^Array 
		with: level
		with: name
		with: message!

verify: testCase
	testCase should: [actualLogItems = expectedLogItems].! !
!MockAppender categoriesFor: #addExpected:name:message:!public! !
!MockAppender categoriesFor: #append:name:message:!public! !
!MockAppender categoriesFor: #expectedLogItems!accessing!private! !
!MockAppender categoriesFor: #expectedLogItems:!accessing!private! !
!MockAppender categoriesFor: #initialize!private! !
!MockAppender categoriesFor: #logItem:name:message:!public! !
!MockAppender categoriesFor: #verify:!public! !

!MockAppender class methodsFor!

new
	^super new initialize! !
!MockAppender class categoriesFor: #new!public! !

