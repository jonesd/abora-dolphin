"Filed out from Dolphin Smalltalk 2002 release 5.00"!

AboraObject subclass: #FeIds
	instanceVariableNames: ''
	classVariableNames: 'Cache'
	poolDictionaries: ''
	classInstanceVariableNames: ''!
FeIds guid: (GUID fromString: '{84ED900F-F19D-4F61-BF91-AD9552ABB3EC}')!
FeIds comment: ''!
!FeIds categoriesForClass!Kernel-Objects! !
!FeIds class methodsFor!

cached: symbol
	^Cache at: symbol!

createId: value
	^(Id new)
		value: value;
		yourself!

initialize
"Private - 
	self initialize.
"

	Cache := IdentityDictionary new.

	Cache at: #linkAuthor put: (self createId: 34).
	Cache at: #linkComment put: (self createId: 50).
	Cache at: #linkCorrection put: (self createId: 54).
	Cache at: #linkJump put: (self createId: 42).
	Cache at: #linkQuote put: (self createId: 38).
	Cache at: #linkTitle put: (self createId: 30).
	Cache at: #linkUrl put: (self createId: 46).

	Cache at: #linksClub put: (self createId: 26).

	Cache at: #linkAuthorEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkAuthor).
	Cache at: #linkCommentEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkComment).
	Cache at: #linkCorrectionEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkCorrection).
	Cache at: #linkJumpEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkJump).
	Cache at: #linkQuoteEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkQuote).
	Cache at: #linkTitleEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkTitle).
	Cache at: #linkUrlEndorsement put: (Endorsement endorseeId: self linksClub itemId: self linkUrl).
!

linkAuthor
	^self cached: #linkAuthor
!

linkAuthorEndorsement
	^self cached: #linkAuthorEndorsement
!

linkComment
	^self cached: #linkComment
!

linkCommentEndorsement
	^self cached: #linkCommentEndorsement
!

linkCorrection
	^self cached: #linkCorrection
!

linkCorrectionEndorsement
	^self cached: #linkCorrectionEndorsement!

linkJump
	^self cached: #linkJump!

linkJumpEndorsement
	^self cached: #linkJumpEndorsement!

linkQuote
	^self cached: #linkQuote!

linkQuoteEndorsement
	^self cached: #linkQuoteEndorsement!

linksClub
	^self cached: #linksClub!

linkTitle
	^self cached: #linkTitle!

linkTitleEndorsement
	^self cached: #linkTitleEndorsement!

linkUrl
	^self cached: #linkUrl!

linkUrlEndorsement
	^self cached: #linkUrlEndorsement! !
!FeIds class categoriesFor: #cached:!private! !
!FeIds class categoriesFor: #createId:!private! !
!FeIds class categoriesFor: #initialize!private! !
!FeIds class categoriesFor: #linkAuthor!public! !
!FeIds class categoriesFor: #linkAuthorEndorsement!public! !
!FeIds class categoriesFor: #linkComment!public! !
!FeIds class categoriesFor: #linkCommentEndorsement!public! !
!FeIds class categoriesFor: #linkCorrection!public! !
!FeIds class categoriesFor: #linkCorrectionEndorsement!public! !
!FeIds class categoriesFor: #linkJump!public! !
!FeIds class categoriesFor: #linkJumpEndorsement!public! !
!FeIds class categoriesFor: #linkQuote!public! !
!FeIds class categoriesFor: #linkQuoteEndorsement!public! !
!FeIds class categoriesFor: #linksClub!public! !
!FeIds class categoriesFor: #linkTitle!public! !
!FeIds class categoriesFor: #linkTitleEndorsement!public! !
!FeIds class categoriesFor: #linkUrl!public! !
!FeIds class categoriesFor: #linkUrlEndorsement!public! !

