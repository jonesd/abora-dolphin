"Filed out from Dolphin Smalltalk 2002 release 5.00"!

View subclass: #FeTextView
	instanceVariableNames: 'cachedVisibleLines charExtent selectionStart point cachedFontLock isReadOnly cachedLinks cachedLinesExtent cachedMappings linksProcess'
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeTextView guid: (GUID fromString: '{6F164DB9-89D1-4BE3-A420-AED9F9D7E1D1}')!
FeTextView comment: ''!
!FeTextView categoriesForClass!MVP-Views! !
!FeTextView methodsFor!

attemptToModifyReadOnly
	Sound warningBeep!

attemptToMovePointOutOfRange
	"Sound bell." "bell is just too annoying"!

basicInvalidateLayout
	"Private - Invalidates the layout of the receiver (only) indicating that the geometry
	needs to be recalculated. Use #invalidateLayout to fully invalidate the parent chain
	of views."

	super basicInvalidateLayout.
	self clearCached.!

calculateExtent
	"Private - Answer the preferred size of the receiver based on the
	current contents of the receiver."

	^(self linesExtent max: 10@10) * charExtent.!

calculateRefreshLines: canvas
	| clipBox start startLine end endLine |
	clipBox := canvas clipBox.
	start := self positionFromWinPoint: clipBox topLeft allowOverrun: true.
	startLine := self visibleLineFor: start.
	end := self positionFromWinPoint: clipBox bottomRight allowOverrun: true.
	endLine := self visibleLineFor: end.
	^Array with: startLine with: endLine!

cancelTrackingAt: aPoint 
	"Private - Nothing to do"

	self invalidateSelection.
	selectionStart := nil.
	!

charExtent
	^charExtent!

clearCached
	self clearCachedVisibleLines.
	self clearCachedFontLock.
	self clearCachedLinks.
!

clearCachedFontLock
	cachedFontLock := nil.
	cachedMappings := nil!

clearCachedLinks
	linksProcess notNil 
		ifTrue: 
			[linksProcess terminate.
			linksProcess := nil].
	cachedLinks := nil!

clearCachedVisibleLines
	cachedVisibleLines := nil.
	cachedLinesExtent := nil.
!

clearSelection
	self invalidateSelection.
	selectionStart := nil.
	self topView validateUserInterface.!

comparisonColorStream
	^FeAboraSystem current preferences comparisonColorStream!

comparisonPointMovedTo: comparisonPoint
	self mappings reverseDo: 
			[:map | 
			(map first includes: comparisonPoint) 
				ifTrue: 
					[self movePointTo: comparisonPoint - map first startPosition + map last startPosition]]!

connectModel
	"Connect the receiver to its model, wiring events, etc."

	self model 
		when: #workRevised send: #refreshContents to: self;
		when: #workRevised send: #invalidateLayout to: self.!

continueTrackingAt: aPoint from: aPreviousPoint
	"Private - Continue ink tracking for the associated view at aPoint when
	the previous tracking position was at aPreviousPoint. Part of the <MouseTracker>
	target protocol. Answers the actual position achieved"

	| position previousPosition |
	previousPosition := self positionFromWinPoint: aPreviousPoint allowOverrun: true.
	position := self positionFromWinPoint: aPoint allowOverrun: true.
	position ~= point 
		ifTrue: 
			[point := position.
			self invalidateBetweenPosition: previousPosition and: position].
	^aPoint!

count
	^self textEdition count!

createFontLock
	| fontLock fullFontLock |
	fontLock := LookupTable new.
	fontLock at: 1 put: self fontLockBackcolor.
	(self presenter ~~ self and: [self presenter compareAgainstEdition notNil]) 
		ifTrue: 
			[| mappings colors |
			colors := self comparisonColorStream.
			mappings := self presenter compareAgainstEdition sharedWith: self model edition.
			mappings := mappings asSortedCollection: [:a :b | a last extent <= b last extent].
			cachedMappings := mappings.
			mappings reverseDo: 
					[:mapping | 
					| previousColor |
					previousColor := nil.
					fontLock keys asSortedCollection 
						do: [:a | a <= mapping last startPosition ifTrue: [previousColor := fontLock at: a]].
					fontLock at: mapping last startPosition put: colors color.
					colors next.
					(fontLock includesKey: mapping last endPosition + 1) 
						ifFalse: [fontLock at: mapping last endPosition + 1 put: previousColor]]].
	fontLock at: 999999999 put: self fontLockBackcolor.
	fullFontLock := SortedCollection sortBlock: [:a :b | a first <= b first].
	fontLock 
		keysAndValuesDo: [:position :color | fullFontLock add: (Array with: position with: color)].
	^fullFontLock!

