"Filed out from Dolphin Smalltalk 2002 release 5.00"!

ImageStripper subclass: #AboraImageStripper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraImageStripper guid: (GUID fromString: '{CBB8FC37-3A13-4DAA-9F38-9B331DF8F2EF}')!
AboraImageStripper comment: ''!
!AboraImageStripper categoriesForClass!MVP-Models! !
!AboraImageStripper methodsFor!

checkPackageNames: names
	names do: [:name | PackageManager current packageNamed: name].!

requiredPackageNames
	"Answers a <Set> of the names of the packages required by application. These should already 
	have been loaded into the image."

	| names |
	names := super requiredPackageNames.
	names add: 'abora'.
	names add: 'abora_dev'.
	names add: 'abora_fe'.
	names add: 'abora_fe_ui'.
"	names add: 'Sockets Connection'."
	self checkPackageNames: names.
	^names! !
!AboraImageStripper categoriesFor: #checkPackageNames:!private! !
!AboraImageStripper categoriesFor: #requiredPackageNames!public! !

