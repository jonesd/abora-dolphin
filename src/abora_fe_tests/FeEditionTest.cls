"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #FeEditionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeEditionTest guid: (GUID fromString: '{55B1BFC7-70E2-42D6-9493-FBE5DBB862E0}')!
FeEditionTest comment: ''!
!FeEditionTest categoriesForClass!SUnit! !
!FeEditionTest methodsFor!

testAppend
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	newEdition := feEdition append: 'abc' asAboraContent.

	self should: [newEdition contents = '1234567890abc' asAboraContent].
	self should: [feEdition contents = '1234567890' asAboraContent].
	self should: [newEdition beEdition ~~ newEdition].
	eventReceiver addExpectedEvent: #editionUpdatedTo: with: newEdition.
	eventReceiver verify: self.!

testCreateContents
	| feEdition |
	feEdition := FeEdition contents: '1234567890' asAboraContent.

	self should: [feEdition contents = '1234567890' asAboraContent].
	self should: [feEdition count = 10].
	self should: [feEdition beEdition ~~ feEdition].
	self should: [feEdition beEdition count = 10].!

testCreateEmpty
	| feEdition |
	feEdition := FeEdition empty.

	self should: [feEdition count = 0].
	self should: [feEdition beEdition ~~ feEdition].
	self should: [feEdition beEdition count = 0].!

testInsertAt
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	newEdition := feEdition insert: 'abc' asAboraContent at: 3.

	self should: [newEdition contents = '12abc34567890' asAboraContent].
	self should: [feEdition contents = '1234567890' asAboraContent].
	self should: [newEdition beEdition ~~ newEdition].
	eventReceiver addExpectedEvent: #editionUpdatedTo: with: newEdition.
	eventReceiver verify: self.!

testInsertAtBadPosition
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	self should: [feEdition insert: 'abc' asAboraContent at: 12] raise: AboraRemoteError.

	self should: [feEdition contents = '1234567890' asAboraContent].
	eventReceiver verify: self.!

testInvertMappings
	| feEdition start inverted expected |
	feEdition := FeEdition contents: '1234567890' asAboraContent.

	start := OrderedCollection new.
	inverted := feEdition invertMappings: start.
	self should: [inverted isEmpty].

	start := OrderedCollection with: (Array with: (IntegerRegion startPosition: 1 extent: 2) with: (IntegerRegion startPosition: 10 extent: 2)).
	inverted := feEdition invertMappings: start.
	expected := OrderedCollection with: (Array with: (IntegerRegion startPosition: 10 extent: 2) with: (IntegerRegion startPosition: 1 extent: 2)).
	self should: [inverted = expected].

	start := OrderedCollection with: (Array with: (IntegerRegion startPosition: 1 extent: 2) with: (IntegerRegion startPosition: 10 extent: 2)) with: (Array with: (IntegerRegion startPosition: 3 extent: 1) with: (IntegerRegion startPosition: 13 extent: 1)).
	inverted := feEdition invertMappings: start.
	expected := OrderedCollection with: (Array with: (IntegerRegion startPosition: 10 extent: 2) with: (IntegerRegion startPosition: 1 extent: 2)) with: (Array with: (IntegerRegion startPosition: 13 extent: 1) with: (IntegerRegion startPosition: 3 extent: 1)).
	self should: [inverted = expected].



!

testOn
	| beEdition feEdition feEdition2 |
	beEdition := BeEdition contents: '1234567890' asAboraContent.
	feEdition := FeEdition on: beEdition.

	self should: [feEdition contents = '1234567890' asAboraContent].
	self should: [feEdition count = 10].
	self should: [feEdition beEdition == beEdition].

	feEdition2 := FeEdition on: beEdition.
	self should: [feEdition2 == feEdition].
	self should: [feEdition2 contents = '1234567890' asAboraContent].
	self should: [feEdition2 count = 10].
	self should: [feEdition2 beEdition == beEdition].
!

testRemoveFromExtent
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	newEdition := feEdition removeFrom: 3 extent: 2.

	self should: [newEdition contents = '12567890' asAboraContent].
	self should: [feEdition contents = '1234567890' asAboraContent].
	self should: [newEdition beEdition ~~ newEdition].
	eventReceiver addExpectedEvent: #editionUpdatedTo: with: newEdition.
	eventReceiver verify: self.!

testRemoveFromExtentBadExtent
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	self should: [feEdition removeFrom: 10 extent: 2] raise: AboraRemoteError.

	self should: [feEdition contents = '1234567890' asAboraContent].
	eventReceiver verify: self.!

