"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ChildNode subclass: #LeafNode
	instanceVariableNames: 'startPosition'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
LeafNode guid: (GUID fromString: '{F64D0B1E-54DA-4D5C-97C8-665909D3718D}')!
LeafNode comment: ''!
!LeafNode categoriesForClass!Kernel-Objects! !
!LeafNode methodsFor!

basicInsert: dataLeaf at: position root: root
	| index |
	index := position - startPosition + 1.
	(index < 1 or: [index > (self count + 1)]) ifTrue: [self errorSubscriptBounds: position].
	index = 1 
		ifTrue: 
			["insert before"

			(self isMinNodeFor: root branch) 
				ifTrue: [self basicInsertBeforeEnt: dataLeaf root: root]
				ifFalse: 
					[^self 
						basicInsertBeforeSelf: dataLeaf
						at: position
						root: root]]
		ifFalse: 
			[index <= self count 
				ifTrue: 
					["split then insert"

					| splitNode |
					splitNode := self replaceWithSplit: position about: index.
					^splitNode right 
						insert: dataLeaf
						at: position
						root: root]
				ifFalse: 
					[(self isMaxNodeFor: root branch) 
						ifTrue: [self basicInsertAfterEnt: dataLeaf root: root]
						ifFalse: [self errorSubscriptBounds: position]]]!

basicInsertAfterEnt: dataLeaf root: root
	"add to end of entire ent"

	| splitNode |
	splitNode := SplitNode 
				branch: root branch
				split: dataLeaf startPosition
				left: root child
				leftDsp: root dsp
				right: dataLeaf.
	root child: splitNode.
	root dsp: 0!

basicInsertBeforeEnt: dataLeaf root: root
	"add to beginning of entire ent"

	| splitNode |
	splitNode := SplitNode 
				branch: root branch
				split: dataLeaf count + dataLeaf startPosition
				left: dataLeaf
				right: root child
				rightDsp: dataLeaf count + root dsp.
	root child: splitNode.
	root dsp: 0!

basicInsertBeforeSelf: dataLeaf at: position root: root
	"add before self"

	| parent newBranch |
	newBranch := root branch.
	parent := self parentSplit: newBranch.
	self assert: [parent notNil].
	self assert: [parent left == self or: [parent right == self]].
	(parent left == self or: [(parent parentSplit: newBranch) isNil]) 
		ifTrue: 
			[| a b |
			(root child isSameFor: newBranch) ifTrue: [root child right removeFromParent: root child].
			a := SplitNode 
						branch: newBranch
						split: dataLeaf startPosition + dataLeaf count
						left: dataLeaf
						right: root child right
						rightDsp: dataLeaf count + root child rightDsp + root dsp.
			(root child isSameFor: newBranch) ifTrue: [root child left removeFromParent: root child].
			b := SplitNode 
						branch: newBranch
						split: dataLeaf startPosition
						left: root child left
						leftDsp: root child leftDsp + root dsp
						right: a.
			root child: b.
			root dsp: 0]
		ifFalse: 
			["Force self to other side of parent by splaying"

			parent basicSplayFor: newBranch.
			^self 
				basicInsert: dataLeaf
				at: position
				root: root]!

basicSplayFor: matchingBranch
	^(self singleParentFor: matchingBranch) basicSplayFor: matchingBranch!

children
	^#()
!

constrainedIndexFrom: position
	| index |
	index := position - self startPosition + 1.
	(index < 1 or: [index > self count]) ifTrue: [self errorSubscriptBounds: index].
	^index!

contents
	^self contentsFrom: self startPosition extent: self count!

contentsAt: position
	| index |
	index := self constrainedIndexFrom: position.
	^self contentsAtConstrainedIndex: index!

contentsAtConstrainedIndex: index
	self subclassResponsibility!

duplicateFor: newBranch
	self shouldNotImplement!

firstNodeFrom: position extent: extent shouldSplit: shouldSplit
	| index |
	index := self constrainedIndexFrom: position.
	shouldSplit ifFalse: [^self].
	^index > 1 
		ifTrue: 
			[| newParent |
			newParent := self replaceWithSplit: position about: index.
			newParent right 
				firstNodeFrom: position
				extent: extent
				shouldSplit: shouldSplit]
		ifFalse: 
			[extent < self count 
				ifTrue: 
					[| newParent |
					newParent := self replaceWithSplit: position + extent about: extent + 1.
					newParent left]
				ifFalse: [self]]!

