"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Thunk subclass: #SynchronousAction
	instanceVariableNames: 'action semaphore answer exception'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SynchronousAction guid: (GUID fromString: '{798296F0-C25F-4049-AD04-E1D587E8C6D1}')!
SynchronousAction comment: ''!
!SynchronousAction categoriesForClass!Kernel-Objects! !
!SynchronousAction methodsFor!

action
	^action!

action: anObject
	action := anObject!

initialize
	super initialize.
	semaphore := Semaphore new.!

value
	[[answer := action value] on: Error do: [:error | exception := error]] 
		ensure: [semaphore signal]!

wait
	semaphore wait.
	exception notNil ifTrue: [exception signal].
	^answer! !
!SynchronousAction categoriesFor: #action!accessing!private! !
!SynchronousAction categoriesFor: #action:!accessing!private! !
!SynchronousAction categoriesFor: #initialize!public! !
!SynchronousAction categoriesFor: #value!public! !
!SynchronousAction categoriesFor: #wait!public! !

!SynchronousAction class methodsFor!

on: action
	^(self new)
		action: action;
		yourself! !
!SynchronousAction class categoriesFor: #on:!public! !

