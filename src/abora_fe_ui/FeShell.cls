"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Shell subclass: #FeShell
	instanceVariableNames: 'textPresenter worksPresenter revisionsPresenter text2Presenter linksPresenter textModelsCache history transpointingPresenter saveOnClose cardsPresenter'
	classVariableNames: 'LazyListModel'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeShell guid: (GUID fromString: '{9F4F391F-7EB2-4CF2-87D2-6758EBAE873E}')!
FeShell comment: 'A FeShell provides a simple text view onto an Edition and a list of Works and their editions for
navigating the contents of the global WorksStorage.

To open the shell:
	FeShell show'!
!FeShell categoriesForClass!MVP-Presenters! !
!FeShell methodsFor!

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

additionalAccelerators
	"Private - Answer a collection of additional accelerator definitions for commands not on the menu bar of the receiver's view(s).
	Each element of the collection should be a two element <Array>, the first element of which is the command symbol
	and the second the accelerator key string."

	^#(#(#historyBack 'Alt+Left') #(#historyForward 'Alt+Right') #(#revisionBack 'Alt+Up') #(#revisionForward 'Alt+Down'))!

addToCommandRoute: route
	"Private - Update the <OrderedCollection>, path, with the receiver's contribution to the command path
	held by the <CommandPolicy>, route. Answer self to have the command policy decide where
	to go next."

	route 
		appendTarget: self;
		appendTarget: textPresenter;
		appendPresenter: self.!

