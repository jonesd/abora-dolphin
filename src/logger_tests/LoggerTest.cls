"Filed out from Dolphin Smalltalk 2002 release 5.00"!

TestCase subclass: #LoggerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: 'LoggerConstants'
	classInstanceVariableNames: ''!
LoggerTest guid: (GUID fromString: '{20CC9992-B294-4AD1-9035-3FED290F5615}')!
LoggerTest comment: ''!
!LoggerTest categoriesForClass!SUnit! !
!LoggerTest methodsFor!

setShouldBeEqual: set1 with: set2
	self should: [(set1 difference: set2) isEmpty]!

testDebug
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: InfoLevel.
	logger debug: ['ignore'].
	mock := MockAppender new.
	logger addAppender: mock.
	logger debug: ['ignore'].
	mock verify: self.
	mock addExpected: DebugLevel name: 'fred' message: 'one'.
	logger minimumLevel: DebugLevel.
	logger debug: ['one'].
	mock verify: self.
!

testEffectiveAppenders
	| logger logger2 mock1 mock2 mock3 |
	mock1 := MockAppender new.
	mock2 := MockAppender new.
	mock3 := MockAppender new.

	logger := Logger name: 'fred' minimumLevel: InfoLevel.
	self should: [logger effectiveAppenders isEmpty].
	logger2 := Logger name: 'fred' parent: logger.
	self should: [logger2 effectiveAppenders isEmpty].
	logger addAppender: mock1.
	self setShouldBeEqual: logger effectiveAppenders with: (Set with: mock1).
	self setShouldBeEqual: logger2 effectiveAppenders with: (Set with: mock1).
	logger2 addAppender: mock2.
	self setShouldBeEqual: logger effectiveAppenders with: (Set with: mock1).
	self setShouldBeEqual: logger2 effectiveAppenders with: (Set with: mock1 with: mock2).
	logger addAppender: mock3.
	self setShouldBeEqual: logger effectiveAppenders with: (Set with: mock1 with: mock3).
	self setShouldBeEqual: logger2 effectiveAppenders with: (Set with: mock1 with: mock2 with: mock3).
	logger removeAppender: mock3.
	self setShouldBeEqual: logger effectiveAppenders with: (Set with: mock1).
	self setShouldBeEqual: logger2 effectiveAppenders with: (Set with: mock1 with: mock2).
	logger2 removeAppender: mock2.
	self setShouldBeEqual: logger effectiveAppenders with: (Set with: mock1).
	self setShouldBeEqual: logger2 effectiveAppenders with: (Set with: mock1).

!

testEffectiveMinimumLevel
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: InfoLevel.
	self should: [logger effectiveMinimumLevel = InfoLevel].
	logger2 := Logger name: 'fred' parent: logger.
	self should: [logger2 effectiveMinimumLevel = InfoLevel].
	logger minimumLevel: WarningLevel.
	self should: [logger effectiveMinimumLevel = WarningLevel].
	self should: [logger2 effectiveMinimumLevel = WarningLevel].
	logger2 minimumLevel: DebugLevel.
	self should: [logger effectiveMinimumLevel = WarningLevel].
	self should: [logger2 effectiveMinimumLevel = DebugLevel].
	logger minimumLevel: ErrorLevel.
	self should: [logger effectiveMinimumLevel = ErrorLevel].
	self should: [logger2 effectiveMinimumLevel = DebugLevel].
	logger2 minimumLevel: nil.
	self should: [logger effectiveMinimumLevel = ErrorLevel].
	self should: [logger2 effectiveMinimumLevel = ErrorLevel].
!

testError
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: FatalLevel.
	logger error: ['ignore'].
	mock := MockAppender new.
	logger addAppender: mock.
	logger error: ['ignore'].
	mock verify: self.
	mock addExpected: ErrorLevel name: 'fred' message: 'one'.
	logger minimumLevel: ErrorLevel.
	logger error: ['one'].
	mock verify: self.
!

testFatal
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: FatalLevel.
	mock := MockAppender new.
	logger addAppender: mock.
	mock addExpected: FatalLevel name: 'fred' message: 'one'.
	logger fatal: ['one'].
	mock verify: self.
!

