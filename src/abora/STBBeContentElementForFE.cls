"Filed out from Dolphin Smalltalk 2002 release 5.00"!

STBProxy subclass: #STBBeContentElementForFE
	instanceVariableNames: 'id class'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
STBBeContentElementForFE guid: (GUID fromString: '{85ED1CEF-B7D0-4224-8ADA-B1B6696FFA1E}')!
STBBeContentElementForFE comment: ''!
!STBBeContentElementForFE categoriesForClass!System-Binary storage! !
!STBBeContentElementForFE methodsFor!

class: aClass
	class := aClass!

id: anObject
	id := anObject! !
!STBBeContentElementForFE categoriesFor: #class:!public! !
!STBBeContentElementForFE categoriesFor: #id:!accessing!private! !

!STBBeContentElementForFE class methodsFor!

for: beContentElement
	^(self basicNew)
		id: beContentElement id;
		class: beContentElement class;
		yourself! !
!STBBeContentElementForFE class categoriesFor: #for:!public! !

