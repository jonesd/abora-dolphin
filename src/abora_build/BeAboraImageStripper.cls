"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ImageStripper subclass: #BeAboraImageStripper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
BeAboraImageStripper guid: (GUID fromString: '{4D56F1E3-6AFE-4425-8922-0413816FAB16}')!
BeAboraImageStripper comment: ''!
!BeAboraImageStripper categoriesForClass!MVP-Models! !
!BeAboraImageStripper methodsFor!

checkPackageNames: names
	names do: [:name | PackageManager current packageNamed: name].!

requiredClasses
	"Answer an IdentitySet of Classes that are known to be required and that
	should be preserved during an image strip. Can be overridden by subclasses to alter the stripping
	strategy"

	^(super requiredClasses)
		add: STBBeContentElementForBE;
		yourself!

requiredPackageNames
	"Answers a <Set> of the names of the packages required by application. These should already 
	have been loaded into the image."

	| names |
	names := super requiredPackageNames.
	names add: 'abora'.
	names add: 'abora_dev'.
	names add: 'abora_be_ui'.
	names add: 'Sockets Connection'.
	self checkPackageNames: names.
	^names! !
!BeAboraImageStripper categoriesFor: #checkPackageNames:!private! !
!BeAboraImageStripper categoriesFor: #requiredClasses!public! !
!BeAboraImageStripper categoriesFor: #requiredPackageNames!public! !

