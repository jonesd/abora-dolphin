"Filed out from Dolphin Smalltalk 2002 release 5.00"!

LeafNode subclass: #CollectionLeaf
	instanceVariableNames: 'collectionHolder collectionRegion'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
CollectionLeaf guid: (GUID fromString: '{7CADDDFF-7DC3-488E-B703-E8B48954E7C9}')!
CollectionLeaf comment: ''!
!CollectionLeaf categoriesForClass!Kernel-Objects! !
!CollectionLeaf methodsFor!

collectionHolder
	^collectionHolder!

collectionHolder: aBeCollectionHolder
	collectionHolder notNil ifTrue: [collectionHolder removeParent: self].
	collectionHolder := aBeCollectionHolder.
	collectionHolder notNil ifTrue: [collectionHolder addParent: self]!

collectionRegion
	^collectionRegion!

collectionRegion: anObject
	collectionRegion := anObject!

contentsAtConstrainedIndex: index
	^self collectionHolder collection at: index + collectionRegion startPosition - 1!

contentsFrom: position extent: extent do: operation
	| startIndex endIndex |
	startIndex := position - self startPosition + 1.
	endIndex := position - self startPosition + extent .
	^(startIndex max: 1) to: (endIndex min: self count)
		do: [:index | operation value: (self contentsAtConstrainedIndex: index)]!

contentsFrom: position extent: extent into: stream
	| startIndex endIndex constrainedStartIndex constrainedEndIndex |
	startIndex := position - self startPosition + 1.
	endIndex := position - self startPosition + extent.
	constrainedStartIndex := startIndex max: 1.
	constrainedEndIndex := endIndex min: self count.
	constrainedEndIndex >= constrainedStartIndex 
		ifTrue: 
			[stream 
				next: constrainedEndIndex - constrainedStartIndex + 1
				putAll: collectionHolder collection
				startingAt: constrainedStartIndex + collectionRegion startPosition - 1]!

count
	^self collectionRegion extent!

elements
	^self collectionHolder collection copyFrom: collectionRegion startPosition
		to: collectionRegion endPosition!

replaceWithSplit: newSplit about: elementsPosition
	"Answer a new SplitNode with two data children with elements before and equal and after elementsPosition.
	NOTE: This operation is unusual in that all parent versions are redirected to point to the replacement split node."

	| splitNode |
	splitNode := super replaceWithSplit: newSplit about: elementsPosition.
	self collectionHolder: nil.
	^splitNode!

sharedWith: anotherEdition for: forBranch mappings: mappings
	| anotherEditionBranch |
	anotherEditionBranch := anotherEdition branch.
	self collectionHolder parents do: 
			[:leaf | 
			| root |
			(leaf collectionRegion intersects: self collectionRegion) 
				ifTrue: 
					[root := leaf rootFor: anotherEditionBranch.
					(root notNil and: [root edition == anotherEdition]) 
						ifTrue: 
							[| intersection selfRegion anotherRegion |
							intersection := self collectionRegion intersection: leaf collectionRegion.
							selfRegion := IntegerRegion 
										startPosition: (self globalPositionFor: forBranch) + intersection startPosition 
												- self collectionRegion startPosition
										extent: intersection extent.
							anotherRegion := IntegerRegion 
										startPosition: (leaf globalPositionFor: anotherEditionBranch) + intersection startPosition 
												- leaf collectionRegion startPosition
										extent: intersection extent.
							mappings add: (Array with: selfRegion with: anotherRegion)]]]!

split: newSplit about: elementsPosition
	"Private - Answer a new SplitNode with two data children with elements before and equal and after elementsPosition."

	| dataLeft dataRight |
	(elementsPosition < 2 or: [elementsPosition > self count]) 
		ifTrue: [self errorSubscriptBounds: elementsPosition].
	dataLeft := self class 
				branch: self branch
				startPosition: self startPosition
				collection: self collectionHolder
				region: (IntegerRegion startPosition: collectionRegion startPosition
						endPosition: collectionRegion startPosition + elementsPosition - 2).
	dataRight := self class 
				branch: self branch
				startPosition: self startPosition + elementsPosition - 1
				collection: self collectionHolder
				region: (IntegerRegion 
						startPosition: collectionRegion startPosition + elementsPosition - 1
						endPosition: collectionRegion endPosition).
	^SplitNode 
		branch: self branch
		split: newSplit
		left: dataLeft
		right: dataRight!

transclusions: transclusions
	self collectionHolder parents do: 
			[:leaf | 
			(leaf collectionRegion intersects: self collectionRegion) 
				ifTrue: [transclusions addAll: leaf allEditions]]!

transclusionsFrom: position extent: extent found: transclusions
	| startIndex endIndex constrainedStartIndex constrainedEndIndex |
	startIndex := position - self startPosition + 1.
	endIndex := position - self startPosition + extent.
	constrainedStartIndex := startIndex max: 1.
	constrainedEndIndex := endIndex min: self count.
	constrainedEndIndex >= constrainedStartIndex 
		ifTrue: 
			[self collectionHolder parents do: 
					[:transcluded | 
					(transcluded collectionRegion intersects: self collectionRegion) 
						ifTrue: [transclusions addAll: transcluded allEditions]]]! !
!CollectionLeaf categoriesFor: #collectionHolder!accessing!private! !
!CollectionLeaf categoriesFor: #collectionHolder:!accessing!private! !
!CollectionLeaf categoriesFor: #collectionRegion!accessing!private! !
!CollectionLeaf categoriesFor: #collectionRegion:!accessing!private! !
!CollectionLeaf categoriesFor: #contentsAtConstrainedIndex:!private! !
!CollectionLeaf categoriesFor: #contentsFrom:extent:do:!accessing!public! !
!CollectionLeaf categoriesFor: #contentsFrom:extent:into:!accessing!public! !
!CollectionLeaf categoriesFor: #count!public! !
!CollectionLeaf categoriesFor: #elements!accessing!private! !
!CollectionLeaf categoriesFor: #replaceWithSplit:about:!public! !
!CollectionLeaf categoriesFor: #sharedWith:for:mappings:!public! !
!CollectionLeaf categoriesFor: #split:about:!private! !
!CollectionLeaf categoriesFor: #transclusions:!public! !
!CollectionLeaf categoriesFor: #transclusionsFrom:extent:found:!accessing!public! !

!CollectionLeaf class methodsFor!

branch: branch startPosition: startPosition collection: dataCollection
	^self 
		branch: branch
		startPosition: startPosition
		collection: dataCollection
		region: (IntegerRegion startPosition: 1 endPosition: dataCollection collection size)!

branch: branch startPosition: startPosition collection: dataCollection region: collectionRegion
	^(self basicNew)
		branch: branch;
		collectionHolder: dataCollection;
		collectionRegion: collectionRegion;
		startPosition: startPosition;
		yourself!

branch: branch startPosition: startPosition elements: array
	self assert: [array isKindOf: Array].
	^self 
		branch: branch
		startPosition: startPosition
		collection: (BeCollectionHolder collection: array)!

branch: branch startPosition: startPosition from: collectionLeaf
	^self 
		branch: branch
		startPosition: startPosition
		collection: collectionLeaf collectionHolder
		region: collectionLeaf collectionRegion! !
!CollectionLeaf class categoriesFor: #branch:startPosition:collection:!public! !
!CollectionLeaf class categoriesFor: #branch:startPosition:collection:region:!public! !
!CollectionLeaf class categoriesFor: #branch:startPosition:elements:!public! !
!CollectionLeaf class categoriesFor: #branch:startPosition:from:!public! !

