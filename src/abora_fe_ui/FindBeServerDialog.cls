"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Dialog subclass: #FindBeServerDialog
	instanceVariableNames: 'addressPresenter portPresenter messagePresenter connection'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FindBeServerDialog guid: (GUID fromString: '{0B06D878-FE4A-43CE-8F6E-5156EFA3AA80}')!
FindBeServerDialog comment: ''!
!FindBeServerDialog categoriesForClass!MVP-Presenters! !
!FindBeServerDialog methodsFor!

answer
	^connection!

createComponents
	"Private - Create the presenters contained by the receiver"

	super createComponents.
	addressPresenter := self add: TextPresenter new name: 'address'.
	portPresenter := self add: NumberPresenter new name: 'port'.
	messagePresenter := self add: TextPresenter new name: 'message'.

!

isValid
	
	[connection := FeNetworkConnection fromSpec: self model.
	connection connect] on: Error
			do: 
				[:error | 
				connection notNil 
					ifTrue: 
						[connection close.
						connection := nil].
				messagePresenter model: error printString.
				^false].
	^true!

model: anObject
	"Set the model associated with the receiver."

	| aspectBuffer |
	super model: anObject.

	aspectBuffer := self model.
	addressPresenter model: (aspectBuffer aspectValue: #ip).
	portPresenter model: (aspectBuffer aspectValue: #port).
!

ok
	self isValid ifFalse: [^self].
	^super ok! !
!FindBeServerDialog categoriesFor: #answer!public! !
!FindBeServerDialog categoriesFor: #createComponents!private! !
!FindBeServerDialog categoriesFor: #isValid!private! !
!FindBeServerDialog categoriesFor: #model:!public! !
!FindBeServerDialog categoriesFor: #ok!public! !

!FindBeServerDialog class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^FeNetworkConnectionSpec ip: 'localhost'! !
!FindBeServerDialog class categoriesFor: #defaultModel!public! !

