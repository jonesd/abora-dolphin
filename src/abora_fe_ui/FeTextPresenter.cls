"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Presenter subclass: #FeTextPresenter
	instanceVariableNames: 'compareAgainstEdition showNonNativeLinks'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextPresenter guid: (GUID fromString: '{8ED8EDCE-C348-4221-9969-FE00CBCFB474}')!
FeTextPresenter comment: ''!
!FeTextPresenter categoriesForClass!MVP-Presenters! !
!FeTextPresenter methodsFor!

basicCopySelection
	| selection |
	selection := self view selectionAsReference.
	selection isNil ifTrue: [^nil].
	Clipboard current open.
	
	[Clipboard current setObject: selection.
	Clipboard current setText: self view selectionAsText] 
			ensure: [Clipboard current close].
	^selection!

chooseFileToOpen
	| openFilename |
	openFilename := (FileOpenDialog new)
				fileTypes: (Array with: self textFileType with: FileDialog allFilesType);
				defaultExtension: self textFileType last;
				showModal.
	^openFilename!

chooseFont
	"Pop the font dialog to allow selection of font for the text in the receiver.
	Note how we easily we can modify the font simply by opening FontDialog on the
	font aspect of the view."

	FontDialog showModalOn: (self view aspectValue: #font)!

chooseLinkType
	| linkTypes linkName |
	linkTypes := self linkTypes.

	linkName := ChoicePrompter choices: linkTypes keys asSortedCollection caption: 'Link Type'.
	^linkTypes at: linkName ifAbsent: [nil]!

clearCompareAgainstEdition
	self setCompareAgainstEdition: nil.!

compareAgainstEdition
	^compareAgainstEdition!

compareAgainstEdition: anObject
	compareAgainstEdition := anObject!

copySelection
	| selection |
	selection := self basicCopySelection.
	self view clearSelection.
	^selection!

cutSelection
	| selection |
	selection := self basicCopySelection.
	selection notNil ifTrue: [self view deleteSelection].
	^selection!

deleteSelection
	self view deleteSelection.!

exportAsFile
	"Save the contents as plain text to an external file of the users choice."

	| newFilename dialog |
	dialog := (FileSaveDialog on: self textFileType last asValue)
				fileTypes: (Array with: self textFileType with: FileDialog allFilesType);
				caption: 'Save Contents As';
				yourself.
	newFilename := dialog showModal.
	newFilename notNil ifTrue: [self exportAsFile: newFilename]!

exportAsFile: filename
	| file |
	file := File 
				open: filename
				mode: #open
				check: false.
	
	[Cursor wait showWhile: 
			[| contents |
			contents := self model textEdition contents.
			file write: contents]] 
			ensure: [file close]!

flushChanges
	self model textEdition flushChanges!

followLink
	self view followLinkAt: self view point.!

initialize
	super initialize.

	showNonNativeLinks := false.!

insertFile
	| filename |
	filename := self chooseFileToOpen.
	filename notNil ifTrue: [self insertFile: filename]!

insertFile: filename
	| contents |
	contents := self readFileContents: filename.
	self view insertText: contents.
	self flushChanges!

inspectEditionRoot
	#todo "move to server side ui".
	^self model edition beEdition root inspectNodes!

isClippedItemAvailable
	^Clipboard current isObjectAvailable
!

linkClipboard
	| linkType |
	linkType := self chooseLinkType.
	linkType isNil ifTrue: [^self].
	^self linkClipboard: linkType!

linkClipboard: linkType
	| clipped clippedEdition clippedSingleRef hyperLink refs |
	clipped := Clipboard current getObjectIfNone: [^self].
	self flushChanges.
	#todo.	"mess"
	clippedEdition := FeIdLookup current lookupId: clipped id "WorksStorage current lookupId: clipped id".
	clippedSingleRef := FeSingleRef 
				createOn: clippedEdition
				from: clipped position
				extent: clipped extent.
	refs := OrderedCollection with: clippedSingleRef.
	self view hasSelection 
		ifTrue: 
			[| selectionSingleRef |
			selectionSingleRef := FeSingleRef createOn: self model edition
						from: self view selectionRegion startPosition extent: self view selectionRegion extent.
			refs add: selectionSingleRef].
	hyperLink := FeHyperLink createWithAll: refs asArray linkType: linkType.
	#todo.
	self model addHyperLink: hyperLink.
	self view clearCachedLinks; refreshContents.
	!

linkTypes
	| linkTypes |
	#todo.
	linkTypes := LookupTable new.
	linkTypes at:  'Author' put: FeIds linkAuthorEndorsement.
	linkTypes at:  'Comment' put: FeIds linkCommentEndorsement.
	linkTypes at: 'Correction' put: FeIds linkCorrectionEndorsement.
	linkTypes at: 'Jump' put: FeIds linkJumpEndorsement.
	linkTypes at: 'Quote' put: FeIds linkQuoteEndorsement.
	linkTypes at: 'Title' put: FeIds linkTitleEndorsement.
	linkTypes at: 'URL' put: FeIds linkUrlEndorsement.
	^linkTypes
!

pasteClipboard
	| text |
	Clipboard current isTextAvailable ifFalse: [^nil].
	text := Clipboard current getText.
	self view insertText: text.
	^text!

queryCommand: aCommandQuery
	"Private - Enters details about a potential command for the receiver into aCommandQuery"

	| command |
	super queryCommand: aCommandQuery.
	command := aCommandQuery command.
	(#(#copySelection #cutSelection #deleteSelection) identityIncludes: command) 
		ifTrue: [aCommandQuery isEnabled: self view hasSelection].
	#transcludeClipboard == command 
		ifTrue: [aCommandQuery isEnabled: self isClippedItemAvailable].
	#linkClipboard == command ifTrue: [aCommandQuery isEnabled: self isClippedItemAvailable].
	#pasteClipboard == command 
		ifTrue: 
			[aCommandQuery 
				isEnabled: (Clipboard current isTextAvailable and: [self isClippedItemAvailable not])].
	#flushChanges == command 
		ifTrue: [aCommandQuery isEnabled: self view textEdition hasPendingChanges].
	#clearCompareAgainstEdition == command 
		ifTrue: [aCommandQuery isEnabled: compareAgainstEdition notNil].
	(#(#followLink #removeLink) identityIncludes: command) 
		ifTrue: [aCommandQuery isEnabled: (self view linkAt: self view point) notNil].
	#toggleShowNonNativeLinks == command 
		ifTrue: [aCommandQuery isChecked: self showNonNativeLinks]!

readFileContents: filename
	| fileStream |
	fileStream := FileStream read: filename.
	[Cursor wait showWhile: [^fileStream contents]] ensure: [fileStream close]!

removeLink
	| hyperRefEdition hyperLink |
	hyperRefEdition := self view linkAt: self view point.
	hyperRefEdition isNil ifTrue: [^nil].

	hyperLink := (FeSingleRef on: hyperRefEdition) hyperLink.
	(hyperLink homeEditions includes: self model work edition) ifFalse: [Sound bell. ^nil].

	self model removeHyperLink: hyperLink.!

setCompareAgainstEdition
	self setCompareAgainstEdition: self model edition!

setCompareAgainstEdition: edition
	compareAgainstEdition := edition.
	self view clearCachedFontLock; refreshContents.
	self trigger: #compareAgainstEdition.!

showNonNativeLinks
	^showNonNativeLinks!

showNonNativeLinks: anObject
	showNonNativeLinks := anObject!

textFileType
	^#('Text (*.txt)' '*.txt')!

toggleShowNonNativeLinks
	self showNonNativeLinks: self showNonNativeLinks not.
	self view clearCachedLinks; refreshContents.!

transcludeClipboard
	| clipped clippedEdition |
	clipped := Clipboard current getObjectIfNone: [^self].
	#todo "mess".
	self deleteSelection.
	clippedEdition := FeIdLookup current lookupId: clipped id "WorksStorage current lookupId: clipped id".
	self flushChanges.
	self model textEdition transcludeEdition: clippedEdition from: clipped position extent: clipped extent to: self view point.! !
!FeTextPresenter categoriesFor: #basicCopySelection!private! !
!FeTextPresenter categoriesFor: #chooseFileToOpen!private! !
!FeTextPresenter categoriesFor: #chooseFont!public! !
!FeTextPresenter categoriesFor: #chooseLinkType!public! !
!FeTextPresenter categoriesFor: #clearCompareAgainstEdition!public! !
!FeTextPresenter categoriesFor: #compareAgainstEdition!accessing!private! !
!FeTextPresenter categoriesFor: #compareAgainstEdition:!accessing!private! !
!FeTextPresenter categoriesFor: #copySelection!public! !
!FeTextPresenter categoriesFor: #cutSelection!public! !
!FeTextPresenter categoriesFor: #deleteSelection!public! !
!FeTextPresenter categoriesFor: #exportAsFile!public! !
!FeTextPresenter categoriesFor: #exportAsFile:!private! !
!FeTextPresenter categoriesFor: #flushChanges!public! !
!FeTextPresenter categoriesFor: #followLink!public! !
!FeTextPresenter categoriesFor: #initialize!private! !
!FeTextPresenter categoriesFor: #insertFile!public! !
!FeTextPresenter categoriesFor: #insertFile:!private! !
!FeTextPresenter categoriesFor: #inspectEditionRoot!public! !
!FeTextPresenter categoriesFor: #isClippedItemAvailable!private! !
!FeTextPresenter categoriesFor: #linkClipboard!public! !
!FeTextPresenter categoriesFor: #linkClipboard:!private! !
!FeTextPresenter categoriesFor: #linkTypes!private! !
!FeTextPresenter categoriesFor: #pasteClipboard!public! !
!FeTextPresenter categoriesFor: #queryCommand:!private! !
!FeTextPresenter categoriesFor: #readFileContents:!private! !
!FeTextPresenter categoriesFor: #removeLink!public! !
!FeTextPresenter categoriesFor: #setCompareAgainstEdition!public! !
!FeTextPresenter categoriesFor: #setCompareAgainstEdition:!private! !
!FeTextPresenter categoriesFor: #showNonNativeLinks!accessing!private! !
!FeTextPresenter categoriesFor: #showNonNativeLinks:!accessing!private! !
!FeTextPresenter categoriesFor: #textFileType!private! !
!FeTextPresenter categoriesFor: #toggleShowNonNativeLinks!accessing!public! !
!FeTextPresenter categoriesFor: #transcludeClipboard!public! !

!FeTextPresenter class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	| edition topEdition work |
	edition := BeEdition new.
	edition endorse: SystemIds textEditionEndorsement.
	topEdition := BeEdition contents: edition.
	work := BeWork edition: topEdition.
	^FeTextModel work: (FeWork on: work).! !
!FeTextPresenter class categoriesFor: #defaultModel!public! !

