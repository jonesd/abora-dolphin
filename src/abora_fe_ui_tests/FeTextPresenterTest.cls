"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #FeTextPresenterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextPresenterTest guid: (GUID fromString: '{E9C2B06A-22A3-464E-B707-911439297833}')!
FeTextPresenterTest comment: ''!
!FeTextPresenterTest categoriesForClass!SUnit! !
!FeTextPresenterTest methodsFor!

createTextPresenterEmpty
	^FeTextPresenter show!

createTextPresenterOn: beWork
	| beWorkProxy textModel |
	beWorkProxy := BeContentElementProxy for: beWork.
	textModel := FeTextModel work: (FeWork on: beWorkProxy).
	^FeTextPresenter showOn: textModel!

createTextPresenterWith: text
	| work edition topEdition textModel |
	edition := BeEdition contents:  text asAboraContent.
	edition endorse: SystemIds textEditionEndorsement.
	topEdition := BeEdition contents: edition.
	work := BeWork edition: topEdition.
	textModel := FeTextModel work: (FeWork on: work).
	^FeTextPresenter showOn: textModel!

createTextPresenterWith1234567890
	^self createTextPresenterWith: self text1234567890!

createTextPresenterWith1234567890WithBreaks
	^self createTextPresenterWith: self text1234567890WithBreaks!

createWorkEmpty
	^self createWorkWith: ''!

createWorkWith: text
	| work edition topEdition textModel |
	edition := BeEdition contents:  text asAboraContent.
	edition endorse: SystemIds textEditionEndorsement.
	topEdition := BeEdition contents: edition.
	work := BeWork edition: topEdition.
	^work!

createWorkWith1234567890
	^self createWorkWith: self text1234567890!

createWorkWith1234567890WithBreaks
	^self createWorkWith: self text1234567890WithBreaks!

testCopySelection
	| work presenter selection |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.
	presenter view selectFrom: 3 extent: 4.
	selection := presenter copySelection.
	self should: [selection notNil].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view point = 6].
	self should: [Clipboard current isTextAvailable].
	self should: [Clipboard current getText = '3456'].
	self should: [Clipboard current isObjectAvailable].
	self should: [Clipboard current getObject position = 3].
	self should: [Clipboard current getObject extent = 4].
	self should: [Clipboard current getObject position = 3].
	self should: [Clipboard current getObject id = presenter model edition id].
	self should: [presenter view topShell destroy]!

testCopySelectionEmpty
	| work presenter selection |
	work := self createWorkEmpty.
	presenter := self createTextPresenterOn: work.

	selection := presenter copySelection.
	self should: [selection isNil].
	self should: [presenter view point = 1].
	self should: [presenter view topShell destroy].!

testCreate
	| presenter |
	presenter := FeTextPresenter show.
	self should: [presenter model textEdition contents isEmpty].
	self shouldnt: [presenter showNonNativeLinks].
	self should: [presenter view  topShell destroy].!

testCreateWithContents
	| work presenter |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.
	
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view topShell destroy].!

testCutSelection
	| work presenter selection |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	presenter view selectFrom: 3 extent: 4.
	selection := presenter cutSelection.
	self should: [selection notNil].
	self should: [presenter model textEdition contents = '127890'].
	self should: [presenter view point = 3].
	self should: [Clipboard current isTextAvailable].
	self should: [Clipboard current getText = '3456'].
	self should: [Clipboard current isObjectAvailable].
	self should: [Clipboard current getObject position = 3].
	self should: [Clipboard current getObject extent = 4].
	self should: [Clipboard current getObject position = 3].
	self should: [Clipboard current getObject id = presenter model edition id].
	self should: [presenter view topShell destroy]!

testCutSelectionEmpty
	| work presenter selection |
	work := self createWorkEmpty.
	presenter := self createTextPresenterOn: work.

	selection := presenter cutSelection.
	self should: [selection isNil].
	self should: [presenter view point = 1].
	self should: [presenter view topShell destroy].!

