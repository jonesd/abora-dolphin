"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraFeTests subclass: #ContentCacheTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
ContentCacheTest guid: (GUID fromString: '{FAB437A8-B678-49F3-9C0A-63261CAC4798}')!
ContentCacheTest comment: ''!
!ContentCacheTest categoriesForClass!SUnit! !
!ContentCacheTest methodsFor!

testCreate
	| cache |
	cache := ContentCache new.
	self should: [cache notNil].!

testFirst
	| cache required contents |
	cache := ContentCache new.
	contents := cache contentsFrom: 1 extent: 3 do: [:missing | required := missing. Array with: ('123' asAboraContent)].
	self should: [contents asAboraText = '123'].
	self should: [required = (Array with: (IntegerRegion startPosition: 1 extent: 3))].
	self should: [cache notNil].! !
!ContentCacheTest categoriesFor: #testCreate!public! !
!ContentCacheTest categoriesFor: #testFirst!public! !

