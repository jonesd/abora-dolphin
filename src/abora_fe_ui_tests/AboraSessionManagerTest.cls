"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #AboraSessionManagerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraSessionManagerTest guid: (GUID fromString: '{BFA1B172-7F3C-4B27-886F-6F8630AFED85}')!
AboraSessionManagerTest comment: ''!
!AboraSessionManagerTest categoriesForClass!SUnit! !
!AboraSessionManagerTest methodsFor!

testMain
	| shell |
	shell := AboraSessionManager basicNew main.
	shell view destroy.
! !
!AboraSessionManagerTest categoriesFor: #testMain!public! !