testRemoveFromExtentBadFrom
	| feEdition newEdition eventReceiver |
	feEdition := FeEdition contents: '1234567890' asAboraContent.
	eventReceiver := MockEventReceiver new.
	feEdition when: #editionUpdatedTo: sendTo: eventReceiver.

	"actual test"
	self should: [feEdition removeFrom: 11 extent: 2] raise: AboraRemoteError.

	self should: [feEdition contents = '1234567890' asAboraContent].
	eventReceiver verify: self.!

testSharedWith
	| edition1 edition2 mappings |
	edition1 := FeEdition contents: '1234567890' asAboraContent.
	edition2 := edition1 insert: 'abcd' asAboraContent at: 4.

	"actual test"
	mappings := edition1 sharedWith: edition2.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings second first = (IntegerRegion startPosition: 4 extent: 7)].
	self should: [mappings second last = (IntegerRegion startPosition: 8 extent: 7)].

	mappings := edition2 sharedWith: edition1.
	self should: [mappings size = 2].
	self should: [mappings first first = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings first last = (IntegerRegion startPosition: 1 extent: 3)].
	self should: [mappings second first = (IntegerRegion startPosition: 8 extent: 7)].
	self should: [mappings second last = (IntegerRegion startPosition: 4 extent: 7)].
!

testToBeContent
	| beContent beEdition1 feEdition1 beEdition2 feEdition2 beEdition3 feEdition3 beWork3 feWork3 |
	beEdition1 := BeEdition new.
	feEdition1 := FeEdition on: beEdition1.
	beEdition2 := BeEdition contents: (BeDataHolder value: 1).
	feEdition2 := FeEdition on: beEdition2.
	beEdition3 := BeEdition contents: '123' asAboraContent.
	feEdition3 := FeEdition on: beEdition3.
	beWork3 := BeWork edition: beEdition3.
	feWork3 := FeWork on: beWork3.

	beContent := FeEdition toBeContent: #().
	self should: [beContent = #()].

	beContent := FeEdition toBeContent: '123' asAboraContent.
	self should: [beContent = '123' asAboraContent].

	beContent := FeEdition toBeContent: feEdition1.
	self should: [beContent == beEdition1].

	beContent := FeEdition toBeContent: feWork3.
	self should: [beContent == beWork3].

	beContent := FeEdition toBeContent: (Array with: feEdition1 with: feWork3).
	self should: [beContent size = 2].
	self should: [beContent first == beEdition1].
	self should: [beContent second == beWork3].


!

testToFeContent
	| feContent beEdition1 beEdition2 beEdition3 beWork3 |
	beEdition1 := BeEdition new.
	beEdition2 := BeEdition contents: (BeDataHolder value: 1).
	beEdition3 := BeEdition contents: '123' asAboraContent.
	beWork3 := BeWork edition: beEdition3.

	feContent := FeEdition toFeContent: #().
	self should: [feContent = #()].
	feContent := FeEdition toFeContent: '123' asAboraContent.
	self should: [feContent = '123' asAboraContent].

	feContent := FeEdition toFeContent: beEdition1.
	self should: [feContent beEdition == beEdition1].
	self should: [feContent count = 0].
	feContent := FeEdition toFeContent: beWork3.
	self should: [feContent beWork == beWork3].
	self should: [feContent edition count = 3].
	feContent := FeEdition toFeContent: (Array with: beEdition1 with: beWork3).
	self should: [feContent size  = 2].
	self should: [(feContent first) beEdition == beEdition1].
	self should: [(feContent second) beWork == beWork3].
! !
!FeEditionTest categoriesFor: #testAppend!public! !
!FeEditionTest categoriesFor: #testCreateContents!public! !
!FeEditionTest categoriesFor: #testCreateEmpty!public! !
!FeEditionTest categoriesFor: #testInsertAt!public! !
!FeEditionTest categoriesFor: #testInsertAtBadPosition!public! !
!FeEditionTest categoriesFor: #testInvertMappings!public! !
!FeEditionTest categoriesFor: #testOn!public! !
!FeEditionTest categoriesFor: #testRemoveFromExtent!public! !
!FeEditionTest categoriesFor: #testRemoveFromExtentBadExtent!public! !
!FeEditionTest categoriesFor: #testRemoveFromExtentBadFrom!public! !
!FeEditionTest categoriesFor: #testSharedWith!public! !
!FeEditionTest categoriesFor: #testToBeContent!public! !
!FeEditionTest categoriesFor: #testToFeContent!public! !

