"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraError subclass: #AboraRemoteError
	instanceVariableNames: 'className'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraRemoteError guid: (GUID fromString: '{8025CB80-F552-4493-88DA-5584DA622252}')!
AboraRemoteError comment: ''!
!AboraRemoteError categoriesForClass!Kernel-Exception Handling! !
!AboraRemoteError methodsFor!

className
	^className!

className: anObject
	className := anObject!

stbSaveOn: anSTBOutFiler
	anSTBOutFiler saveObject: self as: (STBAboraRemoteErrorProxy for: self)! !
!AboraRemoteError categoriesFor: #className!accessing!public! !
!AboraRemoteError categoriesFor: #className:!accessing!private! !
!AboraRemoteError categoriesFor: #stbSaveOn:!accessing!private! !

!AboraRemoteError class methodsFor!

fromError: anException
	^(self new)
		className: anException class name;
		messageText: anException description;
		yourself! !
!AboraRemoteError class categoriesFor: #fromError:!public! !

