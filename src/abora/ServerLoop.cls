"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Thunk subclass: #ServerLoop
	instanceVariableNames: 'actions process'
	classVariableNames: 'Current ExitCookie'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ServerLoop guid: (GUID fromString: '{B94CBF0F-C755-43EB-832A-84D0D7B032C5}')!
ServerLoop comment: ''!
!ServerLoop categoriesForClass!Kernel-Objects! !
!ServerLoop methodsFor!

addAction: action
	actions nextPut: action!

addActionAndWait: action
	| synchronousAction |
	synchronousAction := SynchronousAction on: action.
	self addAction: synchronousAction.
	^synchronousAction wait. 
	
!

initialize
	super initialize.

	actions := SharedQueue new.!

processLoop
	| action |
	
	[action := actions next.
	action == ExitCookie] 
			whileFalse: [[action value] on: Error do: [:error | self halt]].
	process := nil!

stop
	self addAction: ExitCookie.!

value
	process := [self processLoop] fork! !
!ServerLoop categoriesFor: #addAction:!public! !
!ServerLoop categoriesFor: #addActionAndWait:!public! !
!ServerLoop categoriesFor: #initialize!private! !
!ServerLoop categoriesFor: #processLoop!private! !
!ServerLoop categoriesFor: #stop!public! !
!ServerLoop categoriesFor: #value!public! !

!ServerLoop class methodsFor!

current
	^Current!

initialize
"Private - 
self initialize.
"
	ExitCookie := ExitCookie ifNil: [Object new].
	Current := self new.! !
!ServerLoop class categoriesFor: #current!public! !
!ServerLoop class categoriesFor: #initialize!private! !