testHasMinimumLevel
	| logger logger2 |
	logger := Logger name: 'fred' minimumLevel: InfoLevel.
	self should: [logger hasMinimumLevel].
	logger2 := Logger name: 'fred' parent: logger.
	self shouldnt: [logger2 hasMinimumLevel].
	logger2 minimumLevel: DebugLevel.
	self should: [logger2 hasMinimumLevel].
!

testHasParent
	| logger logger2 |
	logger := Logger name: 'fred' minimumLevel: InfoLevel.
	self shouldnt: [logger hasParent].
	logger2 := Logger name: 'fred' parent: logger.
	self should: [logger2 hasParent].
	logger2 parent: nil.
	self shouldnt: [logger2 hasParent].
!

testInfo
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: WarningLevel.
	logger info: ['ignore'].
	mock := MockAppender new.
	logger addAppender: mock.
	logger info: ['ignore'].
	mock verify: self.
	mock addExpected: InfoLevel name: 'fred' message: 'one'.
	logger minimumLevel: InfoLevel.
	logger info: ['one'].
	mock verify: self.
!

testIsSufficientLevel
	self should: [(Logger name: 'fred' minimumLevel: DebugLevel) isSufficientLevel: DebugLevel].
	self should: [(Logger name: 'fred' minimumLevel: DebugLevel) isSufficientLevel: InfoLevel].

	self shouldnt: [(Logger name: 'fred' minimumLevel: InfoLevel) isSufficientLevel: DebugLevel].
	self should: [(Logger name: 'fred' minimumLevel: InfoLevel) isSufficientLevel: InfoLevel].
	self should: [(Logger name: 'fred' minimumLevel: InfoLevel) isSufficientLevel: WarningLevel].

	self shouldnt: [(Logger name: 'fred' minimumLevel: WarningLevel) isSufficientLevel: InfoLevel].
	self should: [(Logger name: 'fred' minimumLevel: WarningLevel) isSufficientLevel: WarningLevel].
	self should: [(Logger name: 'fred' minimumLevel: WarningLevel) isSufficientLevel: ErrorLevel].

	self shouldnt: [(Logger name: 'fred' minimumLevel: ErrorLevel) isSufficientLevel: WarningLevel].
	self should: [(Logger name: 'fred' minimumLevel: ErrorLevel) isSufficientLevel: ErrorLevel].
	self should: [(Logger name: 'fred' minimumLevel: ErrorLevel) isSufficientLevel: FatalLevel].

	self shouldnt: [(Logger name: 'fred' minimumLevel: FatalLevel) isSufficientLevel: ErrorLevel].
	self should: [(Logger name: 'fred' minimumLevel: FatalLevel) isSufficientLevel: FatalLevel].
!

testNewName
	| root |
	root := Logger name: 'fred'.
	self should: [root notNil].
	self should: [root name = 'fred'].
	self should: [root parent isNil].
	self should: [root effectiveAppenders isEmpty].
	self should: [root hasMinimumLevel]!

testWarn
	| logger logger2 mock |
	logger := Logger name: 'fred' minimumLevel: ErrorLevel.
	logger warn: ['ignore'].
	mock := MockAppender new.
	logger addAppender: mock.
	logger warn: ['ignore'].
	mock verify: self.
	mock addExpected: WarningLevel name: 'fred' message: 'one'.
	logger minimumLevel: WarningLevel.
	logger warn: ['one'].
	mock verify: self.
! !
!LoggerTest categoriesFor: #setShouldBeEqual:with:!public! !
!LoggerTest categoriesFor: #testDebug!public! !
!LoggerTest categoriesFor: #testEffectiveAppenders!public! !
!LoggerTest categoriesFor: #testEffectiveMinimumLevel!public! !
!LoggerTest categoriesFor: #testError!public! !
!LoggerTest categoriesFor: #testFatal!public! !
!LoggerTest categoriesFor: #testHasMinimumLevel!public! !
!LoggerTest categoriesFor: #testHasParent!public! !
!LoggerTest categoriesFor: #testInfo!public! !
!LoggerTest categoriesFor: #testIsSufficientLevel!public! !
!LoggerTest categoriesFor: #testNewName!public! !
!LoggerTest categoriesFor: #testWarn!public! !

