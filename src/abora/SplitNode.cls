"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ChildNode subclass: #SplitNode
	instanceVariableNames: 'split left right leftDsp rightDsp'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
SplitNode guid: (GUID fromString: '{A782D69C-80F0-4D8A-A21A-F607194C0488}')!
SplitNode comment: ''!
!SplitNode categoriesForClass!Kernel-Objects! !
!SplitNode methodsFor!

applyDsp: dsp to: position
	| dspPosition |
	dspPosition := position + (self invertDsp: dsp).
	^dspPosition!

assertIsChild: node
	(left ~~ node and: [right ~~ node]) ifTrue: [EntError signal: 'unknown child'].
	#todo	"ensure left !!= right"!

basicParentSplit
	^self!

basicSplayFor: matchingBranch
	| parent grandParent newSelf |
	parent := self parentSplit: matchingBranch.
	parent isNil ifTrue: [^self].
	grandParent := parent parentSplit: matchingBranch.
	newSelf := parent left == self 
				ifTrue: 
					[(grandParent notNil and: [parent = grandParent left]) 
						ifTrue: [parent := grandParent singleRotateLeftFor: matchingBranch].
					parent singleRotateLeftFor: matchingBranch]
				ifFalse: 
					[(grandParent notNil and: [parent = grandParent right]) 
						ifTrue: [parent := grandParent singleRotateRightFor: matchingBranch].
					parent singleRotateRightFor: matchingBranch].
	newSelf basicSplayFor: matchingBranch.
	^newSelf!

childFor: position do: duadic
	| child dsp dspPosition |
	(self isLeft: position) 
		ifTrue: 
			[child := self left.
			dsp := self leftDsp]
		ifFalse: 
			[child := self right.
			dsp := self rightDsp].
	dspPosition := self applyDsp: dsp to: position.
	^duadic value: child value: dspPosition.!

children
	^Array with: self left with: self right
!

contents
	| minElement position |
	minElement := self minNode.
	position := minElement globalPositionFor: self branch
				to: (self singleParentFor: self branch).
	^self contentsFrom: position extent: self count!

contentsAt: position
	^self childFor: position do: [:child :dspPosition | child contentsAt: dspPosition]!

contentsFrom: position extent: extent do: operation
	position < self split ifTrue: [self left contentsFrom: (self applyDsp: self leftDsp to: position) extent: extent do: operation].
	position + extent > self split ifTrue: [self right contentsFrom: (self applyDsp: self rightDsp to: position) extent: extent do: operation].
!

contentsFrom: position extent: extent into: stream
	position < self split ifTrue: [self left contentsFrom: (self applyDsp: self leftDsp to: position) extent: extent into: stream].
	position + extent > self split ifTrue: [self right contentsFrom: (self applyDsp: self rightDsp to: position) extent: extent into: stream].
!

count
	^self left count + self right count!

dsp: dsp forChild: node
	self assertIsChild: node.
	left == node ifTrue: [self leftDsp: dsp].
	right == node ifTrue: [self rightDsp: dsp]!

dspForChild: node
	self assertIsChild: node.
	left == node ifTrue: [^self leftDsp].
	right == node ifTrue: [^self rightDsp]!

duplicateFor: duplicateBranch
	"Answer a copy of the receiver if self isn't of the required revision.
	The duplicate connects to self children, but has no parents set."

	self ensureCompatibleFor: duplicateBranch.
	#todo.	"perhaps ^self in this case?"
	(self isSameFor: duplicateBranch) ifTrue: [^self].
	^self class 
		branch: duplicateBranch
		split: self split
		left: self left
		leftDsp: self leftDsp
		right: self right
		rightDsp: self rightDsp!

firstNodeFrom: position extent: extent shouldSplit: shouldSplit
	^self childFor: position
		do: 
			[:child :dspPosition | 
			child 
				firstNodeFrom: dspPosition
				extent: extent
				shouldSplit: shouldSplit]!

insert: dataLeaf at: position root: root
	^self childFor: position do: [:child :dspPosition | child insert: dataLeaf at: dspPosition root: root].!

invertDsp: dsp
	^dsp negated!

isLeft: position
	^position < self split!

left
	^left!

left: aNode
	left == aNode ifTrue: [^self].
	left notNil ifTrue: [left removeFromParent: self].
	left := aNode.
	aNode addToParent: self!

leftDsp
	^leftDsp!

leftDsp: anObject
	leftDsp := anObject!

nodeAt: position
	^self childFor: position do: [:child :dspPosition | child nodeAt: dspPosition]!

