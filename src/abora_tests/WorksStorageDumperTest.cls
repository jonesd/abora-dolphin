"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraBeTests subclass: #WorksStorageDumperTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
WorksStorageDumperTest guid: (GUID fromString: '{11A1E1AE-EF74-4372-B653-E3C42C058D0D}')!
WorksStorageDumperTest comment: ''!
!WorksStorageDumperTest categoriesForClass!Kernel-Objects! !
!WorksStorageDumperTest methodsFor!

lastModifiedTime: filename
	| file |
	file := File open: filename.
	[^file lastWriteTime asInteger] ensure: [file close]!

testBasicLoadWorksStorageFrom
	| readWorksStorage stream dumper existingWorksStorage |
	dumper := WorksStorageDumper new.
	stream := ReadWriteStream on: ByteArray new.
	existingWorksStorage := WorksStorage new.
	dumper basicSaveWorksStorage: existingWorksStorage to: stream.
	stream position: 0.
	readWorksStorage := dumper basicLoadWorksStorageFrom: stream.
	readWorksStorage works isEmpty.
	readWorksStorage idLookup isEmpty!

testBasicLoadWorksStorageFromCorrupted
	| readWorksStorage stream dumper existingWorksStorage |
	dumper := WorksStorageDumper new.
	stream := ReadWriteStream on: ByteArray new.
	self should: [dumper basicLoadWorksStorageFrom: stream] raise: AboraFileError.
	stream := ReadWriteStream on: ByteArray new.
	stream nextPutAll: 'Abora is so great!!' asByteArray.
	stream position: 0.
	self should: [dumper basicLoadWorksStorageFrom: stream] raise: AboraFileError!

testBasicLoadWorksStorageFromIncompatibleVersion
	| readWorksStorage dumper system existingWorksStorage |
	system := WorksStorageDumper new.
	existingWorksStorage := WorksStorage new.
	dumper := ReadWriteStream on: ByteArray new.
	dumper nextPutAll: system fileIdentificationWord.
	dumper nextSDWORDPut: system fileMajorVersion - 1.
	dumper nextSDWORDPut: system fileMinorVersion.
	dumper binaryStore: existingWorksStorage.
	dumper position: 0.
	self should: [system basicLoadWorksStorageFrom: dumper] raise: AboraFileError.
	dumper := ReadWriteStream on: ByteArray new.
	dumper nextPutAll: system fileIdentificationWord.
	dumper nextSDWORDPut: system fileMajorVersion + 1.
	dumper nextSDWORDPut: system fileMinorVersion.
	dumper binaryStore: existingWorksStorage.
	dumper position: 0.
	self should: [system basicLoadWorksStorageFrom: dumper] raise: AboraFileError.
	dumper := ReadWriteStream on: ByteArray new.
	dumper nextPutAll: system fileIdentificationWord.
	dumper nextSDWORDPut: system fileMajorVersion.
	dumper nextSDWORDPut: system fileMinorVersion - 1.
	dumper binaryStore: existingWorksStorage.
	dumper position: 0.
	readWorksStorage := system basicLoadWorksStorageFrom: dumper.
	self should: [readWorksStorage notNil].
	dumper := ReadWriteStream on: ByteArray new.
	dumper nextPutAll: system fileIdentificationWord.
	dumper nextSDWORDPut: system fileMajorVersion.
	dumper nextSDWORDPut: system fileMinorVersion + 1.
	dumper binaryStore: existingWorksStorage.
	dumper position: 0.
	readWorksStorage := system basicLoadWorksStorageFrom: dumper.
	self should: [readWorksStorage notNil]!

testBasicSaveAndLoad
	| readWorksStorage stream dumper existingWorksStorage existingWork |
	dumper := WorksStorageDumper new.
	existingWorksStorage := WorksStorage new.
	existingWork := BeWork in: existingWorksStorage
				edition: (BeEdition contents: 'hello there' asAboraContent).
	stream := ReadWriteStream on: ByteArray new.
	dumper basicSaveWorksStorage: existingWorksStorage to: stream.
	stream position: 0.
	readWorksStorage := dumper basicLoadWorksStorageFrom: stream.
	self should: [readWorksStorage works size = 1].
	self should: 
			[readWorksStorage works asArray first edition contents = 'hello there' asAboraContent]!

testDoesWorksStorageFileExist
	| readWorksStorage stream dumper existingWorksStorage existingWork realSystem |
	dumper := WorksStorageDumper new.
	(File exists: dumper worksStorageFilename) 
		ifTrue: [File delete: dumper worksStorageFilename].
	self shouldnt: [dumper doesWorksStorageFileExist].
	dumper dumpWorksStorage.
	self should: [dumper doesWorksStorageFileExist]!

testDumpWorksStorage
	| readWorksStorage stream dumper existingWorksStorage existingWork realSystem time1 time2 time3 |
	dumper := WorksStorageDumper new.
	(File exists: dumper worksStorageFilename) 
		ifTrue: [File delete: dumper worksStorageFilename].
	(File exists: dumper worksStorageOldFilename) 
		ifTrue: [File delete: dumper worksStorageOldFilename].
	dumper dumpWorksStorage.
	self should: [File exists: dumper worksStorageFilename].
	time1 := self lastModifiedTime: dumper worksStorageFilename.
	self shouldnt: [File exists: dumper worksStorageOldFilename].
	dumper dumpWorksStorage.
	self should: [File exists: dumper worksStorageFilename].
	time2 := self lastModifiedTime: dumper worksStorageFilename.
	self shouldnt: [time1 = time2].
	self should: [File exists: dumper worksStorageOldFilename].
	self should: [(self lastModifiedTime: dumper worksStorageOldFilename) = time1].
	dumper dumpWorksStorage.
	self should: [File exists: dumper worksStorageFilename].
	time3 := self lastModifiedTime: dumper worksStorageFilename.
	self shouldnt: [time2 = time3].
	self should: [File exists: dumper worksStorageOldFilename].
	self should: [(self lastModifiedTime: dumper worksStorageOldFilename) = time2]! !
!WorksStorageDumperTest categoriesFor: #lastModifiedTime:!private! !
!WorksStorageDumperTest categoriesFor: #testBasicLoadWorksStorageFrom!public! !
!WorksStorageDumperTest categoriesFor: #testBasicLoadWorksStorageFromCorrupted!public! !
!WorksStorageDumperTest categoriesFor: #testBasicLoadWorksStorageFromIncompatibleVersion!public! !
!WorksStorageDumperTest categoriesFor: #testBasicSaveAndLoad!public! !
!WorksStorageDumperTest categoriesFor: #testDoesWorksStorageFileExist!public! !
!WorksStorageDumperTest categoriesFor: #testDumpWorksStorage!public! !

