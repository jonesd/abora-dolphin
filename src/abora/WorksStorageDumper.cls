"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #WorksStorageDumper
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WorksStorageDumper guid: (GUID fromString: '{3E94F088-E302-495F-BE95-D87AA60B1F35}')!
WorksStorageDumper comment: ''!
!WorksStorageDumper categoriesForClass!Kernel-Objects! !
!WorksStorageDumper methodsFor!

baseDirectory
	^File splitPathFrom: SessionManager current argv first
!

basicLoadWorksStorageFrom: binaryStream
	| worksStorage identificationWord majorVersion minorVersion |
	(binaryStream size <= 12 
		or: [(identificationWord := binaryStream next: 4) ~= self fileIdentificationWord]) 
			ifTrue: [AboraFileError signal: 'Does not appear to be an Abora saved file'].
	majorVersion := binaryStream nextSDWORD.
	minorVersion := binaryStream nextSDWORD.
	majorVersion ~= self fileMajorVersion 
		ifTrue: 
			[AboraFileError 
				signal: 'Version of file format: "' , (self displayVersionMajor: majorVersion minor: minorVersion),  '" is incompatible with current application: "', (self displayVersionMajor: self fileMajorVersion minor: self fileMinorVersion),'"'].
	worksStorage := Object binaryReadFrom: binaryStream.
	#todo.	"some kind of hack as I was sometimes getting DNU STBIdentityDictionaryProxy>>elementsExpired:of:"
	worksStorage idLookup postResize: worksStorage idLookup.
	^worksStorage!

basicSaveWorksStorage: worksStorage to: binaryStream
	binaryStream
		nextPutAll: self fileIdentificationWord;
		nextSDWORDPut: self fileMajorVersion;
		nextSDWORDPut: self fileMinorVersion;
		binaryStore: worksStorage!

displayVersionMajor: majorVersion minor: minorVersion
	^majorVersion displayString, '.', minorVersion displayString!

doesWorksStorageFileExist
	^File exists: self worksStorageFilename!

dumpWorksStorage
	"Try to flush out any delayed mourning"

	| fileStream |
	(MemoryManager current)
		compact;
		administerLastRites;
		directFunerals.
	(File exists: self worksStorageOldFilename) 
		ifTrue: [File delete: self worksStorageOldFilename].
	(File exists: self worksStorageFilename) 
		ifTrue: [File rename: self worksStorageFilename to: self worksStorageOldFilename].
	fileStream := FileStream 
				write: self worksStorageFilename
				mode: #create
				check: false
				text: false.
	[self basicSaveWorksStorage: WorksStorage current to: fileStream] 
		ensure: [fileStream close]!

fileIdentificationWord
	^'ABOR' asByteArray!

fileMajorVersion
	^3!

fileMinorVersion
	^1!

restoreWorksStorage
	| fileStream worksStorage |
	fileStream := FileStream read: self worksStorageFilename text: false.
	[worksStorage := self basicLoadWorksStorageFrom: fileStream] ensure: [fileStream close].
	WorksStorage current: worksStorage!

worksStorageFilename
	^self baseDirectory, self worksStorageShortFilename
!

worksStorageOldFilename
	^self worksStorageFilename, '.OLD'!

worksStorageShortFilename
	^'workstorage.abora'
! !
!WorksStorageDumper categoriesFor: #baseDirectory!private! !
!WorksStorageDumper categoriesFor: #basicLoadWorksStorageFrom:!private! !
!WorksStorageDumper categoriesFor: #basicSaveWorksStorage:to:!private! !
!WorksStorageDumper categoriesFor: #displayVersionMajor:minor:!private! !
!WorksStorageDumper categoriesFor: #doesWorksStorageFileExist!public! !
!WorksStorageDumper categoriesFor: #dumpWorksStorage!public! !
!WorksStorageDumper categoriesFor: #fileIdentificationWord!private! !
!WorksStorageDumper categoriesFor: #fileMajorVersion!private! !
!WorksStorageDumper categoriesFor: #fileMinorVersion!private! !
!WorksStorageDumper categoriesFor: #restoreWorksStorage!public! !
!WorksStorageDumper categoriesFor: #worksStorageFilename!private! !
!WorksStorageDumper categoriesFor: #worksStorageOldFilename!private! !
!WorksStorageDumper categoriesFor: #worksStorageShortFilename!private! !

