"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #Logger
	instanceVariableNames: 'name minimumLevel appenders parent children effectiveMinimumLevel effectiveAppenders'
	classVariableNames: ''
	poolDictionaries: 'LoggerConstants'
	classInstanceVariableNames: ''!
Logger guid: (GUID fromString: '{7B01D4B9-DEE8-428C-9E55-34176A0FF213}')!
Logger comment: ''!
!Logger categoriesForClass!Kernel-Objects! !
!Logger methodsFor!

addAppender: appender
	appenders add: appender.
	self clear.!

addChild: logger
	children add: logger.!

append: level with: messageValuable
	| allAppenders message |
	allAppenders := self effectiveAppenders.
	allAppenders isEmpty ifTrue: [^self].
	message := messageValuable value.
	allAppenders do: 
			[:appender | 
			appender 
				append: level
				name: self name
				message: message]!

clear
	effectiveMinimumLevel := nil.
	effectiveAppenders := nil.
	self clearChildren.!

clearChildren
	children do: [:child | child clear].!

debug: messageValuable
	self log: DebugLevel with: messageValuable.!

effectiveAppenders
	^effectiveAppenders ifNil: 
			[effectiveAppenders := self hasParent 
						ifTrue: [appenders union: parent effectiveAppenders]
						ifFalse: [appenders]]!

effectiveMinimumLevel
	^effectiveMinimumLevel ifNil: 
			[effectiveMinimumLevel := minimumLevel isNil 
						ifTrue: 
							[self assert: [self hasParent].
							parent effectiveMinimumLevel]
						ifFalse: [minimumLevel]]!

error: messageValuable
	self log: ErrorLevel with: messageValuable.!

fatal: messageValuable
	self log: FatalLevel with: messageValuable.!

hasMinimumLevel
	^minimumLevel notNil!

hasParent
	^parent notNil!

info: messageValuable
	self log: InfoLevel with: messageValuable.!

initialize
	super initialize.
	children := OrderedCollection new.
	appenders := Set new.!

isSufficientLevel: level
	^level isSufficientLevel: self effectiveMinimumLevel!

log: level with: messageValuable
	(self isSufficientLevel: level) ifTrue: [self append: level with: messageValuable]!

minimumLevel
	^minimumLevel!

minimumLevel: anObject
	minimumLevel := anObject.
	self clear.!

name
	^name!

name: anObject
	name := anObject!

parent
	^parent!

parent: parentLogger
	parent notNil ifTrue: [parent removeChild: self].
	parent := parentLogger.
	parentLogger notNil ifTrue: [parentLogger addChild: self].
	self clear!

printOn: aStream
	self basicPrintOn: aStream.
	aStream nextPutAll: '('.
	self name displayOn: aStream.
	aStream nextPutAll: ')'.!

removeAppender: appender
	appenders remove: appender.
	self clear.!

removeChild: logger
	children remove: logger.!

warn: messageValuable
	self log: WarningLevel with: messageValuable.! !
!Logger categoriesFor: #addAppender:!public! !
!Logger categoriesFor: #addChild:!public! !
!Logger categoriesFor: #append:with:!private! !
!Logger categoriesFor: #clear!private! !
!Logger categoriesFor: #clearChildren!private! !
!Logger categoriesFor: #debug:!public! !
!Logger categoriesFor: #effectiveAppenders!public! !
!Logger categoriesFor: #effectiveMinimumLevel!public! !
!Logger categoriesFor: #error:!public! !
!Logger categoriesFor: #fatal:!public! !
!Logger categoriesFor: #hasMinimumLevel!accessing!private! !
!Logger categoriesFor: #hasParent!accessing!private! !
!Logger categoriesFor: #info:!public! !
!Logger categoriesFor: #initialize!private! !
!Logger categoriesFor: #isSufficientLevel:!private! !
!Logger categoriesFor: #log:with:!private! !
!Logger categoriesFor: #minimumLevel!accessing!private! !
!Logger categoriesFor: #minimumLevel:!accessing!private! !
!Logger categoriesFor: #name!accessing!private! !
!Logger categoriesFor: #name:!accessing!private! !
!Logger categoriesFor: #parent!accessing!private! !
!Logger categoriesFor: #parent:!accessing!private! !
!Logger categoriesFor: #printOn:!private! !
!Logger categoriesFor: #removeAppender:!public! !
!Logger categoriesFor: #removeChild:!public! !
!Logger categoriesFor: #warn:!public! !

!Logger class methodsFor!

initializeLoggerConstants
"Private - 
self initializeLoggerConstants.
"
	LoggerConstants := PoolDictionary new.
	LoggerConstants at: 'DebugLevel' put: (self name: 'DEBUG' value: 10).
	LoggerConstants at: 'InfoLevel' put: (self name: 'INFO' value: 20).
	LoggerConstants at: 'WarningLevel' put: (self name: 'WARN' value: 30).
	LoggerConstants at: 'ErrorLevel' put: (self name: 'ERROR' value: 40).
	LoggerConstants at: 'FatalLevel' put: (self name: 'FATAL' value: 50).
!

name: loggerName
	^self name: loggerName minimumLevel: WarningLevel!

name: loggerName minimumLevel: minimumLevel
	^self name: loggerName minimumLevel: minimumLevel parent: nil!

name: loggerName minimumLevel: minimumLevel parent: parentLogger
	^(self new initialize)
		name: loggerName;
		minimumLevel: minimumLevel;
		parent: parentLogger;
		yourself!

name: loggerName parent: parentLogger
	^self name: loggerName minimumLevel: nil parent: parentLogger! !
!Logger class categoriesFor: #initializeLoggerConstants!private! !
!Logger class categoriesFor: #name:!public! !
!Logger class categoriesFor: #name:minimumLevel:!public! !
!Logger class categoriesFor: #name:minimumLevel:parent:!public! !
!Logger class categoriesFor: #name:parent:!public! !

