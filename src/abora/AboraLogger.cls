"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #AboraLogger
	instanceVariableNames: ''
	classVariableNames: 'Connection Persistence Root Security ToDo'
	poolDictionaries: 'LoggerConstants'
	classInstanceVariableNames: ''!
AboraLogger guid: (GUID fromString: '{C93213C2-E8C2-4123-B2E8-126E6DCF4A09}')!
AboraLogger comment: ''!
!AboraLogger categoriesForClass!Kernel-Objects! !
!AboraLogger class methodsFor!

connection
	^Connection!

initialize
	"Private - 
self initialize.
"

	Root := Logger name: '' minimumLevel: InfoLevel.
	Connection := Logger name: 'connection' parent: Root.
	Persistence := Logger name: 'persistence' parent: Root.
	Security := Logger name: 'security' parent: Root.
	ToDo := Logger name: 'todo' parent: Root.!

persistence
	^Persistence!

root
	^Root!

security
	^Security!

todo
	^ToDo! !
!AboraLogger class categoriesFor: #connection!public! !
!AboraLogger class categoriesFor: #initialize!private! !
!AboraLogger class categoriesFor: #persistence!public! !
!AboraLogger class categoriesFor: #root!public! !
!AboraLogger class categoriesFor: #security!public! !
!AboraLogger class categoriesFor: #todo!public! !