createLinks
	| links |
	self clearCachedLinks.

	links := SharedLookupTable new.
	
	linksProcess := [self createLinksProcess: links] forkAt: Processor  userBackgroundPriority.
	^links!

createLinksProcess: links
	| transclusions |
	transclusions := self model edition 
				transclusionsFilteredBy: (Array with: SystemIds singleRefEndorsement).
	transclusions do: 
			[:singleRefEdition | 
			(self presenter showNonNativeLinks 
				or: [self model isSingleRefEditionNative: singleRefEdition]) 
					ifTrue: 
						[| mapping |
						mapping := singleRefEdition sharedWith: self model edition.
						self assert: [mapping notEmpty].
						links at: singleRefEdition put: mapping.
						mapping 
							do: [:map | self invalidateBetweenPosition: map last startPosition and: map last endPosition]]]!

createVisibleLines
	^LayoutScreen new createVisibleLines: self textEdition contents startPosition: 1 visibleExtent: 100@999999999.
!

cursor
	^self isReadOnly ifTrue: [nil] ifFalse: [Cursor iBeam]!

deleteBackward
	| extent |
	self hasSelection ifTrue: [^self deleteSelection].
	point < 2 
		ifTrue: 
			[self attemptToMovePointOutOfRange.
			^self].
	extent := (self textEdition contentsFrom: (point - 2 max: 1) extent: 2) 
				= String lineDelimiter ifTrue: [2] ifFalse: [1].
	point := point - extent.
	self removeFrom: point extent: extent!

deleteForward
	| extent |
	self hasSelection ifTrue: [^self deleteSelection].
	self count >= point 
		ifTrue: 
			[extent := (self textEdition contentsFrom: point extent: 2) = String lineDelimiter 
						ifTrue: [2]
						ifFalse: [1].
			self removeFrom: point extent: extent]
		ifFalse: [self attemptToMovePointOutOfRange]!

deleteSelection
	| region |
	self hasSelection ifFalse: [^self].
	region := self selectionRegion.
	point := region startPosition.
	selectionStart := nil.
	self removeFrom: region startPosition extent: region extent.
	self topView validateUserInterface.!

disconnectFromModel
	"Private - Remove all event registrations lodged with the current model."

	super disconnectFromModel.
	self textEdition flushChanges.

	self invalidateLayout.
!

endTrackingAt: aPoint
	"Private - End ink tracking for the new position of the receiver.
	Part of the <MouseTracker> target protocol."

	| position |
	position := self positionFromWinPoint: aPoint allowOverrun: true.
	point := position.
	point == selectionStart ifTrue: [selectionStart := nil].
	self topView validateUserInterface.!

ensurePointVisible
	| pointRectangle |
	"A single expanded rectangle doesn't work in the expected way."

	pointRectangle := self windowsRectangleFromPosition: self point.
	self ensureRectangleVisible: (pointRectangle translateBy: charExtent * -2).
	self ensureRectangleVisible: (pointRectangle translateBy: charExtent * 2).

!

findCharExtent: canvas
	| textMetric |
	textMetric := canvas textMetrics.
	^textMetric tmAveCharWidth@textMetric tmHeight!

