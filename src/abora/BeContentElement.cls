"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #BeContentElement
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeContentElement guid: (GUID fromString: '{29FCADDE-72E1-4551-88EA-D8C71B0A338A}')!
BeContentElement comment: ''!
!BeContentElement categoriesForClass!Kernel-Objects! !
!BeContentElement methodsFor!

addParent: parent
	parents add: parent!

createNodeAt: position for: forRevision
	^ContentLeaf 
		branch: forRevision
		startPosition: position
		contentElement: self!

filterTransclusions: editions by: filter
	^editions select: [:edition | filter allSatisfy: [:requiredEdition | edition endorsements includes: requiredEdition]].!

initialize
	super initialize.

	parents := OrderedCollection new.!

makeFeProxy
	self subclassResponsibility!

parents
	^parents!

removeParent: parent
	parents remove: parent!

stbSaveOn: anSTBOutFiler
	(anSTBOutFiler context isKindOf: BeSession) 
		ifTrue: 
			[anSTBOutFiler context addFeContentElementFor: self.
			anSTBOutFiler saveObject: self as: (STBBeContentElementForFE for: self)]
		ifFalse: 
			[self assert: [anSTBOutFiler context ~~ #forBe].
			"self halt."
			super stbSaveOn: anSTBOutFiler]!

transclusionsDirect
	"return an edition"

	| editions |
	#todo.
	editions := IdentitySet new.
	self parents do: [:leaf | editions addAll: leaf allEditions].
	editions remove: self
		ifAbsent: 
			["ignore"

			].
	^editions!

transclusionsDirectFilteredBy: filter
	| editions |
	editions := self transclusionsDirect.
	^self filterTransclusions: editions by: filter
! !
!BeContentElement categoriesFor: #addParent:!must not strip!public! !
!BeContentElement categoriesFor: #createNodeAt:for:!must not strip!public! !
!BeContentElement categoriesFor: #filterTransclusions:by:!must not strip!public! !
!BeContentElement categoriesFor: #initialize!private! !
!BeContentElement categoriesFor: #makeFeProxy!private! !
!BeContentElement categoriesFor: #parents!must not strip!public! !
!BeContentElement categoriesFor: #removeParent:!must not strip!public! !
!BeContentElement categoriesFor: #stbSaveOn:!private! !
!BeContentElement categoriesFor: #transclusionsDirect!must not strip!public! !
!BeContentElement categoriesFor: #transclusionsDirectFilteredBy:!must not strip!public! !

