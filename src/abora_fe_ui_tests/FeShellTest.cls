"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeUiTests subclass: #FeShellTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeShellTest guid: (GUID fromString: '{DB237DEE-5844-4BF2-8B61-E4AE87831A1A}')!
FeShellTest comment: ''!
!FeShellTest categoriesForClass!SUnit! !
!FeShellTest methodsFor!

testCreate
	| userHome work presenter workProxy |
	userHome := self userHomeWithExample.
	self should: [userHome edition contents size = 1].
	work := userHome edition contents first.
	workProxy := BeContentElementProxy for: work.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	self should: [presenter selectedWork work beWork isIdentical: workProxy].
	self should: [presenter selectedRevision work beWork isIdentical: workProxy].
	self should: [presenter view destroy]!

testCreateEmpty
	| userHome presenter |
	userHome := self userHomeEmpty.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	self should: [presenter view destroy]!

testCreateWithDefaultWorksStorage
	| presenter |
	presenter := FeShell show.
	self should: [presenter view destroy]!

testNewEmptyWork
	| userHome presenter work textModel |
	userHome := self userHomeWithExample.
	self should: [userHome edition contents size = 1].
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	textModel := presenter newEmptyWork.
	work := textModel work.
	self should: [textModel textEdition count = 0].
	self should: [userHome edition contents size = 2].
	self should: [(userHome  edition contents at: 2) id = work beWork id].
	self should: [presenter selectedRevision == textModel].
	self should: [presenter view destroy]!

testNewWorkFromEdition
	| userHome presenter work textModel |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	textModel := presenter newWorkFromEdition.
	work := textModel work.
	self should: [textModel textEdition contents = '1234567890'].
	self should: [userHome edition contents size = 2].
	self should: [(userHome  edition contents at: 2) id = work beWork id].
	self should: [presenter selectedWork == textModel].
	self should: [presenter selectedRevision == textModel].
	self should: [presenter view destroy]!

testNewWorkFromFile
	| userHome presenter work textModel filename |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	filename := File temporaryFilename.
	
	[(FileStream write: filename)
		nextPutAll: 'abcd';
		close.
	textModel := presenter newWorkFromFile: filename.
	work := textModel work.
	self should: [textModel textEdition contents = 'abcd'].
	self should: [userHome edition contents size = 2].
	self should: [(userHome  edition contents at: 2) id = work beWork id].
	self should: [presenter selectedWork == textModel].
	self should: [presenter selectedRevision == textModel].
	self should: [presenter view destroy]] 
			ensure: [File delete: filename]!

