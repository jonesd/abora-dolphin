"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraTests subclass: #AboraFeTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraFeTests guid: (GUID fromString: '{50BCD944-20E9-4603-8598-666999324295}')!
AboraFeTests comment: ''!
!AboraFeTests categoriesForClass!SUnit! !
!AboraFeTests class methodsFor!

isAbstract
	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^self name = #AboraFeTests! !
!AboraFeTests class categoriesFor: #isAbstract!public! !

