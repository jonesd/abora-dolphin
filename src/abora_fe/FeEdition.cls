"Filed out from Dolphin Smalltalk 2002 release 5.00"!

FeContentElement subclass: #FeEdition
	instanceVariableNames: 'beEdition cachedCount cachedContents cacheLock cachedSharedWith'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeEdition guid: (GUID fromString: '{97905F69-BD90-49F4-B5B7-E79EC84B9471}')!
FeEdition comment: ''!
!FeEdition categoriesForClass!MVP-Models! !
!FeEdition methodsFor!

append: feContent
	| beContent |
	beContent := self toBeContent: feContent.
	^self updateEditionWith: [self beEdition append: beContent]!

assignCached: valuable
	Processor forkMainIfMain.
	^cacheLock critical: valuable!

beEdition
	^beEdition!

beEdition: anEdition
	beEdition := anEdition!

cachedSharedWithOrNil: anotherEdition
	^cachedSharedWith notNil 
		ifTrue: [cachedSharedWith at: anotherEdition id ifAbsent: [nil]]
		ifFalse: [nil]!

contents
	#todo "position assumptions".
	^cachedContents ifNil: 
			[self assignCached: 
					[cachedContents ifNil: 
							[| text |
							text := self beEdition contents.
							cachedContents := self toFeContent: text.
							cachedCount := cachedContents size.
							cachedContents]]].
!

contentsFrom: start extent: extent
	^self contents copyFrom: start to: start + extent - 1!

count
	^cachedCount 
		ifNil: [self assignCached: [cachedCount ifNil: [cachedCount := self beEdition count]]]!

endorse: anEndorsement
	beEdition endorse: anEndorsement!

endorsements
	^beEdition endorsements!

id
	^beEdition id!

initialize
	super initialize.

	cacheLock := Semaphore forMutualExclusion.!

insert: feContent at: position
	| beContent |
	beContent := self toBeContent: feContent.
	^self updateEditionWith: [self beEdition insert: beContent at: position]!

invertMappings: mappings
	^mappings collect: [:map | map reverse].!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '(id='.
	self id displayOn: aStream.
	aStream nextPutAll: ')'
!

removeFrom: position extent: extent
	^self updateEditionWith: [self beEdition removeFrom: position extent: extent]!

retract: anEndorsement
	beEdition retract: anEndorsement!

sharedWith: anotherEdition
	| mappings |
	Processor forkMainIfMain.
	mappings := self cachedSharedWithOrNil: anotherEdition.
	^mappings ifNil: 
			[self assignCached: 
					[cachedSharedWith ifNil: [cachedSharedWith := SharedLookupTable new].
					cachedSharedWith at: anotherEdition id
						ifAbsentPut: 
							[| invertedMappings |
							invertedMappings := anotherEdition cachedSharedWithOrNil: self.
							invertedMappings notNil 
								ifTrue: [self invertMappings: invertedMappings]
								ifFalse: [beEdition sharedWith: anotherEdition beEdition]]]]!

toBeContent: content
	#todo.
	^self class toBeContent: content!

toFeContent: content
	^self class toFeContent: content!

transcludeEdition: transcludeEdition from: from extent: extent to: to
	^self updateEditionWith: 
			[self beEdition 
				transcludeEdition: transcludeEdition beEdition
				from: from
				extent: extent
				to: to]!

transclusions
	^self toFeContent: (beEdition transclusions)!

transclusionsDirect
	^self toFeContent: (beEdition transclusionsDirect)!

transclusionsDirectFilteredBy: filter
	^self toFeContent: (beEdition transclusionsDirectFilteredBy: filter)!

transclusionsFilteredBy: filter
	^self toFeContent: (beEdition transclusionsFilteredBy: filter)!

transclusionsFrom: start extent: extent filteredBy: filter
	^self toFeContent: (beEdition transclusionsFrom: start extent: extent filteredBy: filter)!