removeChild: existingChild branch: newBranch
	| parent duplicate |
	self assertIsChild: existingChild.
	(right == existingChild and: [(right isMaxNodeFor: newBranch) not]) 
		ifTrue: 
			["Splay to toggle childs location into one that we can handle"

			^existingChild removeFor: newBranch].
	"duplicate self and parents chain to root, then just use the duplicates"
	#todo.	" only need to duplicate if node is being shared with outher versions"
	duplicate := (self isSameFor: newBranch) 
				ifTrue: 
					["existingChild"

					self]
				ifFalse: [self duplicateWithParentsFor: newBranch].
	parent := duplicate singleParentFor: newBranch.
	duplicate left == existingChild 
		ifTrue: 
			[parent == (duplicate rootFor: newBranch) 
				ifTrue: [duplicate removeChildLeftFromRoot]
				ifFalse: [duplicate removeChildLeft]]
		ifFalse: 
			[self assert: [duplicate right == existingChild].
			duplicate removeChildRightMaxElement]!

removeChildLeft
	"Assumed to be a duplicate by this point"

	| parent rootChild |
	parent := self singleParentFor: self branch.
	parent dsp: (parent dspForChild: self) + self rightDsp forChild: self.
	parent replaceChild: self with: self right.
	self right removeFromParent: self.
	rootChild := (self right rootFor: self branch) child.
	rootChild rightDsp: rootChild rightDsp - self left count!

removeChildLeftFromRoot
	| parent |
	parent := self singleParentFor: self branch.
	parent dsp: (parent dspForChild: self) + self rightDsp - self left count forChild: self.
	parent replaceChild: self with: self right.
	self right removeFromParent: self!

removeChildRightMaxElement
	| parent |
	parent := self singleParentFor: self branch.
	parent dsp: (parent dspForChild: self) + self leftDsp forChild: self.
	parent replaceChild: self with: self left.
	self left removeFromParent: self!

replaceChild: existingChild with: newChild
	self assertIsChild: existingChild.
	left == existingChild ifTrue: [self left: newChild].
	right == existingChild ifTrue: [self right: newChild]!

right
	^right!

right: aNode
	right == aNode ifTrue: [^self].
	right notNil ifTrue: [right removeFromParent: self].
	right := aNode.
	aNode addToParent: self!

rightDsp
	^rightDsp!

rightDsp: anObject
	rightDsp := anObject!

singleRotateLeftFor: matchingBranch
	| node2 b c d e |
	node2 := self left.
	self assert: [node2 isMemberOf: self class].
	#todo.	"mess!! + dont have to duplicate every different root branching off at this point"
	(self isSameFor: node2 branch) 
		ifFalse: 
			[| myNewNode2 |
			self assert: [node2 branch < self branch].
			node2 parents asArray do: 
					[:node2Parent | 
					| newNode2 |
					node2Parent ~~ self 
						ifTrue: 
							[newNode2 := node2 duplicateFor: node2Parent branch.
							node2Parent replaceChild: node2 with: newNode2]].
			myNewNode2 := node2 duplicateFor: self branch.
			self replaceChild: node2 with: myNewNode2.
			^self singleRotateLeftFor: matchingBranch].
	node2 parents asArray do: 
			[:node2Parent | 
			| newNode2 |
			node2Parent ~~ self 
				ifTrue: 
					[newNode2 := node2 duplicateFor: node2Parent branch.
					node2Parent replaceChild: node2 with: newNode2]].
	"parent := self singleParent: matchingRevision."
	"get existing dsp's"
	"a := parent dspForChild: self."
	b := self leftDsp.
	c := self rightDsp.
	d := self left leftDsp.
	e := self left rightDsp.
	"rotate left child (node2) to become  parent of self"
	self left: node2 right.
	"parent replaceChild: self with: node2."
	"update all dsps"
	self parents do: 
			[:parent | 
			| a |
			a := parent dspForChild: self.
			parent replaceChild: self with: node2.
			parent dsp: a + b forChild: node2].
	node2 right: self.
	node2 leftDsp: d.
	node2 rightDsp: b negated.
	self leftDsp: b + e.
	self rightDsp: c.
	^node2!

singleRotateRightFor: matchingBranch
	| node2 b c d e |
	node2 := self right.
	self assert: [node2 isMemberOf: self class].
	#todo.	"mess!! + dont have to duplicate every different root branching off at this point"
	(self isSameFor: node2 branch) 
		ifFalse: 
			[| myNewNode2 |
			self assert: [node2 branch < self branch].
			node2 parents asArray do: 
					[:node2Parent | 
					| newNode2 |
					node2Parent ~~ self 
						ifTrue: 
							[newNode2 := node2 duplicateFor: node2Parent branch.
							node2Parent replaceChild: node2 with: newNode2]].
			myNewNode2 := node2 duplicateFor: self branch.
			self replaceChild: node2 with: myNewNode2.
			^self singleRotateRightFor: matchingBranch].
	node2 parents asArray do: 
			[:node2Parent | 
			| newNode2 |
			node2Parent ~~ self 
				ifTrue: 
					[newNode2 := node2 duplicateFor: node2Parent branch.
					node2Parent replaceChild: node2 with: newNode2]].
	"parent := self singleParent: matchingRevision."
	"get existing dsp's"
	"a := parent dspForChild: self."
	b := self leftDsp.
	c := self rightDsp.
	d := self right leftDsp.
	e := self right rightDsp.
	"rotate right child (node2) to become  parent of self"
	self right: node2 left.
	"parent replaceChild: self with: node2."
	"update all dsps"
	self parents do: 
			[:parent | 
			| a |
			a := parent dspForChild: self.
			parent replaceChild: self with: node2.
			parent dsp: a + c forChild: node2].
	node2 left: self.
	node2 leftDsp: c negated.
	node2 rightDsp: e.
	node2 left leftDsp: b.
	node2 left rightDsp: c + d.
	^node2!