testDeleteSelection
	| work presenter filename fileStream |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.
	presenter view selectFrom: 3 extent: 2.
	presenter deleteSelection.
	self should: [presenter model textEdition contents = '12567890'].
	self should: [presenter view point = 3].
	presenter view selectFrom: 3 extent: 1.
	presenter deleteSelection.
	self should: [presenter model textEdition contents = '1267890'].
	self should: [presenter view point = 3].
	presenter view selectFrom: 1 extent: 3.
	presenter deleteSelection.
	self should: [presenter model textEdition contents = '7890'].
	self should: [presenter view point = 1].
	presenter view selectFrom: 4 extent: 1.
	presenter deleteSelection.
	self should: [presenter view point = 4].
	self should: [presenter model textEdition contents = '789'].
	presenter view selectFrom: 2 extent: 2.
	presenter deleteSelection.
	self should: [presenter view point = 2].
	self should: [presenter model textEdition contents = '7'].
	presenter view selectFrom: 1 extent: 1.
	presenter deleteSelection.
	self should: [presenter model textEdition contents = ''].
	self should: [presenter view point = 1].

	self should: [presenter view topShell destroy]!

testDeleteSelectionEmpty
	| work presenter filename fileStream |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	presenter deleteSelection; flushChanges.
	self should: [presenter model textEdition contents = self text1234567890].
	self should: [presenter view topShell destroy].!

testExportAsFile
	| work presenter filename fileStream |
	work := self createWorkWith1234567890WithBreaks.
	presenter := self createTextPresenterOn: work.

	filename := File temporaryFilename.
	presenter exportAsFile: filename.
	
	[fileStream := FileStream read: filename.
	[self should: [fileStream contents = self text1234567890WithBreaks]] 
		ensure: [fileStream close].
	self should: [presenter view topShell destroy]] 
			ensure: [File delete: filename]!

testExportAsFileEmpty
	| work presenter filename fileStream |
	work := self createWorkEmpty.
	presenter := self createTextPresenterOn: work.

	filename := File temporaryFilename.
	presenter exportAsFile: filename.
	
	[fileStream := FileStream read: filename.
	[self should: [fileStream contents = '']] ensure: [fileStream close].
	self should: [presenter view topShell destroy]] 
			ensure: [File delete: filename]!

testFlushChanges
	| work presenter filename fileStream |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	presenter flushChanges.
	self should: [presenter model textEdition contents = self text1234567890].

	presenter view insertText: 'abcd'.
	self should: [presenter model textEdition contents = 'abcd1234567890'].
	self should: [presenter model textEdition hasPendingChanges].
	presenter flushChanges.
	self should: [presenter model textEdition contents = 'abcd1234567890'].

	self should: [presenter view topShell destroy].!

testInsertFile
	| work presenter filename fileStream |
	work := self createWorkWith1234567890WithBreaks.
	presenter := self createTextPresenterOn: work.

	filename := File temporaryFilename.
	(FileStream write: filename) nextPutAll: 'abc', String lineDelimiter, 'def'; close.

	[presenter view movePointTo: 3.
	presenter insertFile: filename.
	self should: [presenter model textEdition contents = ('12abc', String lineDelimiter, 'def3', String lineDelimiter, '4', String lineDelimiter, '567', String lineDelimiter, String lineDelimiter, '890')].
	
	self should: [presenter view topShell destroy]] 
			ensure: [File delete: filename]!

testInsertFileAtStart
	| work presenter filename fileStream |
	work := self createWorkWith1234567890WithBreaks.
	presenter := self createTextPresenterOn: work.

	filename := File temporaryFilename.
	(FileStream write: filename) nextPutAll: 'abc', String lineDelimiter, 'def'; close.

	[presenter insertFile: filename.
	self should: [presenter model textEdition contents = ('abc', String lineDelimiter, 'def', self text1234567890WithBreaks)].
	
	self should: [presenter view topShell destroy]] 
			ensure: [File delete: filename]!