globalPositionFor: matchingBranch
	^self globalPositionFor: matchingBranch to: nil!

globalPositionFor: matchingBranch to: topParent
	| position node parent |
	position := self startPosition.
	node := self.
	[(parent := node singleParentFor: matchingBranch) ~~ topParent] whileTrue: 
			[position := position + (parent dspForChild: node).
			node := parent].
	^position!

globalRegionFor: forBranch
	^IntegerRegion startPosition: (self globalPositionFor: forBranch) extent: self count!

insert: dataLeaf at: position root: root
	| index |
	index := position - startPosition + 1.
	(index < 1 or: [index > (self count + 1)]) ifTrue: [self errorSubscriptBounds: position].
	self basicSplayFor: root branch.
	self 
		basicInsert: dataLeaf
		at: position
		root: root!

isMaxNodeFor: matchingBranch
	| node parent |
	node := self.
	[(parent := node parentSplit: matchingBranch) notNil] whileTrue: 
			[parent right == node ifFalse: [^false].
			node := parent].
	^true!

isMinNodeFor: matchingBranch
	| node parent |
	node := self.
	[(parent := node parentSplit: matchingBranch) notNil] whileTrue: 
			[parent left == node ifFalse: [^false].
			node := parent].
	^true!

maxNode
	^self!

minNode
	^self!

nodeAt: position
	| index |
	index := self constrainedIndexFrom: position.
	^self!

removeFor: newBranch
	self basicSplayFor: newBranch.
	(self singleParentFor: newBranch) removeChild: self branch: newBranch!

replaceWithSplit: newSplit about: elementsPosition
	"Answer a new SplitNode with two data children with elements before and equal and after elementsPosition.
	NOTE: This operation is unusual in that all parent versions are redirected to point to the replacement split node."

	| splitNode |
	splitNode := self split: newSplit about: elementsPosition.
	self parents do: [:parent | parent replaceChild: self with: splitNode].
	self assert: [self parents isEmpty].
	^splitNode!

split: newSplit about: elementsPosition
	self subclassResponsibility!

startPosition
	^startPosition!

startPosition: anObject
	startPosition := anObject! !
!LeafNode categoriesFor: #basicInsert:at:root:!private! !
!LeafNode categoriesFor: #basicInsertAfterEnt:root:!private! !
!LeafNode categoriesFor: #basicInsertBeforeEnt:root:!private! !
!LeafNode categoriesFor: #basicInsertBeforeSelf:at:root:!private! !
!LeafNode categoriesFor: #basicSplayFor:!private! !
!LeafNode categoriesFor: #children!public! !
!LeafNode categoriesFor: #constrainedIndexFrom:!private! !
!LeafNode categoriesFor: #contents!public! !
!LeafNode categoriesFor: #contentsAt:!public! !
!LeafNode categoriesFor: #contentsAtConstrainedIndex:!public! !
!LeafNode categoriesFor: #duplicateFor:!public! !
!LeafNode categoriesFor: #firstNodeFrom:extent:shouldSplit:!public! !
!LeafNode categoriesFor: #globalPositionFor:!public! !
!LeafNode categoriesFor: #globalPositionFor:to:!private! !
!LeafNode categoriesFor: #globalRegionFor:!public! !
!LeafNode categoriesFor: #insert:at:root:!public! !
!LeafNode categoriesFor: #isMaxNodeFor:!public! !
!LeafNode categoriesFor: #isMinNodeFor:!public! !
!LeafNode categoriesFor: #maxNode!public! !
!LeafNode categoriesFor: #minNode!public! !
!LeafNode categoriesFor: #nodeAt:!public! !
!LeafNode categoriesFor: #removeFor:!public! !
!LeafNode categoriesFor: #replaceWithSplit:about:!public! !
!LeafNode categoriesFor: #split:about:!public! !
!LeafNode categoriesFor: #startPosition!accessing!private! !
!LeafNode categoriesFor: #startPosition:!accessing!private! !

