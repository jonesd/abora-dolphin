"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #AboraSystem
	instanceVariableNames: 'versionNumber'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraSystem guid: (GUID fromString: '{8CB17C27-7DBD-4545-AFBF-D642611498B1}')!
AboraSystem comment: ''!
!AboraSystem categoriesForClass!Kernel-Objects! !
!AboraSystem methodsFor!

applicationName
	^'Abora'
!

showDgjPage
	self showHtmlPage: 'http://www.night.dircon.co.uk'!

showHomePage
	#todo "inappropriate class for this html stuff".
	self showHtmlPage: 'http://www.night.dircon.co.uk/abora/index.html'!

showHtmlPage: url
	ShellLibrary default shellOpen: url!

versionNumber
	^versionNumber!

versionNumber: anObject
	versionNumber := anObject! !
!AboraSystem categoriesFor: #applicationName!public! !
!AboraSystem categoriesFor: #showDgjPage!public! !
!AboraSystem categoriesFor: #showHomePage!accessing!public! !
!AboraSystem categoriesFor: #showHtmlPage:!accessing!private! !
!AboraSystem categoriesFor: #versionNumber!accessing!public! !
!AboraSystem categoriesFor: #versionNumber:!accessing!private! !

!AboraSystem class methodsFor!

current
	^Current!

initialize
"Private - 
self  initialize.
"

	Current := self new.! !
!AboraSystem class categoriesFor: #current!public! !
!AboraSystem class categoriesFor: #initialize!private! !

