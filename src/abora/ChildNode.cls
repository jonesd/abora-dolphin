"Filed out from Dolphin Smalltalk 2002 release 5.00"!

EntNode subclass: #ChildNode
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ChildNode guid: (GUID fromString: '{9320B5B0-EBBD-4C2A-B47F-CC2A5BC0735F}')!
ChildNode comment: ''!
!ChildNode categoriesForClass!Kernel-Objects! !
!ChildNode methodsFor!

addToParent: anEntNode
	parents add: anEntNode.!

initialize
	super initialize.
	#todo.	"should this be a set?"
	parents := OrderedCollection new.!

parents
	^parents!

removeFromParent: anEntNode
	parents remove: anEntNode! !
!ChildNode categoriesFor: #addToParent:!private! !
!ChildNode categoriesFor: #initialize!private! !
!ChildNode categoriesFor: #parents!private! !
!ChildNode categoriesFor: #removeFromParent:!private! !

