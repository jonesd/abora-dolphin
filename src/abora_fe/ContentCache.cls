"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #ContentCache
	instanceVariableNames: 'cached'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ContentCache guid: (GUID fromString: '{3F8DBD25-E502-4351-88A5-014FE10772C9}')!
ContentCache comment: ''!
!ContentCache categoriesForClass!Kernel-Objects! !
!ContentCache methodsFor!

contentsFrom: position extent: extent do: monadicValuable
	| missing missingContents required hits |
	required := IntegerRegion startPosition: position extent: extent.
	missing := OrderedCollection new.
	hits := cached collect: [:region | region intersects: required].
	
	cached do: [:region | region endPosition < position ifFalse: [
		region startPosition >= (position + extent)]].
	missing add: (IntegerRegion startPosition: position extent: extent).
	missingContents := monadicValuable value: missing.
	self assert: [missing size = missingContents size].
	missing with: missingContents do: [:a :b | self assert: [a extent = b size]].
!

initialize
	super initialize.
	cached := SortedCollection sortBlock: [:a :b | a first <= b first].! !
!ContentCache categoriesFor: #contentsFrom:extent:do:!public! !
!ContentCache categoriesFor: #initialize!public! !

