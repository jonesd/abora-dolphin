"Filed out from Dolphin Smalltalk 2002 release 5.00"!

LeafNode subclass: #ContentLeaf
	instanceVariableNames: 'contentElement'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ContentLeaf guid: (GUID fromString: '{E75C38F4-C73A-4AF8-A275-2FD6FBDD3F4C}')!
ContentLeaf comment: ''!
!ContentLeaf categoriesForClass!Kernel-Objects! !
!ContentLeaf methodsFor!

contentElement
	^contentElement!

contentElement: aContentElement
	contentElement notNil ifTrue: [contentElement removeParent: self].
	contentElement := aContentElement.
	contentElement notNil ifTrue: [contentElement addParent: self].
!

contentsAtConstrainedIndex: index
	self assert: [index = 1].
	^self contentElement!

contentsFrom: position extent: extent do: operation
	| startIndex endIndex limitedExtent |
	startIndex := position - self startPosition + 1 max: 1.
	endIndex := position - self startPosition + extent min: self count.
	limitedExtent := endIndex - startIndex + 1.
	^limitedExtent > 0 
		ifTrue: 
			[operation value: self contentElement]
		ifFalse: ['']!

contentsFrom: position extent: extent into: stream
	| startIndex endIndex limitedExtent |
	startIndex := position - self startPosition + 1 max: 1.
	endIndex := position - self startPosition + extent min: self count.
	limitedExtent := endIndex - startIndex + 1.
	limitedExtent > 0 ifTrue: [stream nextPut: self contentElement]!

count
	^1!

printOn: aStream
	aStream nextPutAll: 'Data(branch='.
	self branch displayOn: aStream.
	aStream nextPutAll: ', pos='.
	self startPosition printOn: aStream.
	aStream nextPutAll: ', data='.
	self contentElement printOn: aStream.
	aStream nextPutAll: ')'!

sharedWith: anotherEdition for: forBranch mappings: mappings
	| anotherEditionRevision globalRegion |
	anotherEditionRevision := anotherEdition branch.
	self contentElement parents do: 
			[:leaf | 
			| root |
			root := leaf rootFor: anotherEditionRevision.
			(root notNil and: [root edition == anotherEdition]) 
				ifTrue: 
					[| anotherRegion |
					globalRegion isNil ifTrue: [globalRegion := self globalRegionFor: forBranch].
					anotherRegion := leaf globalRegionFor: anotherEditionRevision.
					mappings add: (Array with: globalRegion with: anotherRegion)]]!

split: newSplit about: elementsPosition
	"Private - Answer a new SplitNode with two data children with elements before and equal and after elementsPosition."

	self shouldNotImplement!

transclusions: transclusions
	self contentElement parents do: [:leaf | transclusions addAll: leaf allEditions]!

transclusionsFrom: position extent: extent found: transclusions
	| startIndex endIndex limitedExtent |
	startIndex := position - self startPosition + 1 max: 1.
	endIndex := position - self startPosition + extent min: self count.
	limitedExtent := endIndex - startIndex + 1.
	limitedExtent > 0 ifTrue: [self transclusions: transclusions]! !
!ContentLeaf categoriesFor: #contentElement!accessing!private! !
!ContentLeaf categoriesFor: #contentElement:!accessing!private! !
!ContentLeaf categoriesFor: #contentsAtConstrainedIndex:!public! !
!ContentLeaf categoriesFor: #contentsFrom:extent:do:!public! !
!ContentLeaf categoriesFor: #contentsFrom:extent:into:!public! !
!ContentLeaf categoriesFor: #count!public! !
!ContentLeaf categoriesFor: #printOn:!public! !
!ContentLeaf categoriesFor: #sharedWith:for:mappings:!public! !
!ContentLeaf categoriesFor: #split:about:!private! !
!ContentLeaf categoriesFor: #transclusions:!public! !
!ContentLeaf categoriesFor: #transclusionsFrom:extent:found:!public! !

!ContentLeaf class methodsFor!

branch: branch startPosition: startPosition contentElement: contentElement
	^(self basicNew)
		branch: branch;
		startPosition: startPosition;
		contentElement: contentElement;
		yourself!

branch: branch startPosition: startPosition from: contentLeaf
	^self 
		branch: branch
		startPosition: startPosition
		contentElement: contentLeaf contentElement!

icon
	^Character icon! !
!ContentLeaf class categoriesFor: #branch:startPosition:contentElement:!public! !
!ContentLeaf class categoriesFor: #branch:startPosition:from:!public! !
!ContentLeaf class categoriesFor: #icon!public! !