followLinkAt: position
	| link |
	link := self linkAt: position.
	link notNil 
		ifTrue: 
			[(link endorsements includes: FeIds linkUrlEndorsement) 
				ifTrue: [^ShellLibrary default shellOpen: link contents asAboraText].
			(link endorsements includes: FeIds linkJumpEndorsement) ifTrue: [
| hyperRef hyperLink hyperRefs transclusions works |
#todo "total mess!!".
hyperRef := FeSingleRef on: link.
hyperLink := hyperRef hyperLink.
hyperRefs := hyperLink hyperRefs.
hyperRefs := hyperRefs reject: [:ref | ref edition = link].
hyperRefs isEmpty ifTrue: [^self "no need to jump as already there"].
transclusions := hyperRefs first edition transclusionsFilteredBy: (Array with: SystemIds textEditionEndorsement).
works := Set new.
	transclusions do: 
			[:edition | 
			works addAll: edition works.
			edition transclusionsDirect do: [:directEdition | works addAll: directEdition works]].
	#todo.	"option in dialog to include frozen works or not"
	works := works reject: [:work | work isFrozen].
works isEmpty ifTrue: [^MessageBox notify: 'Cant reach related work' caption: AboraSystem current applicationName].
self presenter trigger: #navigateToWorks: with: works]].
	Sound bell!

fontChanged
	"Private - The receiver's font has been changed. The default is to cause
	the receiver ot repaint. Overidden by subclasses that need to apply the 
	font to a Windows control"

	| canvas |
	canvas := self canvas.
	canvas font: self font.
	charExtent := self findCharExtent: canvas.
	self invalidateLayout.

	^super fontChanged!

fontLock
	cachedFontLock isNil ifTrue: [cachedFontLock := self createFontLock].
	^cachedFontLock!

fontLockAt: textPosition
	self fontLock do: [:fontLock |
		fontLock first >= textPosition ifTrue: [^fontLock second]].
	^Color gray!

fontLockBackcolor
	| color |
	color := self backcolor.
	#todo "do something better here".
	color isNil ifTrue: [color := Color white].
	^color!

fontLockFrom: start extent: extent
	| fontLock position |
	fontLock := OrderedCollection new.
	position := start.
	self fontLock keysAndValuesDo: 
			[:index :lock | 
			| nextLock |
			position >= lock first 
				ifTrue: 
					[nextLock := self fontLock at: index + 1.
					fontLock add: (Array with: lock second
								with: (nextLock first - position min: extent - (position - start))).
					nextLock first >= (start + extent) ifTrue: [^fontLock].
					position := nextLock first]].
	^fontLock!

hasSelection
	^selectionStart notNil!

highlightWorkAtPoint
	| line lineContents index startIndex endIndex |
	line := self visibleLineFor: self point.
	line extent = 0 ifTrue: [^self].
	lineContents := self textEdition contentsFrom: line position extent: line extent.
	index := self point - line position + 1.
	(lineContents at: index) isWhitespace ifTrue: [^self].
	startIndex := index.
	[startIndex > 1 and: [(lineContents at: startIndex - 1) isWhitespace not]] whileTrue: [startIndex := startIndex - 1].
	endIndex := index.
	[endIndex < (lineContents size)and: [(lineContents at: endIndex + 1) isWhitespace not]] whileTrue: [endIndex := endIndex + 1].

	selectionStart := startIndex + line position - 1.
	point := endIndex + line position - 1.
	self invalidateSelection.
	self topView invalidateUserInterface.!

initialize
	super initialize.

	self usePreferredExtent: true.

	point := 1.
	isReadOnly := false.!

insertText: text
	| startingPoint |
	self isReadOnly ifTrue: [^self attemptToModifyReadOnly].

	self deleteSelection.
	startingPoint := point.
	self textEdition insert: text at: point.
	point := point + text size.
	self clearCachedVisibleLines.
	(text includesAnyOf: String lineDelimiter) 
		ifTrue: [self invalidateBetweenPosition: startingPoint and: self count + 1]
		ifFalse: 
			[| visibleLine |
			visibleLine := self visibleLineFor: point.
			self invalidateBetweenPosition: startingPoint
				and: visibleLine position + visibleLine extent].
	self topView invalidateUserInterface.!

invalidateBetweenPosition: position1 and: position2
	| lineNumber1 lineNumber2 |
	lineNumber1 := (self visibleLineFor: position1) lineNumber.
	lineNumber2 := (self visibleLineFor: position2) lineNumber.
	lineNumber1 = lineNumber2 
		ifTrue: 
			[| winRectangle1 winRectangle2 |
			winRectangle1 := self windowsRectangleFromPosition: position1.
			winRectangle2 := self windowsRectangleFromPosition: position2.
			self invalidateRect: (winRectangle1 merge: winRectangle2)]
		ifFalse: 
			[(lineNumber1 min: lineNumber2) to: (lineNumber1 max: lineNumber2)
				do: 
					[:lineNumber | 
					self invalidateRect: (0 @ (charExtent y * (lineNumber - 1)) extent: 9999 @ charExtent y)]]!

invalidatePosition: textPosition
	| rectangle |
	rectangle := self windowsRectangleFromPosition: textPosition.
	rectangle notNil ifTrue: [self invalidateRect: rectangle].!

invalidateSelection
	self hasSelection ifFalse: [^self].
	self invalidateBetweenPosition: selectionStart and: self point.!

isReadOnly
	^isReadOnly!

isReadOnly: boolean
	isReadOnly := boolean.
	isReadOnly ifTrue: [self backcolor: Color gray] ifFalse: [self backcolor: nil]!

linesExtent
	cachedLinesExtent isNil 
		ifTrue: 
			[| x y |
			x := 0.
			y := self visibleLines size + 1.
			self visibleLines do: [:line | x := x max: line extent].
			cachedLinesExtent := x @ y].
	^cachedLinesExtent!

linkAt: position
	#todo.
	self links 
		keysAndValuesDo: [:ref :mapping | mapping do: [:map | (map last  includes: position) ifTrue: [^ref]]].
	^nil!

links
	cachedLinks isNil ifTrue: [cachedLinks := self createLinks].
	^cachedLinks!

mappings
	self fontLock.
	^cachedMappings!

maxWinDimension
	^32767!

movePointBy: by
	| currentLine nextLine lineIndex |

	currentLine := self visibleLineFor: point.
	lineIndex := point - currentLine position.
	by < 0 
		ifTrue: 
			[lineIndex > 0 
				ifTrue: [self movePointTo: point - 1]
				ifFalse: 
					[currentLine lineNumber > 1 
						ifTrue: 
							[| previousLine |
							previousLine := self visibleLineAt: currentLine lineNumber - 1.
							self movePointTo: previousLine position + previousLine extent]
						ifFalse: [self attemptToMovePointOutOfRange]]].
	by > 0 
		ifTrue: 
			[lineIndex < currentLine extent 
				ifTrue: [self movePointTo: point + 1]
				ifFalse: 
					[currentLine lineNumber < self visibleLines size 
						ifTrue: 
							[| nextLine |
							nextLine := self visibleLineAt: currentLine lineNumber + 1.
							self movePointTo: nextLine position]
						ifFalse: [self attemptToMovePointOutOfRange]]]
!

movePointByLine: by
	| currentLine newLineNumber newLine lineIndex |
	currentLine := self visibleLineFor: point.
	newLineNumber := currentLine lineNumber + by.
	newLineNumber := (newLineNumber max: 1) min: self visibleLines size.
	newLineNumber ~= currentLine lineNumber
		ifTrue: 
			[lineIndex := point - currentLine position.
			newLine := self visibleLineAt: newLineNumber.
			self movePointTo: newLine position + (lineIndex min: newLine extent)]
		ifFalse: [self attemptToMovePointOutOfRange]!

movePointByPage: by
	| view linesPerPage |
	view := self parentView.
	[view isKindOf: ReferenceView] whileTrue: [view := view parentView].
	linesPerPage := (view height // charExtent y) - 4 max: 1.
	self movePointByLine: by * linesPerPage.!

movePointTo: to
	| oldPoint |
	self view invalidatePosition: self point.
	oldPoint := point.
	point := to.
	point < 1 
		ifTrue: 
			[point := 1.
			self attemptToMovePointOutOfRange].
	point > (self count + 1) 
		ifTrue: 
			[point := self count + 1.
			self attemptToMovePointOutOfRange].
	Keyboard default isShiftDown 
		ifTrue: 
			[selectionStart isNil ifTrue: [selectionStart := oldPoint].
			self invalidateBetweenPosition: oldPoint and: point]
		ifFalse: 
			[self hasSelection ifTrue: [self invalidateBetweenPosition: selectionStart and: oldPoint].
			selectionStart := nil.
			self invalidatePosition: self point].
	self ensurePointVisible.
	self topView invalidateUserInterface.
	self presenter trigger: #pointMovedTo: with: point.!

movePointToBeginningOfLine
	| visibleLine |
	visibleLine := self visibleLineFor: point.
	self movePointTo: visibleLine position.!

movePointToEndOfLine
	| visibleLine |
	visibleLine := self visibleLineFor: point.
	self movePointTo: visibleLine position + visibleLine extent.!

onDestroyed
	self textEdition flushChanges.
	self clearCachedLinks.
	^super onDestroyed.!

onEraseRequired: aColorEvent
	"Private - Handler for erase background"

	^true!

onFullyCreated
	"The receiver has just been fully created. This is a suitable place to perform initialization
	of the window from the receiver's instance variables. Note that this message is sent via
	a WM_PARENTNOTIFY Windows message to the Window's parent, and thus will not be 
	available for views that use the WS_EXNOPARENTNOTIFY extended style, or which are 
	created as immediate children of the desktop or any other Windows not subclassed by Dolphin."

	| canvas |
	super onFullyCreated.
	self font: (Font name: 'Courier New' pointSize: 10).
	canvas := self canvas.
	canvas font: self font.
	charExtent := self findCharExtent: canvas.
	self setFocus.!

onGetCursor: aSymbol
	"The named area of the window associated with the receiver has been hit.
	Answer the appropriate mouse cursor, or nil to accept the default."

	^aSymbol = #client ifTrue: [self cursor] ifFalse: [nil]!

onInputMaskRequired: anEvent
	"Handler for a WM_GETDLGCODE request from Windows.
	The lParam is a pointer to the MSG that may be sent depending on the response.
	The answer should be some combination of DLGC_XXXX flags (e.g. DLGC_WANTARROWS | DLGC_WANTTAB).
	By default we perform the default window processing (which at the time of writing, ansers 0) 
	and bitOr: in DLGC_WANTCHARS, since this gives more useful and intuitive behaviour for 
	specialized View subclasses which will often want alpha-numeric keyboard input."
	
	^(self defaultWindowProcessing: anEvent) bitOr: DLGC_WANTALLKEYS"DLGC_WANTCHARS | DLGC_WANTARROWS|DLGC_WANTTAB"!

onKeyPressed: aKeyEvent
	"Default handler for the receiver's view receiving a key entry."

	| code |
	code := aKeyEvent code.
	code == VK_LEFT 
		ifTrue: 
			[self movePointBy: -1.
			^self].
	code == VK_RIGHT 
		ifTrue: 
			[self movePointBy: 1.
			^self].
	code == VK_UP 
		ifTrue: 
			[self movePointByLine: -1.
			^self].
	code == VK_DOWN 
		ifTrue: 
			[self movePointByLine: 1.
			^self].
	(code == VK_HOME and: [Keyboard default isCtrlDown]) 
		ifTrue: 
			[self movePointTo: 1.
			^self].
	code == VK_HOME 
		ifTrue: 
			[self movePointToBeginningOfLine.
			^self].
	(code == VK_END and: [Keyboard default isCtrlDown]) 
		ifTrue: 
			[self movePointTo: self textEdition count + 1.
			^self].
	code == VK_END 
		ifTrue: 
			[self movePointToEndOfLine.
			^self].
	code == VK_PRIOR 
		ifTrue: 
			[self movePointByPage: -1.
			^self].
	code == VK_NEXT 
		ifTrue: 
			[self movePointByPage: 1.
			^self].
	code == VK_DELETE 
		ifTrue: 
			[self deleteForward.
			^self].
	code == VK_BACK 
		ifTrue: 
			[self deleteBackward.
			^self].
	code == VK_RETURN 
		ifTrue: 
			[self insertText: String lineDelimiter asString.
			^self].
	^super onKeyPressed: aKeyEvent!

onKeyTyped: aKeyEvent
	"Default handler for the receiver's view receiving a key entry."

	| typed |
	typed := Character codePoint: aKeyEvent code.
	(typed notNil and: [typed isPrintable])
		ifTrue: 
			[self insertText: typed asString]
		ifFalse: 
			[^super onKeyTyped: aKeyEvent]!

onKillFocus
	"Handler for loss of focus"

	(self presenter == self or: [self model = DeafObject current]) 
		ifFalse: 
			[self invalidateSelection.
			self invalidatePosition: self point].
	^super onKillFocus!

onLeftButtonDoubleClicked: aMouseEvent
	"Default handler for a mouse left button double-click event.
	Accept the default window processing."

	| position |
	#todo.
	self setFocus.
	position := self positionFromWinPoint: aMouseEvent position allowOverrun: true.
	position notNil ifTrue: [self movePointTo: position] ifFalse: [Sound bell].
	self highlightWorkAtPoint.!

onLeftButtonPressed: aMouseEvent
	"surely this focus should go somewhere else?"

	| position |
	#todo.
	self setFocus.
	position := self positionFromWinPoint: aMouseEvent position allowOverrun: true.
	position notNil ifTrue: [self movePointTo: position] ifFalse: [Sound bell].
	Keyboard default isAltDown 
		ifTrue: [position notNil ifTrue: [self followLinkAt: position]]
		ifFalse: 
			[(MouseTracker forPresenter: self startingAt: aMouseEvent screenPosition)
				origin: aMouseEvent position;
				startTracking: self]!

onModelChanged
	"The model held by the associated presenter has been replaced (i.e. the complete
	contents have changed) so refresh the receiver here."

	point := 1.
	selectionStart := nil.
	super onModelChanged.!

onPaintRequired: aPaintEvent
	"Private - Paint the receiver's view."

	| canvas refreshLines |
	self presenter == self ifTrue: [^1].
"Transcript show: (Time millisecondsToRun: ["
"Profiler profile: ["
	canvas := aPaintEvent canvas.
	canvas font: self font.
	canvas setBkMode: TRANSPARENT.
	refreshLines := self calculateRefreshLines: canvas.
	self paintBackground: refreshLines on: canvas.
	#todo "should return at start of method in case of DeafObject - just want to set the background color".
	self model = DeafObject current ifTrue: [^1].
	self paintSelection: refreshLines on: canvas.
	self paintPoint: refreshLines on: canvas.
	self paintLinks: refreshLines on: canvas.
	self paintText: refreshLines on: canvas.
"]) displayString; cr."
"]."!

onSetFocus
	"Handler for loss of focus"

	self presenter ~~ self 
		ifTrue: 
			[self invalidateSelection.
			self invalidatePosition: self point].
	^super onSetFocus!

paintBackground: refreshLines on: canvas
	| backgroundBrush |
	backgroundBrush := Brush color: self fontLockBackcolor.
	self refreshLines: refreshLines
		do: 
			[:line :winPosition | 
			| effectedRectangle |
			effectedRectangle := winPosition extent: 9999 @ charExtent y.
			(canvas isRectangleVisible: effectedRectangle) 
				ifTrue: 
					[| fontLock color rectangle endWin |
					fontLock := self fontLockFrom: line position extent: line extent.
					endWin := fontLock inject: winPosition
								into: 
									[:win :lock | 
									color := lock first.
									rectangle := win extent: (lock last * charExtent x) @ charExtent y.
									canvas fillRectangle: rectangle brush: (Brush color: color).
									win + ((lock last * charExtent x) @ 0)].
					canvas fillRectangle: (endWin extent: 9999 @ charExtent y) brush: backgroundBrush]].
	refreshLines last lineNumber = self visibleLines size 
		ifTrue: 
			[canvas 
				fillRectangle: (0 @ (refreshLines last lineNumber * charExtent y) extent: self maxWinDimension asPoint)
				brush: backgroundBrush].
	backgroundBrush release.!

paintLinks: refreshLines on: canvas
	| brush |
	brush := Brush color: Color magenta.
	self links do: 
			[:map | 
			map do: 
					[:m | 
					| start startLine end endLine |
					start := m last startPosition.
					end := m last endPosition.
					(start < (refreshLines last position + refreshLines last extent) 
						and: [end >= refreshLines first position]) 
							ifTrue: 
								[startLine := self visibleLineFor: start.
								endLine := self visibleLineFor: end.
								startLine lineNumber to: endLine lineNumber
									do: 
										[:lineNumber | 
										| line startIndex endIndex rectangle |
										line := self visibleLineAt: lineNumber.
										startIndex := 0.
										endIndex := line extent.
										line == startLine ifTrue: [startIndex := start - line position].
										line == endLine ifTrue: [endIndex := end - line position].
										rectangle := (startIndex * charExtent x) 
													@ ((lineNumber - 1) * charExtent y + (charExtent y - 4)) 
														extent: ((endIndex - startIndex + 1) * charExtent x) @ 2.
										canvas fillRectangle: rectangle brush: brush]]]].
	brush release.!

paintPoint: refreshLines on: canvas
	"Private - Paint the receiver's view."

	| rectangle brush |
	rectangle := self windowsRectangleFromPosition: self point.
	rectangle isNil ifTrue: [^self].
	brush := self hasFocus ifTrue: [Brush color: Color red] ifFalse: [Brush gray].
	canvas fillRectangle: rectangle brush: brush.
	brush release.!

paintSelection: refreshLines on: canvas
	"Private - Paint the receiver's view."

	| brush start startLine end endLine |
	self hasSelection ifFalse: [^self].
	brush := self hasFocus ifTrue: [Brush color: Color yellow] ifFalse: [Brush ltGray].
	start := selectionStart min: self point.
	startLine := self visibleLineFor: start.
	end := selectionStart max: self point.
	endLine := self visibleLineFor: end.
	startLine lineNumber to: endLine lineNumber
		do: 
			[:lineNumber | 
			| line startIndex endIndex rectangle |
			line := self visibleLineAt: lineNumber.
			startIndex := 0.
			endIndex := line extent.
			line == startLine ifTrue: [startIndex := start - line position].
			line == endLine ifTrue: [endIndex := end - line position].
			rectangle := (startIndex * charExtent x) @ ((lineNumber - 1) * charExtent y) 
						extent: ((endIndex - startIndex + 1) * charExtent x) @ charExtent y.
			canvas fillRectangle: rectangle brush: brush].
	brush release.!

paintText: refreshLines on: canvas
	self refreshLines: refreshLines
		do: 
			[:line :winPosition | 
			| effectedRectangle |
			effectedRectangle := winPosition extent: 9999 @ charExtent y.
			(canvas isRectangleVisible: effectedRectangle) 
				ifTrue: 
					[canvas text: (self textEdition contentsFrom: line position extent: line extent)
						at: winPosition]]!

point
	^point!

positionFromWinPoint: windowsPoint allowOverrun: allowOverrun
	| lineNumber line lineIndex |
	lineNumber := windowsPoint y // charExtent y + 1.
	lineNumber := (lineNumber max: 1) min: self visibleLines size.
	line := self visibleLineAt: lineNumber.
	lineIndex := windowsPoint x // charExtent x.
	lineIndex := (lineIndex max: 0) min: line extent.
	^line position + lineIndex!

queryCommand: aCommandQuery
	"Private - Enters details about a potential command for the receiver into aCommandQuery"

	super queryCommand: aCommandQuery.

	aCommandQuery command == #deleteSelection 
		ifTrue: [aCommandQuery isEnabled: self hasSelection].
!

refreshLines: refreshLines do: operation
	| winPosition |
	winPosition := 0 @ ((refreshLines first lineNumber - 1) * charExtent y).
	refreshLines first lineNumber to: refreshLines last lineNumber do: [:lineNumber | 
			| line  |
			line := self visibleLineAt: lineNumber.
			operation value: line value: winPosition.
			winPosition := winPosition + (0 @ charExtent y)].
!

removeFrom: position extent: extent
	| startLine winPosition |
	self isReadOnly ifTrue: [^self attemptToModifyReadOnly].
	startLine := self visibleLineFor: position.
	self textEdition removeFrom: position extent: extent.
	self clearCachedVisibleLines.
	winPosition := 0 @ ((startLine lineNumber - 1) * charExtent y).
	position + extent <= (startLine position + startLine extent) 
		ifTrue: [self invalidateRect: (winPosition extent: 9999 @ charExtent y)]
		ifFalse: [self invalidateRect: (winPosition extent: 9999 @ 99999)]!

selectAll
	selectionStart := 1.
	point := self count.
	self invalidateSelection.
	self ensurePointVisible.!

selectFrom: start extent: extent
	self invalidateSelection.
	self invalidatePosition: point.
	selectionStart := start.
	point := start + extent - 1.
	self invalidateSelection.
	self invalidatePosition: point.
	self topView invalidateUserInterface!

selectionAsReference
	| region |
	self hasSelection ifFalse: [^nil].
	region := self selectionRegion.
	^ClippedItem 
		id: self textEdition edition id
		position: region startPosition
		extent: region extent!

selectionAsText
	| region |
	self hasSelection ifFalse: [^nil].
	region := self selectionRegion.
	^self textEdition contentsFrom: region startPosition extent: region extent.!

selectionRegion
	| startIndex endIndex |
	self hasSelection ifFalse: [^nil].
	#todo "should we flushChanges here?".
	self textEdition flushChanges.
	startIndex := selectionStart min: self point.
	"model size comes into account is we use count + 1 as the insert point for an append."
	endIndex := (selectionStart max: self point) min: self textEdition count.
	^IntegerRegion startPosition: startIndex endPosition: endIndex!

startTrackingAt: aPoint
	"Private - Start ink tracking for the associated view at aPoint. Part of the 
	<MouseTracker> target protocol. Answers the actual position achieved."

	| position |
	position := self positionFromWinPoint: aPoint allowOverrun: true.
	self hasSelection 
		ifFalse: 
			[selectionStart := point.
			point := position.
			self invalidateSelection].
	^aPoint!

textEdition
	^self model textEdition!

visibleLineAt: lineNumber
	^self visibleLines at: lineNumber!

visibleLineFor: position
	^self visibleLines inject: self visibleLines first  into: [:lastLine :line |
		"in case position is one of the eoln chars"
		position < line position ifTrue: [^lastLine].
		position <= (line position + line extent) ifTrue: [^line].
		line].!

visibleLines
	cachedVisibleLines isNil ifTrue: [cachedVisibleLines := self createVisibleLines].
	^cachedVisibleLines!

windowsRectangleFromPosition: textPosition
	| line lineIndex  |
	line := self visibleLineFor: textPosition.
	lineIndex := textPosition - line position.
	^(lineIndex * charExtent x) @  ((line lineNumber - 1) * charExtent y) extent: charExtent! !
!FeTextView categoriesFor: #attemptToModifyReadOnly!public! !
!FeTextView categoriesFor: #attemptToMovePointOutOfRange!public! !
!FeTextView categoriesFor: #basicInvalidateLayout!private! !
!FeTextView categoriesFor: #calculateExtent!private! !
!FeTextView categoriesFor: #calculateRefreshLines:!private! !
!FeTextView categoriesFor: #cancelTrackingAt:!private! !
!FeTextView categoriesFor: #charExtent!public! !
!FeTextView categoriesFor: #clearCached!private! !
!FeTextView categoriesFor: #clearCachedFontLock!private! !
!FeTextView categoriesFor: #clearCachedLinks!private! !
!FeTextView categoriesFor: #clearCachedVisibleLines!private! !
!FeTextView categoriesFor: #clearSelection!public! !
!FeTextView categoriesFor: #comparisonColorStream!private! !
!FeTextView categoriesFor: #comparisonPointMovedTo:!public! !
!FeTextView categoriesFor: #connectModel!private! !
!FeTextView categoriesFor: #continueTrackingAt:from:!private! !
!FeTextView categoriesFor: #count!public! !
!FeTextView categoriesFor: #createFontLock!private! !
!FeTextView categoriesFor: #createLinks!private! !
!FeTextView categoriesFor: #createLinksProcess:!private! !
!FeTextView categoriesFor: #createVisibleLines!private! !
!FeTextView categoriesFor: #cursor!private! !
!FeTextView categoriesFor: #deleteBackward!public! !
!FeTextView categoriesFor: #deleteForward!public! !
!FeTextView categoriesFor: #deleteSelection!public! !
!FeTextView categoriesFor: #disconnectFromModel!public! !
!FeTextView categoriesFor: #endTrackingAt:!private! !
!FeTextView categoriesFor: #ensurePointVisible!public! !
!FeTextView categoriesFor: #findCharExtent:!private! !
!FeTextView categoriesFor: #followLinkAt:!private! !
!FeTextView categoriesFor: #fontChanged!private! !
!FeTextView categoriesFor: #fontLock!private! !
!FeTextView categoriesFor: #fontLockAt:!private! !
!FeTextView categoriesFor: #fontLockBackcolor!private! !
!FeTextView categoriesFor: #fontLockFrom:extent:!private! !
!FeTextView categoriesFor: #hasSelection!public! !
!FeTextView categoriesFor: #highlightWorkAtPoint!private! !
!FeTextView categoriesFor: #initialize!public! !
!FeTextView categoriesFor: #insertText:!public! !
!FeTextView categoriesFor: #invalidateBetweenPosition:and:!private! !
!FeTextView categoriesFor: #invalidatePosition:!private! !
!FeTextView categoriesFor: #invalidateSelection!private! !
!FeTextView categoriesFor: #isReadOnly!accessing!private! !
!FeTextView categoriesFor: #isReadOnly:!accessing!private! !
!FeTextView categoriesFor: #linesExtent!private! !
!FeTextView categoriesFor: #linkAt:!private! !
!FeTextView categoriesFor: #links!private! !
!FeTextView categoriesFor: #mappings!private! !
!FeTextView categoriesFor: #maxWinDimension!private! !
!FeTextView categoriesFor: #movePointBy:!public! !
!FeTextView categoriesFor: #movePointByLine:!public! !
!FeTextView categoriesFor: #movePointByPage:!public! !
!FeTextView categoriesFor: #movePointTo:!public! !
!FeTextView categoriesFor: #movePointToBeginningOfLine!public! !
!FeTextView categoriesFor: #movePointToEndOfLine!public! !
!FeTextView categoriesFor: #onDestroyed!private! !
!FeTextView categoriesFor: #onEraseRequired:!public! !
!FeTextView categoriesFor: #onFullyCreated!private! !
!FeTextView categoriesFor: #onGetCursor:!private! !
!FeTextView categoriesFor: #onInputMaskRequired:!private! !
!FeTextView categoriesFor: #onKeyPressed:!public! !
!FeTextView categoriesFor: #onKeyTyped:!public! !
!FeTextView categoriesFor: #onKillFocus!public! !
!FeTextView categoriesFor: #onLeftButtonDoubleClicked:!private! !
!FeTextView categoriesFor: #onLeftButtonPressed:!private! !
!FeTextView categoriesFor: #onModelChanged!public! !
!FeTextView categoriesFor: #onPaintRequired:!private! !
!FeTextView categoriesFor: #onSetFocus!public! !
!FeTextView categoriesFor: #paintBackground:on:!private! !
!FeTextView categoriesFor: #paintLinks:on:!private! !
!FeTextView categoriesFor: #paintPoint:on:!private! !
!FeTextView categoriesFor: #paintSelection:on:!private! !
!FeTextView categoriesFor: #paintText:on:!private! !
!FeTextView categoriesFor: #point!public! !
!FeTextView categoriesFor: #positionFromWinPoint:allowOverrun:!private! !
!FeTextView categoriesFor: #queryCommand:!private! !
!FeTextView categoriesFor: #refreshLines:do:!private! !
!FeTextView categoriesFor: #removeFrom:extent:!private! !
!FeTextView categoriesFor: #selectAll!public! !
!FeTextView categoriesFor: #selectFrom:extent:!public! !
!FeTextView categoriesFor: #selectionAsReference!public! !
!FeTextView categoriesFor: #selectionAsText!public! !
!FeTextView categoriesFor: #selectionRegion!public! !
!FeTextView categoriesFor: #startTrackingAt:!private! !
!FeTextView categoriesFor: #textEdition!public! !
!FeTextView categoriesFor: #visibleLineAt:!private! !
!FeTextView categoriesFor: #visibleLineFor:!private! !
!FeTextView categoriesFor: #visibleLines!private! !
!FeTextView categoriesFor: #windowsRectangleFromPosition:!private! !

!FeTextView class methodsFor!

defaultModel
	"Answer a default model to be assigned to the receiver when it is initialized."

	#todo "rutern deafobject to just try and keep things understandable later, so that the fe ui doesn't have any BeX objects".
	^DeafObject current.
	"^FeTextModel empty."! !
!FeTextView class categoriesFor: #defaultModel!public! !