updateEditionWith: monadic
	| newBeEdition newFeEdition |
	newBeEdition := monadic value.
	newFeEdition := FeEdition on: newBeEdition.
	self trigger: #editionUpdatedTo: with: newFeEdition.
	^newFeEdition!

works
	^self toFeContent: beEdition works! !
!FeEdition categoriesFor: #append:!public! !
!FeEdition categoriesFor: #assignCached:!private! !
!FeEdition categoriesFor: #beEdition!public! !
!FeEdition categoriesFor: #beEdition:!private! !
!FeEdition categoriesFor: #cachedSharedWithOrNil:!private! !
!FeEdition categoriesFor: #contents!public! !
!FeEdition categoriesFor: #contentsFrom:extent:!public! !
!FeEdition categoriesFor: #count!public! !
!FeEdition categoriesFor: #endorse:!public! !
!FeEdition categoriesFor: #endorsements!public! !
!FeEdition categoriesFor: #id!public! !
!FeEdition categoriesFor: #initialize!private! !
!FeEdition categoriesFor: #insert:at:!public! !
!FeEdition categoriesFor: #invertMappings:!private! !
!FeEdition categoriesFor: #printOn:!public! !
!FeEdition categoriesFor: #removeFrom:extent:!public! !
!FeEdition categoriesFor: #retract:!public! !
!FeEdition categoriesFor: #sharedWith:!public! !
!FeEdition categoriesFor: #toBeContent:!private! !
!FeEdition categoriesFor: #toFeContent:!private! !
!FeEdition categoriesFor: #transcludeEdition:from:extent:to:!public! !
!FeEdition categoriesFor: #transclusions!public! !
!FeEdition categoriesFor: #transclusionsDirect!public! !
!FeEdition categoriesFor: #transclusionsDirectFilteredBy:!public! !
!FeEdition categoriesFor: #transclusionsFilteredBy:!public! !
!FeEdition categoriesFor: #transclusionsFrom:extent:filteredBy:!public! !
!FeEdition categoriesFor: #updateEditionWith:!private! !
!FeEdition categoriesFor: #works!public! !

!FeEdition class methodsFor!

contents: feContent
	| beEdition |
	beEdition := FeServer current createEditionWithContents: (self toBeContent: feContent).
	^self on: beEdition!

empty
	| beEdition |
	beEdition := FeServer current createEditionEmpty.
	^self on: beEdition!

on: beEdition
	| feEdition |
	feEdition := FeIdLookup current lookupId: beEdition id
				ifAbsentPut: 
					[(self new)
						beEdition: beEdition;
						yourself].
	self assert: [feEdition isKindOf: self].
	^feEdition!

toBeContent: content
	"Private -  may not be edition here"

	#todo.
	(content isKindOf: FeEdition) ifTrue: [^content beEdition].
	(content isKindOf: FeWork) ifTrue: [^content beWork].
	^content collect: [:fe | (fe isKindOf: FeEdition) ifTrue: [fe beEdition] ifFalse: [(fe isKindOf: FeWork) ifTrue: [fe beWork] ifFalse: [fe]]]!

toFeContent: content
	" may not be edition here"

	| feContent |
	#todo.
	feContent := self toFeContentIndividual: content.
	feContent == content ifTrue: [
		feContent := content collect: [:be | self toFeContentIndividual: be]].
	^feContent!

toFeContentIndividual: content
	" may not be edition here"

	#todo.
	#todo "dont use isKindOf: as we could be dealing with FeProxy".
	(content class == BeEdition) ifTrue: [^FeEdition on: content].
	(content class == BeWork) ifTrue: [^FeWork on: content].
	(content class == BeClub) ifTrue: [^FeClub on: content].
	^content! !
!FeEdition class categoriesFor: #contents:!public! !
!FeEdition class categoriesFor: #empty!public! !
!FeEdition class categoriesFor: #on:!public! !
!FeEdition class categoriesFor: #toBeContent:!private! !
!FeEdition class categoriesFor: #toFeContent:!private! !
!FeEdition class categoriesFor: #toFeContentIndividual:!private! !

