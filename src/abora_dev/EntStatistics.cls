"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #EntStatistics
	instanceVariableNames: 'root totalCollectionLeafs totalSplitNodes totalContentLeafs maxDepth count contents'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EntStatistics guid: (GUID fromString: '{84938612-7129-4F41-BA91-613683D626E7}')!
EntStatistics comment: ''!
!EntStatistics categoriesForClass!Kernel-Objects! !
!EntStatistics methodsFor!

contents
	contents isNil 
		ifTrue: 
			[contents := self root contentsFrom: 1 extent: self maxContentsToShow.
			[contents := contents asAboraText] on: Error
				do: [:error | contents := contents printString].
			contents size >= self maxContentsToShow ifTrue: [contents := contents , '...']].
	^contents!

count
	count isNil ifTrue: [count := self root count].
	^count!

countNodes
	totalCollectionLeafs := 0.
	totalSplitNodes := 0.
	totalContentLeafs := 0.
	self countNodes: self root!

countNodes: node
	"Private - replace with double dispatch and generic visitor walking tree"

	#todo.
	(node isMemberOf: SplitNode) ifTrue: [totalSplitNodes := totalSplitNodes + 1].
	(node isMemberOf: CollectionLeaf) 
		ifTrue: [totalCollectionLeafs := totalCollectionLeafs + 1].
	(node isMemberOf: ContentLeaf) ifTrue: [totalContentLeafs := totalContentLeafs + 1].
	node children do: [:child | self countNodes: child]!

findMaxDepth
	maxDepth := 0.
	self findMaxDepth: root depth: 1.!

findMaxDepth: node depth: depth
	depth > maxDepth ifTrue: [maxDepth := depth].
	node children do: [:child | self findMaxDepth: child depth: depth + 1].!

maxContentsToShow
	^50!

maxDepth
	maxDepth isNil ifTrue: [self findMaxDepth].
	^maxDepth!

root
	^root!

root: anObject
	root := anObject!

totalCollectionLeafs
	totalCollectionLeafs isNil ifTrue: [self countNodes].
	^totalCollectionLeafs!

totalContentLeafs
	totalContentLeafs isNil ifTrue: [self countNodes].
	^totalContentLeafs!

totalNodes
	^self totalCollectionLeafs + self totalSplitNodes + self totalContentLeafs!

totalSplitNodes
	totalSplitNodes isNil ifTrue: [self countNodes].
	^totalSplitNodes! !
!EntStatistics categoriesFor: #contents!accessing!public! !
!EntStatistics categoriesFor: #count!accessing!public! !
!EntStatistics categoriesFor: #countNodes!private! !
!EntStatistics categoriesFor: #countNodes:!private! !
!EntStatistics categoriesFor: #findMaxDepth!private! !
!EntStatistics categoriesFor: #findMaxDepth:depth:!private! !
!EntStatistics categoriesFor: #maxContentsToShow!accessing!private! !
!EntStatistics categoriesFor: #maxDepth!public! !
!EntStatistics categoriesFor: #root!accessing!private! !
!EntStatistics categoriesFor: #root:!accessing!private! !
!EntStatistics categoriesFor: #totalCollectionLeafs!public! !
!EntStatistics categoriesFor: #totalContentLeafs!public! !
!EntStatistics categoriesFor: #totalNodes!public! !
!EntStatistics categoriesFor: #totalSplitNodes!public! !

!EntStatistics class methodsFor!

root: rootNode
	^self new root: rootNode; yourself! !
!EntStatistics class categoriesFor: #root:!public! !

