"Filed out from Dolphin Smalltalk 2002 release 5.00"!

BeContentElement subclass: #BeEdition
	instanceVariableNames: 'works root branch nextBranchStep id endorsements'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeEdition guid: (GUID fromString: '{CC79EF15-8640-4FB9-B8A3-AAF838DA97A8}')!
BeEdition comment: ''!
!BeEdition categoriesForClass!Kernel-Objects! !
!BeEdition methodsFor!

addWork: work
	works add: work!

append: text
	^self insert: text at: self count + 1.!

branch
	^branch!

branch: branchingNumber
	branch := branchingNumber!

combineMappings: mappings
	"review performance - also do clients need the best mappings or the cheapest mapping summary?"

	| newMappings workingMappings |
	#todo.
	newMappings := SortedCollection 
				sortBlock: [:a :b | a first startPosition <= b first startPosition].
	workingMappings := mappings.
	[workingMappings notEmpty] whileTrue: 
			[| pair index anyCombined |
			pair := workingMappings first.
			workingMappings := workingMappings copyFrom: 2.
			
			[anyCombined := false.
			index := 1.
			[index <= workingMappings size] whileTrue: 
					[| nextPair |
					nextPair := workingMappings at: index.
					(nextPair first startPosition = (pair first endPosition + 1) 
						and: [nextPair last startPosition = (pair last endPosition + 1)]) 
							ifTrue: 
								[| newPair |
								newPair := Array with: (IntegerRegion startPosition: pair first startPosition
													extent: pair first extent + nextPair first extent)
											with: (IntegerRegion startPosition: pair last startPosition
													extent: pair last extent + nextPair last extent).
								workingMappings removeAtIndex: index.
								anyCombined := true.
								pair := newPair]
							ifFalse: [index := index + 1]].
			anyCombined] 
					whileTrue.
			newMappings add: pair].
	^newMappings!

contents
	^self contentsFrom: 1 extent: self count!

contentsAt: position
	^self root contentsAt: position!

contentsFrom: position extent: extent
	^self root contentsFrom: position extent: extent!

count
	^self root count!

createNodesFrom: elements at: startPosition
	#todo.
	^(elements isKindOf: Array) 
		ifTrue: 
			[(elements notEmpty and: [elements first isKindOf: BeContentElement]) 
				ifTrue: 
					[| position |
					position := startPosition.
					elements collect: 
							[:contentElement | 
							| node |
							node := contentElement createNodeAt: position for: self branch.
							position := position + 1.
							node]]
				ifFalse: 
					[Array with: ((BeCollectionHolder collection: elements) createNodeAt: startPosition
								for: self branch)]]
		ifFalse: [Array with: (elements createNodeAt: startPosition for: self branch)]!

createTransclusionLeafs: originalEdition from: startPosition extent: extent to: to
	"do not split"

	| originalLeafs leafs |
	#todo.
	originalLeafs := originalEdition root 
				nodesFrom: startPosition
				extent: extent
				shouldSplit: true.
	#todo.	"group together content references if possible"
	leafs := OrderedCollection new: originalLeafs size.
	originalLeafs inject: to
		into: 
			[:position :originalLeaf | 
			| newLeaf |
			newLeaf := originalLeaf class 
						branch: nil
						startPosition: position
						from: originalLeaf.
			leafs add: newLeaf.
			position + newLeaf count].
	^leafs!

endorse: endorsementPair
	endorsements add: endorsementPair!

endorsements
	^endorsements!

findElementAt: position
	^self root nodeAt: position!

id
	^id!

initialize
	super initialize.
	id := Id nextIdFor: self.
	branch := BranchingNumber with: 1.
	"	revision := 1."
	root := RootNode edition: self branch: self branch.
	works := Set new.
	nextBranchStep := 0.
	endorsements := Set new!

initializeFromEdition: edition
	branch := edition nextBranch.
	root := RootNode 
				edition: self
				branch: self branch
				with: edition root child
				dsp: edition root dsp!

insert: elements at: position
	| nodes |
	nodes := self createNodesFrom: elements at: position.
	^self insertNodes: nodes!

insertNode: node
	^self insertNodes: (Array with: node)!

insertNodes: newNodes
	| newEdition |
	newEdition := self class edition: self.
	newNodes do: 
			[:node | 
			"dubious grouping for revision"

			#todo.
			node branch: newEdition branch.
			newEdition root insert: node].
	^newEdition!

isEmpty
	^root hasChild not!

makeFeProxy
	^FeContentElementProxy forId: self id class: #FeEdition!

