"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #EntNode
	instanceVariableNames: 'branch'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
EntNode guid: (GUID fromString: '{F7C78A2D-9F11-40CA-BC66-03E928F36116}')!
EntNode comment: ''!
!EntNode categoriesForClass!Kernel-Objects! !
!EntNode methodsFor!

allEditions
	^self allRoots collect: [:root | root edition]!

allRoots
	| roots |
	roots := IdentitySet new.
	self allRoots: roots.
	^roots!

allRoots: allRoots
	self parents do: [:parent | parent allRoots: allRoots]!

basicParentSplit
	^nil!

branch
	^branch!

branch: anObject
	branch := anObject!

children
	self subclassResponsibility!

contents
	self subclassResponsibility!

contentsAt: position
	self subclassResponsibility!

contentsFrom: position extent: extent
	| contents |
	#todo "max:".
extent < 0 ifTrue: [self halt].
	contents := WriteStream on: (Array new: (extent max: 0)).
	self contentsFrom: position extent: extent into: contents.
"	self contentsFrom: position extent: extent do: [:char | contents nextPut: char]."
	^contents contents!

contentsFrom: position extent: extent into: stream
	self subclassResponsibility!

count
	self subclassResponsibility!

duplicateFor: newBranch
	self subclassResponsibility!

duplicateWithParentsFor: newBranch
	| duplicate parent parentDuplicate |
	duplicate := self duplicateFor: newBranch.
	parent := self singleParentFor: newBranch.
	parent notNil 
		ifTrue: 
			[parentDuplicate := parent duplicateWithParentsFor: newBranch.
			parentDuplicate replaceChild: self with: duplicate].
	^duplicate!

ensureCompatibleFor: matchingBranch
	(self isCompatibleFor: matchingBranch) 
		ifFalse: [EntError signal: 'not-compatible ent revision']!

ensureSameFor: matchingBranch
	(self isSameFor: matchingBranch) ifFalse: [EntError signal: 'not-same ent revision']!

findBestParentMatchFor: matchingBranch
	| singleParent |
	singleParent := nil.
	self parents do: 
			[:possibleParent | 
			(possibleParent isSameFor: matchingBranch) ifTrue: [^possibleParent].
			((possibleParent isCompatibleFor: matchingBranch) 
				and: [singleParent isNil or: [possibleParent branch > singleParent branch]]) 
					ifTrue: [singleParent := possibleParent]].
	^singleParent!

isCompatibleFor: matchingBranch
	^self branch isBeforeOrEqual: matchingBranch!

isSameFor: matchingBranch
	^self branch = matchingBranch!

maxNode
	^self children last maxNode!

minNode
	^self children first minNode!

parents
	self subclassResponsibility!

parentSplit: matchingBranch
	| parent |
	parent := self singleParentFor: matchingBranch.
	^parent notNil ifTrue: [parent basicParentSplit] ifFalse: [nil]!

rootFor: matchingBranch
	| parent |
	parent := self singleParentFor: matchingBranch.
	#todo.	"null parent might indicate something gong wrong"
	^parent notNil ifTrue: [parent rootFor: matchingBranch] ifFalse: [nil]!

sharedWith: anotherEdition for: forBranch mappings: mappings
	self children do: 
			[:child | 
			child 
				sharedWith: anotherEdition
				for: forBranch
				mappings: mappings]!

singleParentFor: matchingBranch
	^self parents isEmpty 
		ifTrue: [nil]
		ifFalse: 
			[| singleParent |
			singleParent := self findBestParentMatchFor: matchingBranch.
			#todo.	"investigate the commenting out of the following"
			"self assert: [singleParent notNil]."
			singleParent]!

transclusions: transclusions
	self children do: [:child | child transclusions: transclusions]! !
!EntNode categoriesFor: #allEditions!public! !
!EntNode categoriesFor: #allRoots!public! !
!EntNode categoriesFor: #allRoots:!private! !
!EntNode categoriesFor: #basicParentSplit!private! !
!EntNode categoriesFor: #branch!accessing!public! !
!EntNode categoriesFor: #branch:!accessing!private! !
!EntNode categoriesFor: #children!public! !
!EntNode categoriesFor: #contents!public! !
!EntNode categoriesFor: #contentsAt:!public! !
!EntNode categoriesFor: #contentsFrom:extent:!public! !
!EntNode categoriesFor: #contentsFrom:extent:into:!public! !
!EntNode categoriesFor: #count!public! !
!EntNode categoriesFor: #duplicateFor:!private! !
!EntNode categoriesFor: #duplicateWithParentsFor:!private! !
!EntNode categoriesFor: #ensureCompatibleFor:!private! !
!EntNode categoriesFor: #ensureSameFor:!private! !
!EntNode categoriesFor: #findBestParentMatchFor:!private! !
!EntNode categoriesFor: #isCompatibleFor:!private! !
!EntNode categoriesFor: #isSameFor:!private! !
!EntNode categoriesFor: #maxNode!public! !
!EntNode categoriesFor: #minNode!public! !
!EntNode categoriesFor: #parents!public! !
!EntNode categoriesFor: #parentSplit:!private! !
!EntNode categoriesFor: #rootFor:!private! !
!EntNode categoriesFor: #sharedWith:for:mappings:!public! !
!EntNode categoriesFor: #singleParentFor:!private! !
!EntNode categoriesFor: #transclusions:!public! !

!EntNode class methodsFor!

basicNew
	^(super basicNew)
		initialize;
		yourself!

new
	^self shouldNotImplement! !
!EntNode class categoriesFor: #basicNew!public! !
!EntNode class categoriesFor: #new!public! !

