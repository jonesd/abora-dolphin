"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Shell subclass: #BeShell
	instanceVariableNames: 'saveOnClose textPresenter'
	classVariableNames: ''
	poolDictionaries: 'LoggerConstants'
	classInstanceVariableNames: ''!
BeShell guid: (GUID fromString: '{BF2422A3-E12A-4D47-A052-0387D5207E50}')!
BeShell comment: ''!
!BeShell categoriesForClass!MVP-Presenters! !
!BeShell methodsFor!

aboraHomePage
	AboraSystem current showHomePage.!

about
	^MessageBox new
		caption: 'About ', AboraSystem current applicationName, ': ', AboraSystem current versionNumber;
		icon: self icon;
		text: 'This is a prototype implementation of a hypertext system inspired
by Ted Nelsons Xanadu and in particular the Udanax-Gold implementation
by XOC that was released as open source in 1999.

Copyright (c) 2002 David G Jones <david_jones@night.dircon.co.uk>';
		open!

beDebugLogging
	self beLogging: DebugLevel


!

beErrorLogging
	self beLogging: ErrorLevel


!

beFatalLogging
	self beLogging: FatalLevel


!

beInfoLogging
	self beLogging: InfoLevel


!

beLogging: level
	AboraLogger root minimumLevel: level


!

beWarningLogging
	self beLogging: WarningLevel


!

createComponents
	"Private - Create the presenters contained by the receiver"

	super createComponents.
	textPresenter := self add: LoggerPresenter new name: 'logger'.
!

dgjHomePage
	AboraSystem current showDgjPage.!

initialize
	super initialize.
	saveOnClose := false!

onCloseRequested: aValueHolder
	saveOnClose ifTrue: [Cursor wait showWhile: [self saveWorksStorage]].
	aValueHolder value: true
!

onViewClosed
	"Sent by the receiver's view when it has been closed"

	super onViewClosed.
	AboraLogger root removeAppender: textPresenter.!

onViewOpened
	"Now run through all our sub-presenters and connect them in turn
	to same named sub-views within aCompositeView"

	super onViewOpened.
	AboraLogger root addAppender: textPresenter.!

queryCommand: aCommandQuery
	"Private - Enters details about a potential command for the receiver into aCommandQuery"

	| selector |
	selector := aCommandQuery commandSymbol.
	#beDebugLogging == selector 
		ifTrue: 
			[aCommandQuery isEnabled: true.
			aCommandQuery isChecked: AboraLogger root minimumLevel = DebugLevel.
			^true].
	#beInfoLogging == selector 
		ifTrue: 
			[aCommandQuery isEnabled: true.
			aCommandQuery isChecked: AboraLogger root minimumLevel = InfoLevel.
			^true].
	#beWarningLogging == selector 
		ifTrue: 
			[aCommandQuery isEnabled: true.
			aCommandQuery isChecked: AboraLogger root minimumLevel = WarningLevel.
			^true].
	#beErrorLogging == selector 
		ifTrue: 
			[aCommandQuery isEnabled: true.
			aCommandQuery isChecked: AboraLogger root minimumLevel = ErrorLevel.
			^true].
	#beFatalLogging == selector 
		ifTrue: 
			[aCommandQuery isEnabled: true.
			aCommandQuery isChecked: AboraLogger root minimumLevel = FatalLevel.
			^true].
	^super queryCommand: aCommandQuery!

saveOnClose
	^saveOnClose!

saveOnClose: anObject
	saveOnClose := anObject!

saveWorksStorage
	WorksStorageDumper new dumpWorksStorage.!

worksStorage
	^WorksStorage current!

worksStorageSummary
	| summary title classes |
	summary := WriteStream on: String new.
	summary nextPutAll: 'Works Storage Summary: '.
	TimeStamp current displayOn: summary.
	title := summary contents copy.
	summary
		cr;
		cr;
		nextPutAll: 'Total Works: '.
	self worksStorage works size displayOn: summary.
	summary
		cr;
		nextPutAll: 'Total Ids: '.
	self worksStorage knownIds displayOn: summary.
	summary
		cr;
		nextPutAll: 'Persisted size: '.
	self worksStorage binaryStoreBytes size displayOn: summary.
	summary nextPutAll: ' bytes'.
	summary
		cr;
		cr;
		nextPutAll: 'Instances:'.
	classes := #(#BeWork #BeEdition #BeClub #BeCollectionHolder #BeDataHolder #RootNode #SplitNode #CollectionLeaf #ContentLeaf #IntegerRegion #BeContentElementProxy #STBBeContentElementForBE #STBBeContentElementForFE #FeEdition #FeWork #FeClub).
	classes do: 
			[:class | 
			summary
				cr;
				nextPutAll: 'Total '.
			class displayOn: summary.
			summary nextPutAll: ': '.
			[(Smalltalk at: class) allInstances size displayOn: summary] on: Error
				do: [:e | summary nextPutAll: 'Missing']].
	^(TextPresenter show: 'Multiline text' on: summary contents) view topView caption: title! !
!BeShell categoriesFor: #aboraHomePage!public! !
!BeShell categoriesFor: #about!public! !
!BeShell categoriesFor: #beDebugLogging!public! !
!BeShell categoriesFor: #beErrorLogging!public! !
!BeShell categoriesFor: #beFatalLogging!public! !
!BeShell categoriesFor: #beInfoLogging!public! !
!BeShell categoriesFor: #beLogging:!public! !
!BeShell categoriesFor: #beWarningLogging!public! !
!BeShell categoriesFor: #createComponents!accessing!private! !
!BeShell categoriesFor: #dgjHomePage!public! !
!BeShell categoriesFor: #initialize!public! !
!BeShell categoriesFor: #onCloseRequested:!public! !
!BeShell categoriesFor: #onViewClosed!accessing!private! !
!BeShell categoriesFor: #onViewOpened!accessing!private! !
!BeShell categoriesFor: #queryCommand:!accessing!private! !
!BeShell categoriesFor: #saveOnClose!accessing!private! !
!BeShell categoriesFor: #saveOnClose:!accessing!private! !
!BeShell categoriesFor: #saveWorksStorage!public! !
!BeShell categoriesFor: #worksStorage!private! !
!BeShell categoriesFor: #worksStorageSummary!public! !