buildHistoryFutureMenu
	"Private - Answer a dynamically created future visit menu."

	^(self buildHistoryMenu: history upToEnd command: #historyForward:)
		text: 'Forward';
		yourself!

buildHistoryMenu: visits command: cmdSelector
	"Private - Answer a dynamically created past visit history menu."

	| popup titles processedTextModels |
	popup := Menu new.
	titles := LookupTable new.
	processedTextModels := IdentitySet new.
	visits keysAndValuesDo: 
			[:i :textModel | 
			| menu title description |
			(processedTextModels includes: textModel) 
				ifFalse: 
					[title := textModel title.
					menu := titles at: title ifAbsentPut: [popup addSubmenu: title].
					description := textModel work revision displayString , ' - ' 
								, textModel work revisionTime displayString.
					menu addCommand: (Message selector: cmdSelector argument: i) description: description.
					menu setDefault: 1.
					processedTextModels add: textModel]].
	popup setDefault: 1.
	^popup!

buildHistoryPastMenu
	"Private - Answer a dynamically created past visit history menu."

	^(self buildHistoryMenu: history past command: #historyBack:)
		text: 'Past';
		yourself
!

chooseTextModel: unorderedTextModels caption: choiceCaption
	| textModels chosenTextModel |
	textModels := unorderedTextModels asSortedCollection: [:a :b | a title <= b title].
	chosenTextModel := ChoicePrompter choices: textModels caption: choiceCaption.
	chosenTextModel notNil ifTrue: [self selectTextModel: chosenTextModel]!

createComponents
	"Private - Create the presenters contained by the receiver"

	super createComponents.
	textPresenter := self add: (FeTextPresenter on: DeafObject current) name: 'text'.
	text2Presenter := self add: (FeTextPresenter on: DeafObject current)  name: 'text2'.
	worksPresenter := self add: ListPresenter new name: 'works'.
	revisionsPresenter := self add: ListPresenter new name: 'revisions'.
	linksPresenter := self add: ListPresenter new name: 'links'.
	transpointingPresenter := self add: FeTranspointingPresenter new name: 'transpointing'.
	cardsPresenter := self add: Presenter new name: 'cards'.
!

createSchematicWiring
	"Private - Create the trigger wiring for the receiver"

	| toolbar |
	super createSchematicWiring.
	self 
		when: #closeRequested:
		send: #onCloseRequested:
		to: self.
	worksPresenter 
		when: #selectionChanged
		send: #onWorkSelected
		to: self.
	worksPresenter 
		when: #selectionChanging:
		send: #onSelectionChanging:
		to: self.
	revisionsPresenter 
		when: #selectionChanged
		send: #onRevisionSelected
		to: self.
	revisionsPresenter 
		when: #selectionChanging:
		send: #onSelectionChanging:
		to: self.

	textPresenter 
		when: #compareAgainstEdition
		send: #onCompareAgainstEdition
		to: self.
	textPresenter when: #navigateToWorks: sendTo: self.
	textPresenter when: #pointMovedTo: send: #onTextPointMovedTo: to: self.

	toolbar := self view viewNamed: 'feTools'.
	toolbar presenterConnectionPoint 
		when: #dropDown:
		send: #onDropDown:
		to: self.

	#todo "move card stuf off into separate/more flexible plugin classes".
	cardsPresenter view when:  #currentCardChanged send: #onCardChanged to: self.
!

dgjHomePage
	AboraSystem current showDgjPage.!

findEditionWithTextEndorsement: work
	| edition |
	edition := work edition.
	^(edition endorsements includes: SystemIds textEditionEndorsement) 
		ifTrue: [edition]
		ifFalse: 
			[edition contents 
				detect: [:childEdition | childEdition isInteger not and: [childEdition endorsements includes: SystemIds textEditionEndorsement]] ifNone: [nil]]!

historyBack
	"Private - Return to the previously visited method."

	self historyBack: 1
!

historyBack: delta
	"Private - Return to a previously visited method <integer>, delta, visits
	in the past.."

	self historySkip: delta negated
!

historyForward
	"Return to the previously visited class which has been
	moved back over by a jump back in time."

	self historySkip: 1
!

historyForward: delta
	"Private - Return to the previously visited class which has been
	moved back over by a jump back in time."

	self historySkip: delta
!

historySkip: anInteger
	"Private - Move around in the history list by the specified <integer> delta (negative for
	backwards)."

	| textModel |
"	self promptToSaveChanges ifFalse: [^self]."
	history skip: anInteger.
	textModel := history current.
	#todo.
	self selectTextModel: textModel.!

initialize
	super initialize.
	textModelsCache := FeTextModelCache new.
	history := HistoryList new.
	saveOnClose := false.
		!

inspectAllTextEditions
	| roots |
	roots := revisionsPresenter model collect: [:textModel | textModel edition beEdition root].
	^EntInspectorShell showOn: (VirtualTreeModel new setRoots: roots)!

inspectAllWorkEditions
	^self selectedWork work beWork inspectAllRoots!

inspectWorkEdition
	#todo.
	^self selectedRevision topEdition beEdition root inspectNodes
!

isCurrentCardLinks
	| currentCard |
	currentCard := cardsPresenter view currentCard.
	^linksPresenter view allParents includes: currentCard!

listTransclusions
	"use selected text"

	| region transclusions works textModels |
	#todo.
	works := Set new.
	region := textPresenter view hasSelection 
				ifTrue: [textPresenter view selectionRegion]
				ifFalse: [IntegerRegion startPosition: 1 extent: textPresenter model textEdition count].
	transclusions := textPresenter model edition 
				transclusionsFrom: region startPosition
				extent: region extent
				filteredBy: (Array with: SystemIds textEditionEndorsement).
	transclusions do: 
			[:edition | 
			works addAll: edition works.
			edition transclusionsDirect do: [:directEdition | works addAll: directEdition works]].
	#todo.	"option in dialog to include frozen works or not"
	works := works reject: [:work | work isFrozen].
	works isEmpty 
		ifTrue: 
			[^MessageBox notify: 'No other works transclude the same contents'
				caption: 'Transcluding works'].
	textModels := works collect: [:work | self textModelForWork: work].
	self chooseTextModel: textModels caption:  'Transcluding works'.
!

model: userHomeFeWork
	"Set the model associated with the receiver."

	| textModels |
	super model: userHomeFeWork.
	textModels := self worksList collect: [:feWork | self textModelForWork: feWork].
	worksPresenter model: (ListModel on: textModels).
	revisionsPresenter model: (ListModel on: Array new).
	linksPresenter model: LazyListModel.
	self updateCaption!

navigateToWorks: works
	| textEditions |
	works isEmpty ifTrue: [^self].
	textEditions := (works collect: [:work | self textModelForWork: work]) asArray.
	textEditions size = 1 ifTrue: [^self selectTextModel: textEditions first].
	self chooseTextModel: textEditions caption: 'Jump to Work...'.!

newEmptyWork
	| textEdition |
	textEdition := FeTextEdition empty.
	^self newWorkFor: textEdition edition!

newWorkFor: textEdition
	| work topEdition textModel  |
	textEdition endorse: SystemIds textEditionEndorsement.
	topEdition := FeEdition contents: textEdition.
	work := FeWork edition: topEdition.
	#todo.
	self model revise: (self model edition append: work).
"	self worksStorage addWork: work beWork."
	textModel := self textModelForWork: work.
	worksPresenter model add: textModel.
	worksPresenter selection: textModel.
	^textModel!

newWorkFromEdition
	| beEdition feEdition |
	#todo. 
	beEdition := FeServer current createEditionFromEdition: textPresenter model edition beEdition.
	feEdition := FeEdition on: beEdition.
	^self newWorkFor: feEdition
!

newWorkFromFile
	| filename |
	filename := textPresenter chooseFileToOpen.
	filename isNil ifTrue: [^nil].
	^self newWorkFromFile: filename!

newWorkFromFile: filename
	| edition contents |
	contents := textPresenter readFileContents: filename.
	edition := FeTextEdition contents: contents.
	^self newWorkFor: edition edition!

onCardChanged
	self updateLinksListIfRequired.!

onCloseRequested: aValueHolder
	saveOnClose ifTrue: [Cursor wait showWhile: [self saveWorksStorage]].
	aValueHolder value: true!

onCompareAgainstEdition
	| textModel |
	textModel := textPresenter compareAgainstEdition notNil 
				ifTrue: 
					[transpointingPresenter transpoint: textPresenter and: text2Presenter.
					FeTextModel work: textPresenter model work]
				ifFalse: 
					[| emptyWork |
					transpointingPresenter clearTranspoint.
					FeTextModel empty].
	text2Presenter compareAgainstEdition: textPresenter model edition.
	text2Presenter model: textModel!

onDropDown: tool
	"Private - The receiver's toolbar has sent a notification that one of
	the forward/back buttons' drop-down arrow has been pressed. 
	Generate and pop-up the past/future history menus, as appropriate."

	| popup |
	popup := tool command asSymbol == #historyBack
		ifTrue: [self buildHistoryPastMenu]
		ifFalse: [self buildHistoryFutureMenu].
	popup showIn: view position: tool screenRectangle bottomLeft.
	^0!

onRevisionSelected
	| revision |
	revision := self selectedRevision.
	revision notNil ifTrue: [self setTextModel: revision] ifFalse: [textPresenter model: nil]!

onSelectionChanging: aSelectionChangingEvent
	aSelectionChangingEvent newSelections isEmpty 
		ifTrue: [aSelectionChangingEvent value: false]!

onTextPointMovedTo: position
	#todo.
	(FeAboraSystem current preferences comparisonFollowsPoint 
		and: [textPresenter compareAgainstEdition notNil]) 
			ifTrue: [text2Presenter view comparisonPointMovedTo: position]!

onTipTextRequired: tool
	"Tool tip text is required for the <ToolbarItem>, tool."

	| cmd |
	cmd := tool command asSymbol.
	(cmd == #historyBack and: [history hasPast]) 
		ifTrue: [^'Back to ' , history previous title].
	(cmd == #historyForward and: [history hasFuture]) 
		ifTrue: [^'Forward to ' , history next title].
	^super onTipTextRequired: tool
!

onViewOpened
	super onViewOpened.
	text2Presenter view isReadOnly: true.
	text2Presenter showNonNativeLinks: true.
	worksPresenter model notEmpty 
		ifTrue: 
			[worksPresenter selection: worksPresenter model first.
			textPresenter view setFocus].
!

onWorkRevised
	| work |
	work := self selectedWork.
	work work revisions contents do: 
			[:revision | 
			| textModel |
			textModel := self textModelForWork: revision.
			(revisionsPresenter model includes: textModel) 
				ifFalse: [revisionsPresenter model add: textModel beforeIndex: revisionsPresenter model size]].
	self updateCaption.
	self updateBaseComparison.
	self updateLinksList.
	worksPresenter model updateItem: work.
	revisionsPresenter model updateItem: work.
	revisionsPresenter ensureSelectionVisible.!

onWorkSelected
	| work |
	work := self selectedWork.
	self updateRevisionsList: work.
	self selectTextModel: work.!

queryCommand: aCommandQuery
	"Private - Enters details about a potential command for the receiver into aCommandQuery"

	| selector |
	selector := aCommandQuery commandSymbol.
	#historyBack: == selector 
		ifTrue: 
			[| dist |
			dist := aCommandQuery command arguments first.
			aCommandQuery isEnabled: history pastSize >= dist.
			^true].
	#historyForward: == selector 
		ifTrue: 
			[| dist |
			dist := aCommandQuery command arguments first.
			aCommandQuery isEnabled: history futureSize >= dist.
			^true].
	selector == #historyForward 
		ifTrue: 
			[history hasFuture 
				ifTrue: 
					[aCommandQuery
						isEnabled: true;
						text: (aCommandQuery commandDescription menuText formatWith: history next title)]
				ifFalse: 
					[aCommandQuery
						isEnabled: false;
						text: 'Forward'].
			^true].
	selector == #historyBack 
		ifTrue: 
			[history hasPast 
				ifTrue: 
					[aCommandQuery
						isEnabled: true;
						text: (aCommandQuery commandDescription menuText formatWith: history previous title)]
				ifFalse: 
					[aCommandQuery
						isEnabled: false;
						text: 'Back'].
			^true].
	#toggleComparisonFollowsPoint == selector 
		ifTrue: [aCommandQuery isChecked: FeAboraSystem current preferences comparisonFollowsPoint].
	#revisionBack == selector 
		ifTrue: 
			[aCommandQuery isEnabled: (revisionsPresenter model indexOf: self selectedRevision) > 1.
			^true].
	#revisionForward == selector 
		ifTrue: 
			[| index |
			index := revisionsPresenter model indexOf: self selectedRevision.
			aCommandQuery isEnabled: (index ~= 0 and: [index < revisionsPresenter model size]).
			^true].
	^super queryCommand: aCommandQuery


	"	aCommandQuery command == #newWorkFromEdition 
		ifTrue: [aCommandQuery isEnabled: self selectedRevision notNil]"

	"	(#(editTransaction removeTransaction) includes: aCommandQuery command) ifTrue: [
		aCommandQuery isEnabled: self hasSelectedTransaction ]
"!

revisionBack
	^self revisionSkip: -1!

revisionForward
	^self revisionSkip: 1!

revisionSkip: anInteger
	| index newIndex newRevision |
	index := revisionsPresenter model indexOf: self selectedRevision.
	index = 0 ifTrue: [^nil].
	newIndex := index + anInteger.
	newIndex := (newIndex max: 1) min: revisionsPresenter model size.
	newIndex = index ifTrue: [^nil].
	newRevision := revisionsPresenter model at: newIndex.
	^self selectTextModel: newRevision
	!

saveOnClose
	^saveOnClose!

saveOnClose: anObject
	saveOnClose := anObject!

saveWorksStorage
	textPresenter flushChanges.
	"WorksStorageDumper new dumpWorksStorage."!

selectedRevision
	^revisionsPresenter selectionOrNil!

selectedWork
	^worksPresenter selectionOrNil!

selectTextModel: textModel
	worksPresenter model do: 
			[:document | 
			(document = textModel or: [document work revisions contents includes: textModel work]) 
				ifTrue: 
					[#todo.
					worksPresenter noEventsDo: [worksPresenter selection: document].
					worksPresenter ensureSelectionVisible.
					self updateRevisionsList: document.
					revisionsPresenter selection: textModel.
					revisionsPresenter ensureSelectionVisible.
					^self]].
	Sound bell!

setTextModel: textModel
	textPresenter model notNil ifTrue: [textPresenter model removeEventsTriggeredFor: self].
	textPresenter model: textModel.
	self updateCaption.
	textModel 
		when: #workRevised
		send: #onWorkRevised
		to: self.
	self updateBaseComparison.
	self updateLinksList.
	history visit: textModel!

textModelForWork: feWork
	| textModel |
	textModel := textModelsCache textModelForWork: feWork ifAbsent: [nil].
	textModel notNil ifTrue: [^textModel].
	textModel := FeTextModel work: feWork.
	textModelsCache addTextModel: textModel.
	^textModel!

toggleComparisonFollowsPoint
	FeAboraSystem current preferences 
		comparisonFollowsPoint: FeAboraSystem current preferences comparisonFollowsPoint not!

updateBaseComparison
	textPresenter compareAgainstEdition notNil 
		ifTrue: 
			[text2Presenter compareAgainstEdition: textPresenter model edition.
			transpointingPresenter transpoint: textPresenter and: text2Presenter]
		ifFalse: 
			[text2Presenter compareAgainstEdition: nil.
			transpointingPresenter clearTranspoint].
	(text2Presenter view)
		clearCachedFontLock;
		refreshContents!

updateCaption
	"The receiver has changed in such a way that the caption may need to be refreshed.
	Overidden in subclasses that need to provide a dynamic caption that changes
	according to the state of the receiver"

	| work |
	work := textPresenter model work.
	self caption: 'Abora: ' , textPresenter model title 
				, (work notNil ifTrue: [' (rev=' , work revision displayString , ')'] ifFalse: [''])!

updateLinksList
	| edition transclusions list |
	self isCurrentCardLinks ifFalse: [linksPresenter model: LazyListModel. ^self].

	edition := textPresenter model edition.
	transclusions := edition 
				transclusionsFilteredBy: (Array with: SystemIds singleRefEndorsement).
	list := transclusions collect: 
					[:ref | 
					| types typeSummary isNative |
					#todo.
					types := ref endorsements 
								select: [:endorsement | endorsement endorseeId = FeIds linksClub].
					typeSummary := WriteStream on: String new.
					types do: 
							[:endorsement | 
							#todo.
							typeSummary 
								nextPutAll: (FeServer current lookupId: endorsement itemId) edition contents asAboraText]
						separatedBy: [typeSummary nextPutAll: ', '].
					isNative := textPresenter model isSingleRefEditionNative: ref.
					Array with: typeSummary contents with: ref contents asAboraText with: isNative].
	linksPresenter model: (ListModel on: (list asSortedCollection: [:a :b | a first < b first or: [a first = b first and: [a second <= b second]]])).
!

updateLinksListIfRequired
	(self isCurrentCardLinks and: [linksPresenter model == LazyListModel]) ifTrue: [
		self updateLinksList].!

updateRevisionsList: document
	| revisions |
	revisions := document notNil ifTrue: [document work revisions contents] ifFalse: [#()].
	revisions := revisions asOrderedCollection collect: [:revision | self textModelForWork: revision].
	revisionsPresenter model: (ListModel on: (revisions copyWith: document))!

worksList
	"^FeServer current "
	^self model edition contents
"	^(self model works select: [:work | (work isMemberOf: BeWork) and: [(self findEditionWithTextEndorsement: work) notNil]]) collect: [:beWork | FeProxy forId: beWork id class: beWork class]"!

worksStorage
	^self model!

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
	summary cr; cr; nextPutAll: 'Instances:'.
	classes := #(#BeWork #BeEdition #BeClub #BeCollectionHolder #BeDataHolder #RootNode #SplitNode #CollectionLeaf #ContentLeaf #IntegerRegion).
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
!FeShell categoriesFor: #aboraHomePage!public! !
!FeShell categoriesFor: #about!public! !
!FeShell categoriesFor: #additionalAccelerators!private! !
!FeShell categoriesFor: #addToCommandRoute:!private! !
!FeShell categoriesFor: #buildHistoryFutureMenu!private! !
!FeShell categoriesFor: #buildHistoryMenu:command:!private! !
!FeShell categoriesFor: #buildHistoryPastMenu!private! !
!FeShell categoriesFor: #chooseTextModel:caption:!private! !
!FeShell categoriesFor: #createComponents!private! !
!FeShell categoriesFor: #createSchematicWiring!private! !
!FeShell categoriesFor: #dgjHomePage!public! !
!FeShell categoriesFor: #findEditionWithTextEndorsement:!private! !
!FeShell categoriesFor: #historyBack!public! !
!FeShell categoriesFor: #historyBack:!private! !
!FeShell categoriesFor: #historyForward!public! !
!FeShell categoriesFor: #historyForward:!private! !
!FeShell categoriesFor: #historySkip:!private! !
!FeShell categoriesFor: #initialize!private! !
!FeShell categoriesFor: #inspectAllTextEditions!public! !
!FeShell categoriesFor: #inspectAllWorkEditions!public! !
!FeShell categoriesFor: #inspectWorkEdition!public! !
!FeShell categoriesFor: #isCurrentCardLinks!private! !
!FeShell categoriesFor: #listTransclusions!public! !
!FeShell categoriesFor: #model:!public! !
!FeShell categoriesFor: #navigateToWorks:!public! !
!FeShell categoriesFor: #newEmptyWork!public! !
!FeShell categoriesFor: #newWorkFor:!private! !
!FeShell categoriesFor: #newWorkFromEdition!public! !
!FeShell categoriesFor: #newWorkFromFile!public! !
!FeShell categoriesFor: #newWorkFromFile:!private! !
!FeShell categoriesFor: #onCardChanged!private! !
!FeShell categoriesFor: #onCloseRequested:!private! !
!FeShell categoriesFor: #onCompareAgainstEdition!private! !
!FeShell categoriesFor: #onDropDown:!private! !
!FeShell categoriesFor: #onRevisionSelected!private! !
!FeShell categoriesFor: #onSelectionChanging:!private! !
!FeShell categoriesFor: #onTextPointMovedTo:!private! !
!FeShell categoriesFor: #onTipTextRequired:!private! !
!FeShell categoriesFor: #onViewOpened!private! !
!FeShell categoriesFor: #onWorkRevised!private! !
!FeShell categoriesFor: #onWorkSelected!private! !
!FeShell categoriesFor: #queryCommand:!private! !
!FeShell categoriesFor: #revisionBack!public! !
!FeShell categoriesFor: #revisionForward!public! !
!FeShell categoriesFor: #revisionSkip:!private! !
!FeShell categoriesFor: #saveOnClose!accessing!private! !
!FeShell categoriesFor: #saveOnClose:!accessing!private! !
!FeShell categoriesFor: #saveWorksStorage!public! !
!FeShell categoriesFor: #selectedRevision!public! !
!FeShell categoriesFor: #selectedWork!public! !
!FeShell categoriesFor: #selectTextModel:!public! !
!FeShell categoriesFor: #setTextModel:!private! !
!FeShell categoriesFor: #textModelForWork:!private! !
!FeShell categoriesFor: #toggleComparisonFollowsPoint!public! !
!FeShell categoriesFor: #updateBaseComparison!public! !
!FeShell categoriesFor: #updateCaption!public! !
!FeShell categoriesFor: #updateLinksList!private! !
!FeShell categoriesFor: #updateLinksListIfRequired!private! !
!FeShell categoriesFor: #updateRevisionsList:!public! !
!FeShell categoriesFor: #worksList!private! !
!FeShell categoriesFor: #worksStorage!public! !
!FeShell categoriesFor: #worksStorageSummary!public! !

!FeShell class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^FeServer current userHome!

initialize
"
self initialize.
"
	LazyListModel := ListModel new.! !
!FeShell class categoriesFor: #defaultModel!public! !
!FeShell class categoriesFor: #initialize!public! !

