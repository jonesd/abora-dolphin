"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #AboraObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraObject guid: (GUID fromString: '{9A6EEC63-95C2-487A-8768-534BFDDE3B6E}')!
AboraObject comment: ''!
!AboraObject categoriesForClass!Kernel-Objects! !
!AboraObject methodsFor!

defaultLogger
	^AboraLogger root! !
!AboraObject categoriesFor: #defaultLogger!public! !

!AboraObject class methodsFor!

new
	^(super new)
		initialize;
		yourself! !
!AboraObject class categoriesFor: #new!public! !

