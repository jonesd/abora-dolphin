"Filed out from Dolphin Smalltalk 2002 release 5.00"!

EntNode subclass: #RootNode
	instanceVariableNames: 'child dsp edition'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
RootNode guid: (GUID fromString: '{6BB04F90-06D8-4E2F-B759-E5D1A8F8B915}')!
RootNode comment: ''!
!RootNode categoriesForClass!Kernel-Objects! !
!RootNode methodsFor!

allRoots: allRoots
	allRoots add: self!

applyDspTo: position
	| dspPosition |
	dspPosition := position + (self invertDsp).
	^dspPosition!

assertIsChild: node
	self child ~~ node ifTrue: [EntError signal: 'unknown child of root']!

basicSplayFor: matchingBranch
	"only called in the case of a single child"

	#todo.
	self ensureSameFor: matchingBranch.
	^self child!

child
	^child!

child: aNodeOrNil
	child == aNodeOrNil ifTrue: [^self].
	child notNil ifTrue: [child removeFromParent: self].
	child := aNodeOrNil.
	#todo.	"reset dsp if nil?"
	aNodeOrNil notNil ifTrue: [aNodeOrNil addToParent: self]!

children
	^self child notNil ifTrue: [Array with: self child] ifFalse: [#()]!

contents
	^self contentsFrom: 1 extent: self count!

contentsAt: position
	child notNil 
		ifTrue: [^self child contentsAt: (self applyDspTo: position)]
		ifFalse: [self errorSubscriptBounds: position]!

contentsFrom: position extent: extent do: operation
	^self child notNil 
		ifTrue: 
			[self child 
				contentsFrom: (self applyDspTo: position)
				extent: extent
				do: operation]
		ifFalse: ['']!

contentsFrom: position extent: extent into: stream
	self child notNil 
		ifTrue: 
			[self child 
				contentsFrom: (self applyDspTo: position)
				extent: extent
				into: stream]
		ifFalse: []!

count
	^child notNil ifTrue: [child count] ifFalse: [0]!

dsp
	^dsp!

dsp: anObject
	dsp := anObject!

dsp: newDsp forChild: node
	self assertIsChild: node.
	self dsp: newDsp!

dspForChild: node
	self assertIsChild: node.
	^self dsp!

duplicateFor: newBranch
	"Do not duplicate RootNodes at the moment, as this forced to happen on newEdition."

	"is this the right behaviour - not duplicating?"

	#todo.
	self ensureSameFor: newBranch.
	^self!

edition
	^edition!

edition: anObject
	edition := anObject!

firstNodeFrom: position extent: extent shouldSplit: shouldSplit
	child notNil 
		ifTrue: 
			[^self child 
				firstNodeFrom: (self applyDspTo: position)
				extent: extent
				shouldSplit: shouldSplit]
		ifFalse: [self errorSubscriptBounds: position]!

hasChild
	^child notNil!

initialize
	super initialize.

	self dsp: 0.!

insert: dataLeaf
	"what about dsp?"

	#todo.
	self ensureSameFor: dataLeaf branch.
	child isNil 
		ifTrue: 
			[dataLeaf startPosition = 1 
				ifTrue: 
					[child := dataLeaf.
					dataLeaf addToParent: self]
				ifFalse: [self errorSubscriptBounds: dataLeaf startPosition]]
		ifFalse: 
			[self child 
				insert: dataLeaf
				at: (self applyDspTo: dataLeaf startPosition)
				root: self]!

invertDsp
	^dsp negated!

nodeAt: position
	child notNil 
		ifTrue: [^self child nodeAt: (self applyDspTo: position)]
		ifFalse: [self errorSubscriptBounds: position]!

nodesFrom: startPosition extent: extent shouldSplit: shouldSplit
	| position nodes extentLeft |
	nodes := OrderedCollection new.
	position := startPosition.
	extentLeft := extent.
	[extentLeft > 0] whileTrue: 
			[| node |
			node := self 
						firstNodeFrom: position
						extent: extentLeft
						shouldSplit: shouldSplit.
			nodes add: node.
			position := position + node count.
			#todo "extentLeft is bogus if shouldSplit = false".
			extentLeft := extentLeft - node count].
	^nodes!

parents
	^#()!

removeChild: existingChild branch: newBranch
	self ensureSameFor: newBranch.
	self replaceChild: existingChild with: nil.
	self dsp: 0!

replaceChild: existingChild with: newChild
	self assertIsChild: existingChild.
	self child: newChild.!

rootFor: matchingBranch
	self ensureCompatibleFor: matchingBranch.
	^self!

splay: position
	| node newChild |
	node := self nodeAt: position.
	newChild := node basicSplayFor: self branch.
	self child: newChild.
	^node!

transclusionsFrom: start extent: extent found: transclusions
	self hasChild ifTrue: [self child transclusionsFrom: (self applyDspTo: start) extent: extent found: transclusions].! !
!RootNode categoriesFor: #allRoots:!private! !
!RootNode categoriesFor: #applyDspTo:!private! !
!RootNode categoriesFor: #assertIsChild:!private! !
!RootNode categoriesFor: #basicSplayFor:!private! !
!RootNode categoriesFor: #child!private! !
!RootNode categoriesFor: #child:!accessing!private! !
!RootNode categoriesFor: #children!public! !
!RootNode categoriesFor: #contents!public! !
!RootNode categoriesFor: #contentsAt:!public! !
!RootNode categoriesFor: #contentsFrom:extent:do:!public! !
!RootNode categoriesFor: #contentsFrom:extent:into:!public! !
!RootNode categoriesFor: #count!public! !
!RootNode categoriesFor: #dsp!accessing!private! !
!RootNode categoriesFor: #dsp:!accessing!private! !
!RootNode categoriesFor: #dsp:forChild:!public! !
!RootNode categoriesFor: #dspForChild:!public! !
!RootNode categoriesFor: #duplicateFor:!public! !
!RootNode categoriesFor: #edition!accessing!public! !
!RootNode categoriesFor: #edition:!accessing!private! !
!RootNode categoriesFor: #firstNodeFrom:extent:shouldSplit:!public! !
!RootNode categoriesFor: #hasChild!public! !
!RootNode categoriesFor: #initialize!private! !
!RootNode categoriesFor: #insert:!public! !
!RootNode categoriesFor: #invertDsp!private! !
!RootNode categoriesFor: #nodeAt:!public! !
!RootNode categoriesFor: #nodesFrom:extent:shouldSplit:!public! !
!RootNode categoriesFor: #parents!public! !
!RootNode categoriesFor: #removeChild:branch:!private! !
!RootNode categoriesFor: #replaceChild:with:!private! !
!RootNode categoriesFor: #rootFor:!public! !
!RootNode categoriesFor: #splay:!public! !
!RootNode categoriesFor: #transclusionsFrom:extent:found:!public! !

!RootNode class methodsFor!

edition: edition branch: branch
	^self 
		edition: edition
		branch: branch
		with: nil!

edition: edition branch: branch with: childNode
	^self 
		edition: edition
		branch: branch
		with: childNode
		dsp: 0!

edition: edition branch: branch with: childNode dsp: dsp
	| rootNode |
	rootNode := (self basicNew)
				edition: edition;
				branch: branch;
				child: childNode;
				dsp: dsp;
				yourself.
	^rootNode! !
!RootNode class categoriesFor: #edition:branch:!public! !
!RootNode class categoriesFor: #edition:branch:with:!public! !
!RootNode class categoriesFor: #edition:branch:with:dsp:!public! !

