"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeIdLookup
	instanceVariableNames: 'idLookup'
	classVariableNames: 'Current'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeIdLookup guid: (GUID fromString: '{9EDB740E-0D5E-4CB4-AACF-0D7C6010EE11}')!
FeIdLookup comment: ''!
!FeIdLookup categoriesForClass!Kernel-Objects! !
!FeIdLookup methodsFor!

addId: id with: value
	idLookup at: id put: value!

initialize
	super initialize.

	idLookup := WeakLookupTable new.!

lookupId: id
	^idLookup at: id
!

lookupId: id ifAbsentPut: block
	^idLookup at: id ifAbsentPut: block
!

registerFe: feContentElement
	self addId: feContentElement id with: feContentElement!

size
	^idLookup size! !
!FeIdLookup categoriesFor: #addId:with:!public! !
!FeIdLookup categoriesFor: #initialize!private! !
!FeIdLookup categoriesFor: #lookupId:!public! !
!FeIdLookup categoriesFor: #lookupId:ifAbsentPut:!public! !
!FeIdLookup categoriesFor: #registerFe:!public! !
!FeIdLookup categoriesFor: #size!public! !

!FeIdLookup class methodsFor!

current
	^Current!

initialize
"Private - 
self initialize.
"

	Current := self basicNew initialize.!

new
	self shouldNotImplement! !
!FeIdLookup class categoriesFor: #current!public! !
!FeIdLookup class categoriesFor: #initialize!private! !
!FeIdLookup class categoriesFor: #new!public! !

