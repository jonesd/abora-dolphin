"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #TranscriptAppender
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
TranscriptAppender guid: (GUID fromString: '{4A867F99-9CA6-42DF-A225-239773E59C64}')!
TranscriptAppender comment: ''!
!TranscriptAppender categoriesForClass!Kernel-Objects! !
!TranscriptAppender methodsFor!

append: level name: name message: message
	'[' displayOn: Transcript.
	name displayOn: Transcript.
	'] ' displayOn: Transcript.
	level displayOn: Transcript.
	' - ' displayOn: Transcript.
	message displayOn: Transcript.
	Transcript
		cr;
		flush
! !
!TranscriptAppender categoriesFor: #append:name:message:!public! !

