"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Presenter subclass: #LoggerPresenter
	instanceVariableNames: 'outputWindow buffer bufferProtect'
	classVariableNames: 'LevelFormatting Prologue'
	poolDictionaries: 'LoggerConstants'
	classInstanceVariableNames: ''!
LoggerPresenter guid: (GUID fromString: '{1B59485B-B97D-4FCD-87D4-009276D16144}')!
LoggerPresenter comment: ''!
!LoggerPresenter categoriesForClass!MVP-Presenters! !
!LoggerPresenter methodsFor!

append: level name: loggerName message: message
	self nextPutAll: '{'.
	#todo "performance hack - at lest review reaching".
	level = DebugLevel ifFalse: [
		self nextPutAll: Prologue.
		self nextPutAll: (self formattingFor: level)].
	'[' displayOn: self.
	loggerName displayOn: self.
	'] ' displayOn: self.
	level name displayOn: self.
	' : ' displayOn: self.
	message displayOn: self.
	self nextPutAll: '\par '.
	self nextPutAll: '}'.
	self flush.!

clear
	"Remove all contents in the receiver's view"

	self flush.
	self view clear.!

contents
	"Answer all of the objects in the collection accessed by the receiver.
	Generally the collection will be the same class as the one accessed by the receiver."

	| text |
	text := self view plainText.
	bufferProtect critical: [text := text, buffer contents].
	^text!

createSchematicWiring
	"Create the trigger wiring for the receiver"
	
	super createSchematicWiring.
	self when: #closeRequested: send: #onCloseRequested: to: self.!

flush
	"Flush the buffered output to the display."

	buffer position == 0 
		ifFalse: 
			[bufferProtect critical: 
					[(self view)
						caretPosition: 0;
						replaceSelection: (RichText fromRtf: buffer contents).
					buffer reset]]!

formattingFor: level
	^LevelFormatting at: level ifAbsent: ['']!

initialize
	"Private - Initialize the receiver."

	super initialize.
	buffer := String writeStream.
	bufferProtect := Mutex new.!

nextPut: newElem
	"Append the <character>, newElem, to the receiver."

	self nextPutAll: newElem asString.
	^newElem!

nextPutAll: insertString
	"Append the <readableString>, insertString, to the text of the receiver."

	bufferProtect critical: [buffer nextPutAll: insertString].
	^insertString!

onViewOpened
	"Now run through all our sub-presenters and connect them in turn
	to same named sub-views within aCompositeView"

	super onViewOpened.
	self nextPutAll: '{'.
	self nextPutAll: Prologue.
	self nextPutAll: '}'.
	self flush.
	self view forecolor: Color gray.!

show
	"Shows the view of the receiver"

	self view zOrderTop.
	super show! !
!LoggerPresenter categoriesFor: #append:name:message:!private! !
!LoggerPresenter categoriesFor: #clear!initializing!public! !
!LoggerPresenter categoriesFor: #contents!accessing!public! !
!LoggerPresenter categoriesFor: #createSchematicWiring!initializing!public! !
!LoggerPresenter categoriesFor: #flush!accessing!public! !
!LoggerPresenter categoriesFor: #formattingFor:!private! !
!LoggerPresenter categoriesFor: #initialize!initializing!private! !
!LoggerPresenter categoriesFor: #nextPut:!adding!public! !
!LoggerPresenter categoriesFor: #nextPutAll:!adding!public! !
!LoggerPresenter categoriesFor: #onViewOpened!initializing!private! !
!LoggerPresenter categoriesFor: #show!operations!public! !

!LoggerPresenter class methodsFor!

initialize
"Private - 
self initialize.
"

	LevelFormatting := LookupTable new.
	LevelFormatting at: DebugLevel put: '\cf1 '.
	LevelFormatting at: InfoLevel put: '\cf2 '.
	LevelFormatting at: WarningLevel put: '\cf3 '.
	LevelFormatting at: ErrorLevel put: '\cf4 '.
	LevelFormatting at: FatalLevel put: '\cf5 '.

	Prologue := 	
		'\rtf1\ansi',			"bog standard prolog"
		"'\deff0',"			"use 0 as default font"
		'\deftab240',	 	"default tabs (in twips, i.e. 240 = 1 space in 12 point)"
		"Color table - simply comment this out for mono"
		'{\colortbl',
			(self rtfForColor: Color black),
			(self rtfForColor: Color darkGray),
			(self rtfForColor: Color darkGreen),
			(self rtfForColor: Color blue),
			(self rtfForColor: Color red),
			(self rtfForColor: Color red),
		'}',
		'\pard', 			"reset paragraph format"
		'\tx500\tx1000\tx1500\tx2000\tx2500\tx3000\tx3500\tx4000',
		'\plain'.			"reset character format"!

rtfForColor: color
	| rgb |
	rgb := color asRGB.
	^'\red', rgb red displayString,
	'\green', rgb  green displayString,
	'\blue', rgb  blue displayString,
	';'! !
!LoggerPresenter class categoriesFor: #initialize!private! !
!LoggerPresenter class categoriesFor: #rtfForColor:!private! !