split
	^split!

split: anObject
	split := anObject!

transclusionsFrom: position extent: extent found: transclusions
	position < self split ifTrue: [self left transclusionsFrom: (self applyDsp: self leftDsp to: position) extent: extent found: transclusions].
	position + extent > self split ifTrue: [self right transclusionsFrom: (self applyDsp: self rightDsp to: position) extent: extent found: transclusions].
! !
!SplitNode categoriesFor: #applyDsp:to:!private! !
!SplitNode categoriesFor: #assertIsChild:!private! !
!SplitNode categoriesFor: #basicParentSplit!accessing!private! !
!SplitNode categoriesFor: #basicSplayFor:!private! !
!SplitNode categoriesFor: #childFor:do:!private! !
!SplitNode categoriesFor: #children!public! !
!SplitNode categoriesFor: #contents!public! !
!SplitNode categoriesFor: #contentsAt:!public! !
!SplitNode categoriesFor: #contentsFrom:extent:do:!accessing!public! !
!SplitNode categoriesFor: #contentsFrom:extent:into:!accessing!public! !
!SplitNode categoriesFor: #count!accessing!public! !
!SplitNode categoriesFor: #dsp:forChild:!private! !
!SplitNode categoriesFor: #dspForChild:!private! !
!SplitNode categoriesFor: #duplicateFor:!private! !
!SplitNode categoriesFor: #firstNodeFrom:extent:shouldSplit:!public! !
!SplitNode categoriesFor: #insert:at:root:!public! !
!SplitNode categoriesFor: #invertDsp:!private! !
!SplitNode categoriesFor: #isLeft:!public! !
!SplitNode categoriesFor: #left!accessing!private! !
!SplitNode categoriesFor: #left:!accessing!private! !
!SplitNode categoriesFor: #leftDsp!accessing!private! !
!SplitNode categoriesFor: #leftDsp:!accessing!private! !
!SplitNode categoriesFor: #nodeAt:!public! !
!SplitNode categoriesFor: #removeChild:branch:!public! !
!SplitNode categoriesFor: #removeChildLeft!private! !
!SplitNode categoriesFor: #removeChildLeftFromRoot!private! !
!SplitNode categoriesFor: #removeChildRightMaxElement!private! !
!SplitNode categoriesFor: #replaceChild:with:!public! !
!SplitNode categoriesFor: #right!accessing!private! !
!SplitNode categoriesFor: #right:!accessing!private! !
!SplitNode categoriesFor: #rightDsp!accessing!private! !
!SplitNode categoriesFor: #rightDsp:!accessing!private! !
!SplitNode categoriesFor: #singleRotateLeftFor:!private! !
!SplitNode categoriesFor: #singleRotateRightFor:!private! !
!SplitNode categoriesFor: #split!accessing!private! !
!SplitNode categoriesFor: #split:!accessing!private! !
!SplitNode categoriesFor: #transclusionsFrom:extent:found:!accessing!public! !

!SplitNode class methodsFor!

branch: branch split: splitPosition left: leftNode leftDsp: leftDsp right: rightNode
	^self 
		branch: branch
		split: splitPosition
		left: leftNode
		leftDsp: leftDsp
		right: rightNode
		rightDsp: 0!

branch: branch split: splitPosition left: leftNode leftDsp: leftDsp right: rightNode rightDsp: rightDsp
	| splitNode |
	splitNode := (self basicNew)
				branch: branch;
				split: splitPosition;
				left: leftNode;
				leftDsp: leftDsp;
				right: rightNode;
				rightDsp: rightDsp;
				yourself.
	^splitNode!

branch: branch split: splitPosition left: leftNode right: rightNode
	^self 
		branch: branch
		split: splitPosition
		left: leftNode
		leftDsp: 0
		right: rightNode
		rightDsp: 0!

branch: branch split: splitPosition left: leftNode right: rightNode rightDsp: rightDsp
	^self 
		branch: branch
		split: splitPosition
		left: leftNode
		leftDsp: 0
		right: rightNode
		rightDsp: rightDsp! !
!SplitNode class categoriesFor: #branch:split:left:leftDsp:right:!public! !
!SplitNode class categoriesFor: #branch:split:left:leftDsp:right:rightDsp:!public! !
!SplitNode class categoriesFor: #branch:split:left:right:!public! !
!SplitNode class categoriesFor: #branch:split:left:right:rightDsp:!public! !

