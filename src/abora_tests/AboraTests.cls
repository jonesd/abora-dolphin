"Filed out from Dolphin Smalltalk 2002 release 5.00"!

TestCase subclass: #AboraTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraTests guid: (GUID fromString: '{1E032C10-7CA9-4E86-BC7D-27234622C511}')!
AboraTests comment: ''!
!AboraTests categoriesForClass!SUnit! !
!AboraTests class methodsFor!

isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self name = #AboraTests! !
!AboraTests class categoriesFor: #isAbstract!public! !