testInspectEditionRoot
	| presenter inspector |
	presenter := FeTextPresenter show.
	inspector := presenter inspectEditionRoot.
	self should: [presenter view topShell destroy].
	self should: [inspector view destroy].!

testLinkClipboard
	| work presenter selection |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.
	presenter view selectFrom: 3 extent: 4.
	selection := presenter copySelection.
	presenter linkClipboard: FeIds linkTitleEndorsement.
	self should: [presenter model title = '3456'].
	self shouldnt: [presenter view hasSelection].
	self should: [presenter view point = 6].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view topShell destroy]!

testLinkTypes
	| work presenter linkTypes|
	work := self createWorkEmpty.
	presenter := self createTextPresenterOn: work.

	linkTypes := presenter linkTypes.
	self should: [linkTypes notEmpty].
	#todo "more".

	self should: [presenter view topShell destroy].!

testPasteClipboard
	| work presenter pasted |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	Clipboard current close.
	Clipboard current setText: 'abcd'.
	presenter view movePointTo: 3.
	pasted := presenter pasteClipboard.
	self should: [pasted = 'abcd'].
	self should: [presenter model textEdition contents = '12abcd34567890'].
	self should: [presenter view point = 7].
	self should: [presenter view topShell destroy]!

testPasteClipboardEmpty
	| work presenter pasted |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	Clipboard current setText: ''.
	pasted := presenter pasteClipboard.
	self should: [pasted = ''].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view point = 1].
	self should: [presenter view topShell destroy]!