nextBranch
	| nextBranch |
	nextBranch := nextBranchStep = 0 
				ifTrue: [branch isInteger ifTrue: [branch + 1] ifFalse: [branch incrementLast]]
				ifFalse: [(branch asBranchingNumber copyWith: nextBranchStep) copyWith: 1].
	nextBranchStep := nextBranchStep + 1.
	^nextBranch!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(id='.
	self id displayOn: aStream.
	aStream nextPutAll: ', branch='.
	self branch displayOn: aStream.
	aStream nextPutAll: ')'!

removeElements: elements
	| newEdition |
	newEdition := self class edition: self.
	elements do: [:element | element removeFor: newEdition branch].
	^newEdition!

removeFrom: from extent: extent
	| elements |
	elements := self root 
				nodesFrom: from
				extent: extent
				shouldSplit: true.
	^self removeElements: elements!

removeWork: work
	works remove: work!

retract: endorsementPair
	endorsements remove: endorsementPair!

root
	^root!

sharedWith: anotherEdition
	"Answer the subset of the receiver that is transcluded by anotherEdition as a set of mapping"

	"return an edition"

	| mappings |
	#todo.
	mappings := OrderedCollection new.
	root 
		sharedWith: anotherEdition
		for: self branch
		mappings: mappings.
	mappings := self combineMappings: mappings.
	^mappings!

transcludeEdition: edition from: from extent: extent to: to
	| newLeafs | 
	newLeafs := self createTransclusionLeafs: edition from: from extent: extent to: to.
	^self insertNodes: newLeafs.
!

transclusions
	| editions |
	#todo "return an edition".
	editions := IdentitySet new.
	root transclusions: editions.
	editions remove: self ifAbsent: ["ignore"].
	^editions
!

transclusionsFilteredBy: filter
	| editions |
	editions := self transclusions.
	^self filterTransclusions: editions by: filter
!

transclusionsFrom: start extent: extent
	| editions |
	#todo "return an edition".
	editions := IdentitySet new.
	root transclusionsFrom: start extent: extent found: editions.
	editions remove: self ifAbsent: ["ignore"].
	^editions
!

transclusionsFrom: start extent: extent filteredBy: filter
	| editions |
	editions := self transclusionsFrom: start extent: extent.
	^self filterTransclusions: editions by: filter!

works
	^works! !
!BeEdition categoriesFor: #addWork:!must not strip!public! !
!BeEdition categoriesFor: #append:!must not strip!public! !
!BeEdition categoriesFor: #branch!accessing!must not strip!public! !
!BeEdition categoriesFor: #branch:!accessing!private! !
!BeEdition categoriesFor: #combineMappings:!accessing!must not strip!private! !
!BeEdition categoriesFor: #contents!must not strip!public! !
!BeEdition categoriesFor: #contentsAt:!must not strip!public! !
!BeEdition categoriesFor: #contentsFrom:extent:!must not strip!public! !
!BeEdition categoriesFor: #count!must not strip!public! !
!BeEdition categoriesFor: #createNodesFrom:at:!private! !
!BeEdition categoriesFor: #createTransclusionLeafs:from:extent:to:!private! !
!BeEdition categoriesFor: #endorse:!must not strip!public! !
!BeEdition categoriesFor: #endorsements!must not strip!public! !
!BeEdition categoriesFor: #findElementAt:!private! !
!BeEdition categoriesFor: #id!must not strip!public! !
!BeEdition categoriesFor: #initialize!private! !
!BeEdition categoriesFor: #initializeFromEdition:!private! !
!BeEdition categoriesFor: #insert:at:!must not strip!public! !
!BeEdition categoriesFor: #insertNode:!private! !
!BeEdition categoriesFor: #insertNodes:!private! !
!BeEdition categoriesFor: #isEmpty!must not strip!public! !
!BeEdition categoriesFor: #makeFeProxy!private! !
!BeEdition categoriesFor: #nextBranch!accessing!private! !
!BeEdition categoriesFor: #printOn:!must not strip!public! !
!BeEdition categoriesFor: #removeElements:!private! !
!BeEdition categoriesFor: #removeFrom:extent:!must not strip!public! !
!BeEdition categoriesFor: #removeWork:!must not strip!public! !
!BeEdition categoriesFor: #retract:!must not strip!public! !
!BeEdition categoriesFor: #root!private! !
!BeEdition categoriesFor: #sharedWith:!accessing!must not strip!public! !
!BeEdition categoriesFor: #transcludeEdition:from:extent:to:!must not strip!public! !
!BeEdition categoriesFor: #transclusions!accessing!must not strip!public! !
!BeEdition categoriesFor: #transclusionsFilteredBy:!accessing!must not strip!public! !
!BeEdition categoriesFor: #transclusionsFrom:extent:!accessing!must not strip!public! !
!BeEdition categoriesFor: #transclusionsFrom:extent:filteredBy:!accessing!must not strip!public! !
!BeEdition categoriesFor: #works!must not strip!public! !

!BeEdition class methodsFor!

contents: contents
	^self new append: contents!

edition: edition
	^(self new)
		initializeFromEdition: edition;
		yourself!

icon
	^Shell icon! !
!BeEdition class categoriesFor: #contents:!public! !
!BeEdition class categoriesFor: #edition:!public! !
!BeEdition class categoriesFor: #icon!public! !

