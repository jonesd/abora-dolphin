"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Presenter subclass: #FeTranspointingPresenter
	instanceVariableNames: 'leftPresenter rightPresenter'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTranspointingPresenter guid: (GUID fromString: '{EB563B92-07D0-4520-92A6-EB690F40F7A7}')!
FeTranspointingPresenter comment: ''!
!FeTranspointingPresenter categoriesForClass!MVP-Presenters! !
!FeTranspointingPresenter methodsFor!

clearTranspoint
	self transpoint: nil and: nil.!

leftPresenter
	^leftPresenter!

leftPresenter: anObject
	leftPresenter := anObject!

onWatchedPositionChanged: positionEvent
	self view refreshContents.!

rightPresenter
	^rightPresenter!

rightPresenter: anObject
	rightPresenter := anObject!

transpoint: left and: right
	leftPresenter notNil ifTrue: [leftPresenter view parentView removeEventsTriggeredFor: self].
	rightPresenter notNil ifTrue: [rightPresenter view parentView removeEventsTriggeredFor: self].
	leftPresenter := left.
	rightPresenter := right.
	leftPresenter notNil ifTrue: [leftPresenter view parentView when: #positionChanged: send: #onWatchedPositionChanged: to: self].
	rightPresenter notNil ifTrue: [rightPresenter view parentView when: #positionChanged: send: #onWatchedPositionChanged: to: self].
	self view clearConnections; refreshContents.! !
!FeTranspointingPresenter categoriesFor: #clearTranspoint!public! !
!FeTranspointingPresenter categoriesFor: #leftPresenter!accessing!private! !
!FeTranspointingPresenter categoriesFor: #leftPresenter:!accessing!private! !
!FeTranspointingPresenter categoriesFor: #onWatchedPositionChanged:!public! !
!FeTranspointingPresenter categoriesFor: #rightPresenter!accessing!private! !
!FeTranspointingPresenter categoriesFor: #rightPresenter:!accessing!private! !
!FeTranspointingPresenter categoriesFor: #transpoint:and:!public! !

!FeTranspointingPresenter class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^1! !
!FeTranspointingPresenter class categoriesFor: #defaultModel!public! !