testQueryCommandClearCompareAgainstEdition
	| work presenter query |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	query := CommandQuery commandDescription: (CommandDescription command: #clearCompareAgainstEdition) source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	
	presenter setCompareAgainstEdition: BeEdition new.

	query := CommandQuery commandDescription: (CommandDescription command: #clearCompareAgainstEdition) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].

	self should: [presenter view topShell destroy]!

testQueryCommandCopySelection
	| work presenter query |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	query := CommandQuery commandDescription: (CommandDescription command: #copySelection) source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	
	presenter view selectFrom: 3 extent: 4.

	query := CommandQuery commandDescription: (CommandDescription command: #copySelection) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].

	self should: [presenter view topShell destroy]!

testQueryCommandCutSelection
	| work presenter query |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	query := CommandQuery commandDescription: (CommandDescription command: #cutSelection) source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	
	presenter view selectFrom: 3 extent: 4.

	query := CommandQuery commandDescription: (CommandDescription command: #cutSelection) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].

	self should: [presenter view topShell destroy]!

testQueryCommandDeleteSelection
	| work presenter query |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	query := CommandQuery commandDescription: (CommandDescription command: #deleteSelection) source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	
	presenter view selectFrom: 3 extent: 4.

	query := CommandQuery commandDescription: (CommandDescription command: #deleteSelection) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].

	self should: [presenter view topShell destroy]!

testQueryCommandToggleShowNonNativeLinks
	| work presenter query |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	self shouldnt: [presenter showNonNativeLinks].

	query := CommandQuery commandDescription: (CommandDescription command: #toggleShowNonNativeLinks) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self shouldnt: [query isChecked].
	
	presenter toggleShowNonNativeLinks.

	query := CommandQuery commandDescription: (CommandDescription command: #toggleShowNonNativeLinks) source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self should: [query isChecked].

	self should: [presenter view topShell destroy]!

testRemoveLink
	| work presenter selection link |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	presenter view selectFrom: 3 extent: 4.
	selection := presenter copySelection.
	presenter linkClipboard: FeIds linkTitleEndorsement.
	self should: [presenter model title = '3456'].
	link := presenter removeLink.
	self should: [presenter model title = '<Unknown>'].
	self shouldnt: [presenter view hasSelection].
	self should: [presenter view point = 6].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view topShell destroy]!

testRemoveLinkNone
	| work presenter link |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	link := presenter removeLink.
	self should: [link isNil].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter view topShell destroy]!

testTranscludeClipboard
	| work presenter selection presenter2 |
	work := self createWorkWith1234567890.
	presenter := self createTextPresenterOn: work.

	presenter view selectFrom: 3 extent: 4.
	selection := presenter copySelection.
	presenter2 := self createTextPresenterEmpty.
	presenter2 transcludeClipboard.
	self should: [presenter2 model textEdition contents = '3456'].
	self shouldnt: [presenter2 view hasSelection].
	self should: [presenter2 view point = 1].
	self should: [presenter model textEdition contents = '1234567890'].
	self should: [presenter2 view topShell destroy].
	self should: [presenter view topShell destroy]!

text1234567890
	^'1234567890'!

text1234567890WithBreaks
	^'123', String lineDelimiter, '4', String lineDelimiter, '567', String lineDelimiter, String lineDelimiter, '890'! !
!FeTextPresenterTest categoriesFor: #createTextPresenterEmpty!private! !
!FeTextPresenterTest categoriesFor: #createTextPresenterOn:!private! !
!FeTextPresenterTest categoriesFor: #createTextPresenterWith:!private! !
!FeTextPresenterTest categoriesFor: #createTextPresenterWith1234567890!private! !
!FeTextPresenterTest categoriesFor: #createTextPresenterWith1234567890WithBreaks!private! !
!FeTextPresenterTest categoriesFor: #createWorkEmpty!private! !
!FeTextPresenterTest categoriesFor: #createWorkWith:!private! !
!FeTextPresenterTest categoriesFor: #createWorkWith1234567890!private! !
!FeTextPresenterTest categoriesFor: #createWorkWith1234567890WithBreaks!private! !
!FeTextPresenterTest categoriesFor: #testCopySelection!public! !
!FeTextPresenterTest categoriesFor: #testCopySelectionEmpty!public! !
!FeTextPresenterTest categoriesFor: #testCreate!public! !
!FeTextPresenterTest categoriesFor: #testCreateWithContents!public! !
!FeTextPresenterTest categoriesFor: #testCutSelection!public! !
!FeTextPresenterTest categoriesFor: #testCutSelectionEmpty!public! !
!FeTextPresenterTest categoriesFor: #testDeleteSelection!public! !
!FeTextPresenterTest categoriesFor: #testDeleteSelectionEmpty!public! !
!FeTextPresenterTest categoriesFor: #testExportAsFile!public! !
!FeTextPresenterTest categoriesFor: #testExportAsFileEmpty!public! !
!FeTextPresenterTest categoriesFor: #testFlushChanges!public! !
!FeTextPresenterTest categoriesFor: #testInsertFile!public! !
!FeTextPresenterTest categoriesFor: #testInsertFileAtStart!public! !
!FeTextPresenterTest categoriesFor: #testInspectEditionRoot!public! !
!FeTextPresenterTest categoriesFor: #testLinkClipboard!public! !
!FeTextPresenterTest categoriesFor: #testLinkTypes!public! !
!FeTextPresenterTest categoriesFor: #testPasteClipboard!public! !
!FeTextPresenterTest categoriesFor: #testPasteClipboardEmpty!public! !
!FeTextPresenterTest categoriesFor: #testQueryCommandClearCompareAgainstEdition!public! !
!FeTextPresenterTest categoriesFor: #testQueryCommandCopySelection!public! !
!FeTextPresenterTest categoriesFor: #testQueryCommandCutSelection!public! !
!FeTextPresenterTest categoriesFor: #testQueryCommandDeleteSelection!public! !
!FeTextPresenterTest categoriesFor: #testQueryCommandToggleShowNonNativeLinks!public! !
!FeTextPresenterTest categoriesFor: #testRemoveLink!public! !
!FeTextPresenterTest categoriesFor: #testRemoveLinkNone!public! !
!FeTextPresenterTest categoriesFor: #testTranscludeClipboard!public! !
!FeTextPresenterTest categoriesFor: #text1234567890!private! !
!FeTextPresenterTest categoriesFor: #text1234567890WithBreaks!private! !

