"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Shell subclass: #EntInspectorShell
	instanceVariableNames: 'otreePresenter htreePresenter statsPresenter subcontentsPresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EntInspectorShell guid: (GUID fromString: '{15A6C450-78C5-489E-BC7C-EC687BD63870}')!
EntInspectorShell comment: 'A EntInspectorShell provides a view onto the Ent tree which is used to store data in the Abora world.

To open an EntInspectorShell use one of:
	aRootNode inspectNodes.
	aWork inspectAllRoots.

For example:
	WorksStorage current works last inspectAllRoots.

Looking at an open shell the top organization or otree shows the
roots associated with each of the editions of a work that all share the
contents of a single tree. Clicking on a node will highlight in the lower
histroy or htree which roots share that node. Clicking on one of these
nodes will select the first use of the node in the upper otree.

The Stats card shows simple summary of the details of the otree for
each node.'!
!EntInspectorShell categoriesForClass!MVP-Presenters! !
!EntInspectorShell methodsFor!

createComponents
	"Private - Create the presenters contained by the receiver"

	super createComponents.
	otreePresenter := self add: TreePresenter new name: 'otree'.
	htreePresenter := self add: TreePresenter new name: 'htree'.
	statsPresenter := self add: ListPresenter new name: 'stats'.
	subcontentsPresenter := self add: TextPresenter new name: 'subcontents'.
!

createSchematicWiring
	"Private - Create the trigger wiring for the receiver"
	
	super createSchematicWiring.

	otreePresenter
		when: #selectionChanged
			send: #onONodeSelected
			to: self.
	htreePresenter
		when: #selectionChanged
			send: #onHNodeSelected
			to: self.
!

inspectNode
	| node |
	node := otreePresenter selection.
	node notNil ifTrue: [node perform: #inspect].!

model: treeModel
	"Set the model associated with the receiver."

	super model: treeModel.
	otreePresenter model: treeModel.
	htreePresenter model: TreeModel new.
	statsPresenter 
		model: (ListModel on: (treeModel roots collect: [:root | EntStatistics root: root]))!

onHNodeSelected
	| selectedHNode | 
	selectedHNode := htreePresenter selectionOrNil.
	otreePresenter selection: selectedHNode.!

onONodeSelected
	| selectedONode hModel contents |
	selectedONode := otreePresenter selectionOrNil.
	selectedONode isNil ifTrue: [^self].
	hModel := VirtualTreeModel new.
	hModel getChildrenBlock: [:node | node parents].
	hModel getParentBlock: [:node | node singleParentFor: node revision].
	hModel basicRoots: (Array with: selectedONode).
	contents := selectedONode contents.
	contents := [contents asAboraText] on: Error do: [:exception | contents].
	subcontentsPresenter model: contents.
	htreePresenter model: hModel!

onViewOpened
	super onViewOpened.
	otreePresenter selection: self model roots last!

queryCommand: aCommandQuery
	"Private - Enters details about a potential command for the receiver into aCommandQuery"

	super queryCommand: aCommandQuery.
	aCommandQuery command == #inspectNode 
		ifTrue: [aCommandQuery isEnabled: (otreePresenter hasSelection and: [self respondsTo: #inspect])].!

updateCaption
	"Private - The receiver has changed in such a way that the caption may need to be refreshed.
	Overidden in subclasses that need to provide a dynamic caption that changes
	according to the state of the receiver"

	self caption: 'Abora: EntInspector'.! !
!EntInspectorShell categoriesFor: #createComponents!private! !
!EntInspectorShell categoriesFor: #createSchematicWiring!private! !
!EntInspectorShell categoriesFor: #inspectNode!public! !
!EntInspectorShell categoriesFor: #model:!public! !
!EntInspectorShell categoriesFor: #onHNodeSelected!public! !
!EntInspectorShell categoriesFor: #onONodeSelected!public! !
!EntInspectorShell categoriesFor: #onViewOpened!private! !
!EntInspectorShell categoriesFor: #queryCommand:!private! !
!EntInspectorShell categoriesFor: #updateCaption!private! !

!EntInspectorShell class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^RootNode new! !
!EntInspectorShell class categoriesFor: #defaultModel!public! !

