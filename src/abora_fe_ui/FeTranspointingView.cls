"Filed out from Dolphin Smalltalk 2002 release 5.00"!

DoubleBufferedView subclass: #FeTranspointingView
	instanceVariableNames: 'cachedConnections'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTranspointingView guid: (GUID fromString: '{ADBFA817-B846-4874-883B-8CFA82B654B4}')!
FeTranspointingView comment: ''!
!FeTranspointingView categoriesForClass!Unclassified! !
!FeTranspointingView methodsFor!

calculateExtent
	"Private - Answer the preferred size of the receiver based on the
	current contents of the receiver."

	^30 @ 10.!

clearConnections
	cachedConnections := nil.!

connections
	cachedConnections isNil ifTrue: [cachedConnections := self createConnections].
	^cachedConnections!

createConnections
	| mappings leftView leftWidth rightView rightWidth width connections clientOffset |
	leftView := self presenter leftPresenter view.
	rightView := self presenter rightPresenter view.
	leftWidth := leftView width.
	rightWidth := rightView width.
	width := self width.
	clientOffset := 0 @ 2.
	mappings := leftView presenter compareAgainstEdition sharedWith: leftView model edition.
	mappings := mappings asSortedCollection: [:a :b | a last extent <= b last extent].
	connections := OrderedCollection new: mappings size.
	mappings reverseDo: 
			[:mapping | 
			| leftStart leftEnd rightStart rightEnd line |
			leftStart := (leftView windowsRectangleFromPosition: mapping last startPosition) topLeft 
						+ clientOffset.
			line := leftView visibleLineFor: mapping last startPosition.
			leftStart := 1 
						@ (((mapping last startPosition - line position) / (line extent max: 1) 
								* leftView charExtent y) asInteger 
								+ leftStart y).
			leftEnd := (leftView windowsRectangleFromPosition: mapping last endPosition) topRight 
						+ clientOffset.
			line := leftView visibleLineFor: mapping last endPosition.
			leftEnd := 1 
						@ (((mapping last endPosition - line position) / (line extent max: 1) 
								* leftView charExtent y) asInteger 
								+ leftEnd y).
			rightStart := (rightView windowsRectangleFromPosition: mapping first startPosition) 
						topLeft + clientOffset.
			line := rightView visibleLineFor: mapping first startPosition.
			rightStart := (width - 2) 
						@ (((mapping first startPosition - line position) / (line extent max: 1) 
								* rightView charExtent y) asInteger 
								+ rightStart y).
			rightEnd := (rightView windowsRectangleFromPosition: mapping first endPosition) topRight 
						+ clientOffset.
			line := rightView visibleLineFor: mapping first endPosition.
			rightEnd := (width - 2) 
						@ (((mapping first endPosition - line position) / (line extent max: 1) 
								* rightView charExtent y) asInteger 
								+ rightEnd y).
			connections add: (Array 
						with: leftStart
						with: rightStart
						with: rightEnd
						with: leftEnd)].
	^connections!

fillBackground: canvas
	 | brush |
	brush := Brush color: self backcolor.
	canvas fillRectangle: (0 @ 0 extent: canvas extent) brush: brush.
	brush release.!

initialize
	super initialize.

	self usePreferredExtent: true.
	self backcolor: (SystemColor fromId: COLOR_3DFACE).!

paintTranspointingOn: canvas
	| connections leftView leftOffset rightView rightOffset colors |
	leftView := self presenter leftPresenter view.
	rightView := self presenter rightPresenter view.
	leftOffset := 0 @ leftView parentView position y.
	rightOffset := 0 @ rightView parentView position y.
	connections := self connections.
	colors := leftView comparisonColorStream.
	connections do: 
			[:connection | 
			| leftStart leftEnd rightStart rightEnd |
			leftStart := connection at: 1.
			rightStart := connection at: 2.
			rightEnd := connection at: 3.
			leftEnd := connection at: 4.
			canvas pen: colors pen.
			canvas brush: colors brush.
			colors next.
			canvas polygon: (Array 
						with: leftStart + leftOffset
						with: rightStart + rightOffset
						with: rightEnd + rightOffset
						with: leftEnd + leftOffset)]!

render
	"Private - Paint the receiver's view."

	"Transcript show: (Time millisecondsToRun: ["

	"Profiler profile: ["

	| canvas |
	canvas := self canvas.
	self fillBackground: canvas.
	(self presenter == self or: [self presenter leftPresenter isNil]) 
		ifFalse: [self paintTranspointingOn: canvas].
	canvas release
	"]) displayString; cr."
	"]."! !
!FeTranspointingView categoriesFor: #calculateExtent!private! !
!FeTranspointingView categoriesFor: #clearConnections!private! !
!FeTranspointingView categoriesFor: #connections!public! !
!FeTranspointingView categoriesFor: #createConnections!private! !
!FeTranspointingView categoriesFor: #fillBackground:!private! !
!FeTranspointingView categoriesFor: #initialize!private! !
!FeTranspointingView categoriesFor: #paintTranspointingOn:!private! !
!FeTranspointingView categoriesFor: #render!private! !

!FeTranspointingView class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	^1! !
!FeTranspointingView class categoriesFor: #defaultModel!public! !

