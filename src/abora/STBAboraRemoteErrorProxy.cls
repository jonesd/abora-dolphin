"Filed out from Dolphin Smalltalk 2002 release 5.00"!

STBProxy subclass: #STBAboraRemoteErrorProxy
	instanceVariableNames: 'className messageText'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
STBAboraRemoteErrorProxy guid: (GUID fromString: '{A8B34AA6-BEA3-4B5D-B4F7-85EA5FFC093D}')!
STBAboraRemoteErrorProxy comment: ''!
!STBAboraRemoteErrorProxy categoriesForClass!Kernel-Objects! !
!STBAboraRemoteErrorProxy methodsFor!

className
	^className!

className: anObject
	className := anObject!

messageText
	^messageText!

messageText: anObject
	messageText := anObject!

value
	^(AboraRemoteError new)
		className: self className;
		messageText: self messageText;
		yourself! !
!STBAboraRemoteErrorProxy categoriesFor: #className!accessing!private! !
!STBAboraRemoteErrorProxy categoriesFor: #className:!accessing!private! !
!STBAboraRemoteErrorProxy categoriesFor: #messageText!accessing!private! !
!STBAboraRemoteErrorProxy categoriesFor: #messageText:!accessing!private! !
!STBAboraRemoteErrorProxy categoriesFor: #value!accessing!private! !

!STBAboraRemoteErrorProxy class methodsFor!

for: anAboraRemoteError
	^(self basicNew)
		className: anAboraRemoteError className;
		messageText: anAboraRemoteError messageText;
		yourself! !
!STBAboraRemoteErrorProxy class categoriesFor: #for:!public! !

