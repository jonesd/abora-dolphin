"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #EntStatisticsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EntStatisticsTest guid: (GUID fromString: '{3BC07268-75C9-4C41-B1D5-9FBB3CF9D74E}')!
EntStatisticsTest comment: ''!
!EntStatisticsTest categoriesForClass!Kernel-Objects! !
!EntStatisticsTest methodsFor!

assertEntStatistics: actual hasTotalNodes: expectedTotalNodes totalCollectionLeafs: expectedTotalData totalSplitNodes: expectedTotalSplit totalContentLeafs: expectedTotalTranscluded maxDepth: expectedMaxDepth count: expectedCount contents: expectedContents
	self should: [actual totalNodes = expectedTotalNodes].
	self should: [actual totalCollectionLeafs = expectedTotalData].
	self should: [actual totalSplitNodes = expectedTotalSplit].
	self should: [actual totalContentLeafs = expectedTotalTranscluded].
	self should: [actual maxDepth = expectedMaxDepth].
	self should: [actual count = expectedCount].
	self should: [actual contents = expectedContents]!

test12345678
	| root stats |
	root := self createBalanced12345678.
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 15
		totalCollectionLeafs: 8
		totalSplitNodes: 7
		totalContentLeafs: 0
		maxDepth: 5
		count: 8
		contents: '12345678'!

testContentsMax
	| root stats |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '1234567890123456789012345678901234567890123456789' asAboraContent).
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 1
		totalCollectionLeafs: 1
		totalSplitNodes: 0
		totalContentLeafs: 0
		maxDepth: 2
		count: 49
		contents: '1234567890123456789012345678901234567890123456789'!

testContentsPastTrimmed
	| root stats |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '123456789012345678901234567890123456789012345678901' asAboraContent).
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 1
		totalCollectionLeafs: 1
		totalSplitNodes: 0
		totalContentLeafs: 0
		maxDepth: 2
		count: 51
		contents: '12345678901234567890123456789012345678901234567890...'!

testContentsTrimmed
	| root stats |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: '12345678901234567890123456789012345678901234567890' asAboraContent).
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 1
		totalCollectionLeafs: 1
		totalSplitNodes: 0
		totalContentLeafs: 0
		maxDepth: 2
		count: 50
		contents: '12345678901234567890123456789012345678901234567890...'!

testEmpty
	| root stats |
	root := RootNode edition: nil branch: 1.
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 0
		totalCollectionLeafs: 0
		totalSplitNodes: 0
		totalContentLeafs: 0
		maxDepth: 1
		count: 0
		contents: ''!

testSingleCollectionLeaf
	| root stats |
	root := RootNode 
				edition: nil
				branch: 1
				with: (CollectionLeaf 
						branch: 1
						startPosition: 1
						elements: 'ab' asAboraContent).
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 1
		totalCollectionLeafs: 1
		totalSplitNodes: 0
		totalContentLeafs: 0
		maxDepth: 2
		count: 2
		contents: 'ab'!

testSingleContentLeaf
	| root stats |
	root := RootNode 
				edition: nil
				branch: 1
				with: (ContentLeaf 
						branch: 1
						startPosition: 1
						contentElement: (BeDataHolder value: 85)).
	stats := EntStatistics root: root.
	self 
		assertEntStatistics: stats
		hasTotalNodes: 1
		totalCollectionLeafs: 0
		totalSplitNodes: 0
		totalContentLeafs: 1
		maxDepth: 2
		count: 1
		contents: '#(a BeDataHolder(85))'! !
!EntStatisticsTest categoriesFor: #assertEntStatistics:hasTotalNodes:totalCollectionLeafs:totalSplitNodes:totalContentLeafs:maxDepth:count:contents:!public! !
!EntStatisticsTest categoriesFor: #test12345678!public! !
!EntStatisticsTest categoriesFor: #testContentsMax!public! !
!EntStatisticsTest categoriesFor: #testContentsPastTrimmed!public! !
!EntStatisticsTest categoriesFor: #testContentsTrimmed!public! !
!EntStatisticsTest categoriesFor: #testEmpty!public! !
!EntStatisticsTest categoriesFor: #testSingleCollectionLeaf!public! !
!EntStatisticsTest categoriesFor: #testSingleContentLeaf!public! !