testQueryCommandHistoryBack
	| userHome firstTextModel presenter query textEdition |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	firstTextModel := presenter selectedRevision.
	query := CommandQuery 
				commandDescription: (CommandDescription command: #historyBack description: 'Back to %1')
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	self should: [query text = 'Back'].
	textEdition := presenter newEmptyWork.
	query := CommandQuery 
				commandDescription: (CommandDescription command: #historyBack description: 'Back to %1')
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self should: [query text = ('Back to ' , firstTextModel title)].
	self should: [presenter view destroy]!

testQueryCommandHistoryForward
	| userHome firstTextModel presenter query textModel |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	firstTextModel := presenter selectedRevision.
	query := CommandQuery commandDescription: (CommandDescription command: #historyForward
						description: 'Forward to %1')
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	self should: [query text = 'Forward'].
	textModel := presenter newEmptyWork.
	query := CommandQuery commandDescription: (CommandDescription command: #historyForward
						description: 'Forward to %1')
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	self should: [query text = 'Forward'].
	presenter historyBack.
	query := CommandQuery commandDescription: (CommandDescription command: #historyForward
						description: 'Forward to %1')
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self should: [query text = ('Forward to ' , textModel title)].
	self should: [presenter view destroy]!

testQueryCommandRevisionBack
	| userHome firstTextModel presenter query textEdition |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	query := CommandQuery commandDescription: (CommandDescription command: #revisionBack)
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	firstTextModel := presenter selectedRevision.
	(firstTextModel textEdition)
		insert: 'blah' at: 1;
		flushChanges.
	self should: [presenter selectedRevision textEdition contents = 'blah1234567890'].
	query := CommandQuery commandDescription: (CommandDescription command: #revisionBack)
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	presenter revisionBack.
	self should: [presenter selectedRevision textEdition contents = '1234567890'].
	query := CommandQuery commandDescription: (CommandDescription command: #revisionBack)
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	self should: [presenter view destroy]!

testQueryCommandRevisionForward
	| userHome firstTextModel presenter query textEdition |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	query := CommandQuery commandDescription: (CommandDescription command: #revisionForward)
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	firstTextModel := presenter selectedRevision.
	(firstTextModel textEdition)
		insert: 'blah' at: 1;
		flushChanges.
	self should: [presenter selectedRevision textEdition contents = 'blah1234567890'].
	query := CommandQuery commandDescription: (CommandDescription command: #revisionForward)
				source: presenter view.
	presenter queryCommand: query.
	self shouldnt: [query isEnabled].
	presenter revisionBack.
	self should: [presenter selectedRevision textEdition contents = '1234567890'].
	query := CommandQuery commandDescription: (CommandDescription command: #revisionForward)
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self should: [presenter view destroy]!

testQueryCommandToggleComparisonFollowsPoint
	| userHome presenter startingComparisonFollowsPoint query |
	startingComparisonFollowsPoint := FeAboraSystem current preferences 
				comparisonFollowsPoint.
	
	[FeAboraSystem current preferences comparisonFollowsPoint: false.
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	query := CommandQuery 
				commandDescription: (CommandDescription command: #toggleComparisonFollowsPoint)
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self shouldnt: [query isChecked].
	presenter toggleComparisonFollowsPoint.
	query := CommandQuery 
				commandDescription: (CommandDescription command: #toggleComparisonFollowsPoint)
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self should: [query isChecked].
	presenter toggleComparisonFollowsPoint.
	query := CommandQuery 
				commandDescription: (CommandDescription command: #toggleComparisonFollowsPoint)
				source: presenter view.
	presenter queryCommand: query.
	self should: [query isEnabled].
	self shouldnt: [query isChecked].
	self should: [presenter view destroy]] 
			ensure: 
				[FeAboraSystem current preferences comparisonFollowsPoint: startingComparisonFollowsPoint]!

testRevisionBack
	| userHome firstTextModel presenter query textEdition |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	firstTextModel := presenter selectedRevision.
	(firstTextModel textEdition)
		insert: 'blah' at: 1;
		flushChanges.
	self should: [presenter selectedRevision textEdition contents = 'blah1234567890'].
	presenter revisionBack.
	self should: [presenter selectedRevision textEdition contents = '1234567890'].
	self should: [presenter view destroy]!

testRevisionForward
	| userHome firstTextModel presenter query textEdition |
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	firstTextModel := presenter selectedRevision.
	(firstTextModel textEdition)
		insert: 'blah' at: 1;
		flushChanges.
	self should: [presenter selectedRevision textEdition contents = 'blah1234567890'].
	presenter revisionBack.
	self should: [presenter selectedRevision textEdition contents = '1234567890'].
	presenter revisionForward.
	self should: [presenter selectedRevision textEdition contents = 'blah1234567890'].
	self should: [presenter view destroy]!

testToggleComparisonFollowsPoint
	| userHome presenter startingComparisonFollowsPoint |
	startingComparisonFollowsPoint := FeAboraSystem current preferences 
				comparisonFollowsPoint.
	
	[FeAboraSystem current preferences comparisonFollowsPoint: false.
	userHome := self userHomeWithExample.
	presenter := FeShell showOn: (self wrapUserHome: userHome).
	presenter toggleComparisonFollowsPoint.
	self should: [FeAboraSystem current preferences comparisonFollowsPoint].
	presenter toggleComparisonFollowsPoint.
	self shouldnt: [FeAboraSystem current preferences comparisonFollowsPoint].
	self should: [presenter view destroy]] 
			ensure: 
				[FeAboraSystem current preferences comparisonFollowsPoint: startingComparisonFollowsPoint]!

userHomeEmpty
	| userHome |
	userHome := BeWork edition: BeEdition new.
	^userHome
!

userHomeWithExample
	| textEdition topEdition work userHome |
	textEdition := BeEdition contents: '1234567890' asAboraContent.
	textEdition endorse: SystemIds textEditionEndorsement.
	topEdition := BeEdition contents: textEdition.
	work := BeWork edition: topEdition.
	userHome := BeWork edition: (BeEdition contents: work).
	^userHome
!

wrapUserHome: userHomeBeWork
	^FeWork on: (BeContentElementProxy for: userHomeBeWork)!

xtestInspectAllTextEditions
	| presenter inspector |
	presenter := FeShell show.
	inspector := presenter inspectAllTextEditions.
	#todo.	"test roots"
	self should: [presenter view destroy].
	self should: [inspector view destroy]!

xtestInspectAllWorkEditions
	| presenter inspector |
	presenter := FeShell show.
	inspector := presenter inspectAllWorkEditions.
	#todo.	"test roots"
	self should: [presenter view destroy].
	self should: [inspector view destroy]!

xtestInspectWorkEdition
	| presenter inspector |
	presenter := FeShell show.
	inspector := presenter inspectWorkEdition.
	#todo.	"test roots"
	self should: [presenter view destroy].
	self should: [inspector view destroy]! !
!FeShellTest categoriesFor: #testCreate!public! !
!FeShellTest categoriesFor: #testCreateEmpty!public! !
!FeShellTest categoriesFor: #testCreateWithDefaultWorksStorage!public! !
!FeShellTest categoriesFor: #testNewEmptyWork!public! !
!FeShellTest categoriesFor: #testNewWorkFromEdition!public! !
!FeShellTest categoriesFor: #testNewWorkFromFile!public! !
!FeShellTest categoriesFor: #testQueryCommandHistoryBack!public! !
!FeShellTest categoriesFor: #testQueryCommandHistoryForward!public! !
!FeShellTest categoriesFor: #testQueryCommandRevisionBack!public! !
!FeShellTest categoriesFor: #testQueryCommandRevisionForward!public! !
!FeShellTest categoriesFor: #testQueryCommandToggleComparisonFollowsPoint!public! !
!FeShellTest categoriesFor: #testRevisionBack!public! !
!FeShellTest categoriesFor: #testRevisionForward!public! !
!FeShellTest categoriesFor: #testToggleComparisonFollowsPoint!public! !
!FeShellTest categoriesFor: #userHomeEmpty!private! !
!FeShellTest categoriesFor: #userHomeWithExample!private! !
!FeShellTest categoriesFor: #wrapUserHome:!private! !
!FeShellTest categoriesFor: #xtestInspectAllTextEditions!public! !
!FeShellTest categoriesFor: #xtestInspectAllWorkEditions!public! !
!FeShellTest categoriesFor: #xtestInspectWorkEdition!public! !

