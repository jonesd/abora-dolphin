"Filed out from Dolphin Smalltalk 2002 release 5.00"!

Object subclass: #AboraBuild
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	classInstanceVariableNames: ''!
AboraBuild guid: (GUID fromString: '{3967BB01-27F5-48B5-87BC-4DC9F44C3EF2}')!
AboraBuild comment: 'Abora Build

Central location to build a release of the software for others to use. This is unfortunately still a little manual,
with a release directory preparation stage, followed by running Lagoon on the abora_fe package,
forming an abora distribution directory, plus some manual copying of of packages into the distribution dir.

Execute the following to create a new release directory prior to Lagoon exe creation:

AboraBuild new build.


Execute the following after lagoon has been deployed to create a abora-0_012 directory:

AboraBuild new postLagoon.'!
!AboraBuild categoriesForClass!Kernel-Objects! !
!AboraBuild methodsFor!

baseDirectory
	^File 
		removePathDelimiter: (File splitPathFrom: (File 
						removePathDelimiter: (File splitPathFrom: SessionManager current imagePath)))!

build
	self withFeConnection: FeDirectConnection new
		do: 
			[self buildWorksStorage.
			self createReleaseFiles]!

buildClub: text expectedId: expectedId
	| club |
	club := BeClub in: WorksStorage current
				edition: (BeEdition contents: text asAboraContent).
	club edition endorse: SystemIds textEditionEndorsement.
	self assert: [club id = expectedId].
!

buildExampleWork
	| example exampleText exampleTextFirst start titleLink topEdition |
	exampleTextFirst := exampleText := self 
						createTextEdition: 'Example Tree

If you walk through the editions of this Work then you will see
some simple character insertions, deletions and transclusions.
Choose the Debug->InspectDocumentRoots menu, or Ctrl+I
to see how the Ent tree changes for each edition.

'.
	titleLink := self createTitleLinkOnFirstLine: exampleText.
	example := self createWorkDocumentOn: (Array with: exampleText with: titleLink edition).
	topEdition := example edition.
	start := exampleText count + 1.
	self 
		reviseTextEdition: (exampleText := exampleText insert: 'ab' asAboraContent at: start)
		for: example.
	self 
		reviseTextEdition: (exampleText := exampleText insert: 'c' asAboraContent at: start + 2)
		for: example.
	self 
		reviseTextEdition: (exampleText := exampleText insert: 'X' asAboraContent at: start + 2)
		for: example.
	self reviseTextEdition: (exampleText := exampleText removeFrom: start + 1 extent: 1)
		for: example.
	self reviseTextEdition: (exampleText := exampleText 
						transcludeEdition: exampleTextFirst
						from: 1
						extent: 2
						to: start + 3)
		for: example!

buildFeClubs
	self buildClub: 'Fe Links Club' expectedId: FeIds linksClub.
!

buildFeLinks
	self buildLink: 'Title' expectedId: FeIds linkTitle.
	self buildLink: 'Author' expectedId: FeIds linkAuthor.
	self buildLink: 'Quote' expectedId: FeIds linkQuote.
	self buildLink: 'Jump' expectedId: FeIds linkJump.
	self buildLink: 'URL' expectedId: FeIds linkUrl.
	self buildLink: 'Comment' expectedId: FeIds linkComment.
	self buildLink: 'Correction' expectedId: FeIds linkCorrection.!

buildLink: linkText expectedId: expectedId
	| club |
	club := BeClub in: WorksStorage current
				edition: (BeEdition contents: linkText asAboraContent).
	club edition endorse: SystemIds textEditionEndorsement.
	self assert: [club id = expectedId].!

buildSystemClubs
	self buildClub: 'Universal Empty Club' expectedId: SystemIds universalEmptyClub.
	self buildClub: 'Universal Public Club' expectedId: SystemIds universalPublicClub.

	self buildClub: 'System Access Club' expectedId: SystemIds systemAccessClub.
	self buildClub: 'System Admin Club' expectedId: SystemIds systemAdminClub.
	self buildClub: 'System Archive Club' expectedId: SystemIds systemArchiveClub!

buildTutorialWork
	| textEdition tutorial hyperLink |
	textEdition := self createTextEdition: self tutorialContents.
	hyperLink := self createTitleLinkOnFirstLine: textEdition.
	tutorial := self createWorkDocumentOn: (Array with: textEdition with: hyperLink edition)!

buildUserHome
	| edition  work |
	edition := BeEdition new.
	work := BeWork edition: edition.
	WorksStorage current userHome: work.!

buildVersionsWork
	| textEdition versions hyperLink |
	textEdition := self createTextEdition: self versionsContents.
	hyperLink := self createTitleLinkOnFirstLine: textEdition.
	versions := self createWorkDocumentOn: (Array with: textEdition with: hyperLink edition)!

buildWelcomeAndLicenseWorks
	| welcome welcomeText welcomeChildren license licenseText titleLink |
	welcomeText := self createTextEdition: self welcomeContents.
	licenseText := self createTextEdition: self licenseContents.
	welcomeText := welcomeText 
				transcludeEdition: licenseText
				from: 1
				extent: licenseText count
				to: welcomeText count + 1.
	welcomeText endorse: SystemIds textEditionEndorsement.
	titleLink := self createTitleLinkOnFirstLine: welcomeText.
	welcomeChildren := OrderedCollection with: welcomeText with: titleLink edition.
	welcomeChildren addAll: (self urlsIn: welcomeText).
	welcome := self createWorkDocumentOn: welcomeChildren asArray.
	titleLink := self createTitleLinkOnFirstLine: licenseText.
	license := self createWorkDocumentOn: (Array with: licenseText with: titleLink edition)!

buildWorksStorage
	self clearWorksStorage.
	self reserveSystemIds.
	self buildSystemClubs.
	self buildFeClubs.
	self buildFeLinks.
	self buildUserHome.
	self buildWelcomeAndLicenseWorks.
	self buildVersionsWork.
	self buildTutorialWork.
	self buildExampleWork!

clearConnections
	FeConnection current notNil ifTrue: [FeConnection current close].
	FeConnection current: nil.
	BeNetworkListener current notNil ifTrue: [BeNetworkListener current close].
	BeNetworkListener current: nil!

clearWorksStorage
	WorksStorage initialize.
	Id initialize.
	FeIdLookup initialize.
	FeServer initialize.
	AboraSystem initialize.
	AboraSystem current versionNumber: self versionString.
	FeAboraSystem initialize.
	BeServer initialize!

createFileNamed: filename with: contents
	| stream |
	stream := FileStream write: filename.
	[stream nextPutAll: contents] ensure: [stream close]!

createReleaseFiles
	| name |
	name := self releaseDirectory.
	File createDirectory: name.
	self createFileNamed: name , '\ReadMe.txt' with: self welcomeContents.
	self createFileNamed: name , '\License.txt' with: self licenseContents.
	self createFileNamed: name , '\Install.txt' with: self installContents.
	self createFileNamed: name , '\Versions.txt' with: self versionsContents.
	self createFileNamed: name , '\Tutorial.txt' with: self tutorialContents.

"	File createDirectory: name,'\packages'.
	File copy: self baseDirectory, '\packages\abora.pac' to: self releaseDirectory,'\packages'.
"!

createTextEdition: text
	| textEdition |
	textEdition := FeTextEdition contents: text.
	^textEdition edition!

createTitleLinkOnFirstLine: textEdition
	| hyperLink ref |
	ref := FeSingleRef 
				createOn: textEdition
				from: 1
				extent: (textEdition contents asAboraText indexOfAnyOf: String lineDelimiter startingAt: 1) 
						- 1.
	hyperLink := FeHyperLink createWithAll: (Array with: ref) linkType: FeIds linkTitleEndorsement.
	^hyperLink!

createWorkDocumentOn: textEdition
	| work documentEdition userHome |
	documentEdition := FeEdition contents: textEdition.
	work := FeWork edition: documentEdition.
	#todo.
	userHome := WorksStorage current userHome.
	userHome revise: (userHome edition append: work beWork).
	^work!

deployBeAbora
	self build.
	self clearConnections.
	self deployPackageNamed: 'abora_be_ui'!

deployFeAbora
	self build.
	self clearConnections.
	WorksStorage initialize.
	self deployPackageNamed: 'abora_fe_ui'!

deployPackageNamed: packageName
	| package |
	package := PackageManager current packageNamed: packageName.
	self assert: [package notNil].
	ApplicationDeploymentWizard showModalOn: (package aspectValue: #imageStripper).!

faqContents
	^
'Abora FAQ


What is Abora?

Abora is a hypertext system inspired by Xanadu and the Udanax-Gold implementation.

It has been created from scratch in Dolphin Smalltalk.


Who is the author?

Currently all of the work on Abora has been implemented by David Jones.
http://www.night.dircon.co.uk

I''m open to suggestions, comments, ideas, offers of financial and programming assistance.

This work is strongly influenced by the Xanadu design and the Udanax-Gold implementation, and without either of them there would be no Abora.


Is there source availabxle?

The full source code to Abora is available as Dolphin Smalltalk packages. These are plain text files. 


What is the Abora licencse?

Abora is released under the X11 license, which provides very open access to others.

This license was chosen to match that under which Udanax-Gold was released.


History of Abora?

I have been interested in the Xanadu design for what some time and recently had repeatedly noticed failings in the current
systems I was using to stash notes, articles and ideas. Every few months I would venture out on google searches in the hope
of finding some combination of features that would cover off what I thought I needed in the short term, but with potential to
support my work for years to come, for many years to come. This requires by support for reasonabl size storage, from an individuals
perspective, plus the flexibility to expand functionaly without being constrained.

I had been excited by the revealing of Udanax-Gold and Green in 1999, but failed to spend the appropriate time on them. Of course
as a fan of Smalltalk, the use of the language in Gold, together with the level of generality and scalability apparently supported by the
design and implementation was definitely interesting. It was only during a few stuttering attempts in 2001 that I started to look closer at
Gold. Though I was baffled by a lot of it (and still am), of the parts that I could understand together with the released documentation
I started to understand some of the appealing aspects of the design. I originally tried to follow the path of converting the released, but incomplete, 
code first into Java though a limited automated translation process, and then resigned myself to trying to load the available source into Dolphin Smalltalk
and start nibbling away at the test cases. A series of difficulties sapped my energy; missing source code, lack of documentation, no access to 
expected results of the test cases, and continude bafflement of the workings of the majority of the implemenation.

Summer 2002 start a new chapter in my relationship with Xanadu and Udanax-Gold. I was ab le to corral my holidays, and could focus on
a 6 week attempt at starting an implementation of Xanadu, strongly based on the Udanax-Gold, programming from scratch in Dolphin Smalltalk.
The major first goal was to create a minimal base system for myself, then depending on interest expand it into an open-source project for
future development.


Implementation Language

The current implementation using Dolphin Smalltalk for both the Back-End and Front-End components. Dolphin is a compact, clean, commercial
implementation of Smalltalk for the Windows platform. A trial version can be downloaded from http://www.object-arts.com, and full versions
go up to a couple of hundred dollars in price. Abora is implemented at the time of writing in Dolphin Professional 5.0.1.

A past connection with the Dolphin Smalltalk team led me to be confident that I would be able to get code working at a reasonable rate of knots,
and there wouldn''t be a steep learning curve when working on the Front-End UI.

Unfortunately lots of the things that make Dolphin such a great language to use, are detrimental to the long term wider availability to Abora.
- Commercial environment - will constrain gaining new developers to the project
- Windows only - constrain users as well as developers. It would be good to be able to host Back-Ends on Unix boxes.
- Smalltalk - limits to the pool of available developers. The separation between Front-End and the Back-End opens up the possibility of wider use there.

In the long term, all these issues will probably have to be faced, with the likely result moving to an open source version of Smalltalk such as Squeak,
or a non-commercial version of Smalltalk such as VisualWorks, or even to an entirely different language such as a Java.


Where did the Abora name come from?

Abora was taken from the Xanadu poem.


References
----NEED TO CHECK ALL THESE LINKS-----
Abora website:
http://www.night.dircon.co.uk/abora/index.html

Xanadu/Udanax-Gold
http://www.xanadu.au
http://www.udanax.com
http://www.sunless-sea.net

Xanadu People
tednelson
mark miller
etc
'!

highlightUrlsIn: textEdition for: work
	| contents hyperLinks |
	hyperLinks := OrderedCollection new.
	contents := textEdition contents asAboraText.

	hyperLinks notEmpty ifTrue: [
		| topEdition |
		topEdition := work edition append: hyperLinks asArray.
		work revise: topEdition].!

implementationContents
	^
'Abora Implementation

Abora is strongly influenced by Udanax-Gold implementation by XOC that was released as open source in 1999.

Works and Editions

Front-End / Back-End Split

Endorsements

Ent

Clubs

Front-End network connections

'!

installContents
	^
'Installing Abora

Abora requires: Windows 98, ME, 2000 or XP to run.

Unzip the contents of the distribution zip under your Program Files directory
or any other directory of your choice.


RUNNING
To start Abora: Double click the ABORA.EXE file from MS Explorer.

A workstorage.abora file will be created on exit of the application in the
same directory as the executable. This will then be reloaded in the next
time you start the application. This feature at the moment should only
be considered a demonstration, there is no guarantee that future versions
of Abora will be able to load it in.

If you wish to restart Abora with just the supplied example works; exit
Abora, delete any worksstorage files, and restart Abora.


SOURCE CODE
Abora is currently implemented in Dolphin Smalltalk. The source is 
distributed in the standard Dolphin fashion as .PAC files. You should be able
to install them into Dolphin Smalltalk 5.0.1. See the package comments for
how to start the client and run the test cases.

If you would like to look at the source, but do not have Dolphin Smalltalk, then
the bulk of the .PAC files contents are plain text in fileout format.

In the future I would like to also supply plain text versions of the source in
a suitable form for easier text editor viewing and importing into other Smalltalks.

'!

licenseContents
	^
'COPYRIGHT AND PERMISSION NOTICE

Copyright (c) 2002 David G Jones
All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, provided that the above
copyright notice(s) and this permission notice appear in all copies of
the Software and that both the above copyright notice(s) and this
permission notice appear in supporting documentation.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT
OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL
INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING
FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION
WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

Except as contained in this notice, the name of a copyright holder
shall not be used in advertising or otherwise to promote the sale, use
or other dealings in this Software without prior written authorization
of the copyright holder.'!

postLagoon
	| version |
	[File delete: self releaseDirectory,'\abora.htm'] on: Win32Error do: [:e | "ignore"].
	[File delete: self releaseDirectory,'\abora.ERRORS'] on: Win32Error do: [:e | "ignore"].
	[File delete: self releaseDirectory,'\',WorksStorageDumper new worksStorageFilename] on: Win32Error do: [:e | "ignore"].
	[File delete: self releaseDirectory,'\',WorksStorageDumper new worksStorageOldFilename] on: Win32Error do: [:e | "ignore"].

	version := self releaseVersion.

	File rename: self releaseDirectory to: self baseDirectory,'\abora-',(version copyReplacing: $. withObject: $_).!

releaseDirectory
	^self baseDirectory, '\release'!

releaseVersion
	| version |
	version := ((StsManager current getProjectEditionsFor: 'Abora') asSortedCollection: [:a :b | a timestamp <= b timestamp]) last versionDescriptor.
	version := version subStrings first.
	^version!

reserveSystemIds
	| id |
	id := Id nextId.
	self assert: [id = SystemIds textEdition].
	id := Id nextId.
	self assert: [id = SystemIds hyperLink].
	id := Id nextId.
	self assert: [id = SystemIds singleRef]!

reviseTextEdition: newTextEdition for: work
	| topEdition |
	newTextEdition endorse: SystemIds textEditionEndorsement.
	topEdition := work edition.
	topEdition := topEdition removeFrom: 1 extent: 1.
	topEdition := topEdition insert: newTextEdition at: 1.
	work revise: topEdition.!

tutorialContents
	^
'Brief Tutorial

Currently Abora is nowhere near a 1.0 release for users, but
enough of the functionality is available from the UI that there
are a few interesting things you can do.

- Start up Abora by double clicking the abora.exe
-- You should find the the "Welcome to Abora" work selected
   in the top left pane, and the latest revision of it selected
   in the bottom left pane. The text edition of the work is shown
   in the centre pane. The right pane shows the base edition
   when you are comparing between editions.
- Click in the centre text pane to give it focus

- Add a new line of text after the first line, for example;
  "Hello this is a new line"
- Press CTRL-S to Flush Changes at the end of typing
-- You should see a new Revision appearing in the bottom left pane

- Select the original revision, by selecting Revision 0 in the bottom
  left pane
- Right click and choose Base Edition For Comparison
-- You should now see the same text in the right pane, and all the
   lines of the centre and right panes should have the same
   background colour. This indicates that the contents of these two
   editions are the same - fair enough as they are the same edition

- Select the latest revision, the one which includes your inserted line
-- You should now see the first line of both centre and right panes is
   one color, your inserted line is only present in the left pane with
   no background colour to indicate it is a difference in this edition,
   and all the text following is in a different colour
-- So far this is pretty much what you would see from a standard
   document system or CVS client.

- Now cursor down to the fifth line, and insert the text "really " after
  "This is a ".
- Press CTRL-S to Flush Changes
-- Now the neon is really starting to light up!! The inserted "really "
   should have no background colour, but there are now three
   separate stretches of text from the original edition present.
-- Notice that we are highlighting changes down to an individual
   character rather than line based.

- Now select "Abora" in the first line
- Press CTRL-C to copy it into the clipboard
- Select "This" at the start of the fifth line
- Press CTRL-T to replace "This" with a transcluded copy of "Abora"
-- A new revision has automatically been created for you, and we
   have gained a few more colours on the display.
-- The transclusion operation that we performed by CTRL-T is a little
   like Pasting the clipboard, except that the system remembers where
   the copy originally came from.
-- Reading the background colours at this point indicates that the first
   line is present in both editions, but the highlighting of "Abora" in
   the base edition indicates that the system knows that the Abora in
   the centre pane at line 5 is the same Abora.
-- This has blown the typical text comparison out of the water!!

- You can quickly walk the history of the document by selecting
  Revision 0 in the lower left pane and cursor up and down the revision
  list

- Press CTRL-N to Create Empty Work
- Type: "Slashdot: http://www.slashdot.org"
- Select "http://www.slashdot.org"
- Press CTRL-C then CTRL-L
- Choose URL from the list of Link types
-- You should now see that the url is underlined
- Click on the url, then Right Click and choose Follow Link
-- A web browser should open up on Slashdot

-- Notice that our new work is indicated by "<Unknown>" in the
   top left pane.
-- The title of a work is found by text marked with a link of type Title
- Select "Slashdot"
- Press CTRL-C then CTRL-L
- Choose Title from the list of Link types
-- You should see "Slashdot" underlined, and also the upper left pane
   updating with its new name
'!

urlsIn: textEdition
	| hyperLinks |
	hyperLinks := OrderedCollection new.
	self 
		urlsIn: textEdition
		matchAny: #('http:' 'https:' 'mailto:')
		hyperLinks: hyperLinks.
	^hyperLinks!

urlsIn: textEdition match: match hyperLinks: hyperLinks
	| index contents |
	contents := textEdition contents asAboraText.
	index := 1.
	[(index := contents indexOfSubCollection: match startingAt: index) > 0] whileTrue: 
			[| end ref |
			end := contents indexOfAnyOf: ', ' , String lineDelimiter startingAt: index.
			end = 0 ifTrue: [end := contents size + 1].
			ref := FeSingleRef 
						createOn: textEdition
						from: index
						extent: end - index.
			hyperLinks 
				add: (FeHyperLink createWithAll: (Array with: ref) linkType: FeIds linkUrlEndorsement) 
						edition.
			index := end]!

urlsIn: textEdition matchAny: matches hyperLinks: hyperLinks
	matches do: 
			[:match | 
			self 
				urlsIn: textEdition
				match: match
				hyperLinks: hyperLinks]!

versionsContents
	^
'Abora Released Versions

', self versionString, '
- Fe-Be split - first pass
- Revision Back/Forward accelarator Alt+Up/Alt+Down
- Double buffering of transpointing view to negate flickering

0.060 Sunday, August 25, 2002
- Flushed out the debug menu a bit to see current/all ents for text and top edition of work
- Added a brief text summary of works storage to the debug menu
- Minor code tidy ups

0.056 Friday, August 23, 2002
- Simple persistence support by dumping entire works storage using
  dolphin stb mechanism - only temporary mechanism, with no forward
  compatability promises at this point
- Show connections between mappings when comparing. Based after
  pyxi but using filled regions rather than lines. Not sure if this is an
  improvement or not.
- Follow link for Jump links
- Comparison Follow Point which will try to set point in the base comparison
  edition if it is mapped to the current point in the main edition
- Fixed cut to now delete existing selection after action

0.050 Monday, August 19, 2002
- See other works that transclude the same contents as the current work
- Fixed madness with page up/down and home/end
- Fixed missing input with !! and a few other characters
- Will delay flush changes if deleting just entered characters
- Clear screen cruft after delete

0.049 Saturday, August 17, 2002
- First stab at implementing links in the FrontEnd by transclusion. Use a structure composed of
  hyperlink and singleref editions
- Show links in text by underlining
- Following a URL link will open a browser on the link destination
- Add a simple Links tab for current work in which you can see all the links onto the text of that
  work
- FrontEnd document edition is now a structure of editions; a single text edition and 0 or more
  hyperlink editions
- Added simple implementation of endorsements for tagging editions or works - I use this to mark text
  editions and hyperlink/singleref editions to help indicate the frontend document structure
  and for filtering of transclusions - for example just the title links onto an edition.
- Added a simple toolbar with history feature to move back and forth between works
- Minor tweaks to performance and improvements to text editor refreshing and painting
- Double click to select word
- Select All menu option
- Toggle whether non-native links are shown or not in the text editor
- Title of work now found from title link rather than just from the first line of the text
- Toned down background colours a little - still not good enough
- Simple tutorial to walk through some basic operations in the application

0.041 Sunday, August 11, 2002
 - Removed Transcluded ent node and moved to separate content element and ent node
  setup. This now allows the finding of all editions that include content, and produce mappings
  of sharing between editions.
- Simple visualization of similarities between editions in front-end
- Text editor bunches together simple sequences of inserts or deletes before creating a new edition
- Reduced flashing while inserting/deleting individual characters in text editor
- Support non-text contents stored in Ent
- Work history now stored as frozen works in an edition rather than a collection of editions
- Cut selection in editor
- Support branching of ent version numbers

0.027 Wednesday, July 31, 2002
- Fixed insert if RootNode dsp !!= 0
- Use Windows clipboard
- Delete Selections
- Fixed phantom selection if clicking on last line

0.021 Monday, July 29, 2002
- First Release with subset of Ent tree and simple text editor and works'!

versionString
	^self releaseVersion, ' ', Date today displayString!

welcomeContents
	^
'Welcome to Abora!!!!

', self versionString, '

This is a prototype implementation of a hypertext system inspired
by Ted Nelsons Xanadu and in particular the Udanax-Gold implementation
by XOC that was released as open source in 1999.

Abora is coded from scratch using Dolphin Smalltalk.

As you will quickly find out Abora''s capabilities are currently very limited!! 


IMPLEMENTED FEATURES
Most of these features are just prototype grade and will require
rework before reaching a level suitable for the end user in a stable,
efficient hypertext system.

- Subset of Ent implementation - integer space, no canopies, position based
- Simple transclusions between content elements and Ent tree structure
- Works and editions
- History as frozen works
- Primitive endorsements
- Front-End text editor with browser on Works and editions
- Comparisons between arbitary editions - styled after pyxi by Ka-Ping Ye
- Links implemented by transclusions
- Simple persistence by saving entire works storage as atomic operation
- First pass at Fe-Be (or client/server) split
- Open source
- Test cases
- Executable demo for Windows platform (with fancy colours!!)


KNOWN PROBLEMS
- System slows down significantly for text longer than a few pages
  Prime problem here is just my un-optimized text editor implementation
- Infrequent balancing of Ent tree by Splaying, as my splaying
  implementation currently duplicates too many internal SplitNodes 
- Leaf nodes are split too often in Ent, eg on creating a link that
  doesn''t match existing leaf boundaries
- UI for defining and following Links is very poor and limiting


UPCOMING FEATURES
A rough indication of my current thoughts on the order of attack for the
remaining 98% of Udanax-Gold :-)

- Source Forge project home
- Incremental persistence of data
- FrontEnd - BackEnd split
- WWW read-only frontend
- Support server side on a variety of platforms
- Support large documents
- Clubs and access control
- Rich document support
- User grade UI
- PlaceHolders and Detectors
- BackEnd - BackEnd support
- General Ent and coordinate space support


IMPLEMENTATION
Abora is currently implemented in Dolphin Smalltalk, which is a compact,
commercial, Windows only implementation of Smalltalk. I have included
the Smalltalk source for those of you who are interested.

If you would like to try out the code in the Dolphin IDE, then I am
using Dolphin Smalltalk Professional 5.0.1. Once you have loaded in all
the packages, try:
    FeShell show.
    SUnitBrowser sunitbShow: AboraTests.


LICENSE
This software is released under the MIT X11 license.


THANKS
My sincere thanks to everyone that has contributed to Xanadu and the
Udanax-Gold implementation over the years. Jeff Rush for running the
sunless-sea.net website. My employer Intelliware Development Inc for
allowing me to spend time on the project.


REFERENCES
Abora - http://www.night.dircon.co.uk/abora/index.html
Dolphin Smalltalk - http://www.object-arts.com/
Ent Docs - http://www.sunless-sea.net/wiki/Somebody_s%20paper%20on%20the%20Ent
Intelliware Development Inc - http://www.intelliware.ca/
Sunless Sea - http://www.sunless-sea.net/
Ted Nelson - http://ted.hyperland.com/
Udanax-Gold - http://www.udanax.com/gold/index.html
Xanadu - http://xanadu.com/


I very much welcome any correspondance on the current implementation, UI,
Udanax-Gold revelations and offers of assistance.

Good luck,

David G Jones
mailto:david_jones@night.dircon.co.uk
http://www.night.dircon.co.uk



'!

withFeConnection: newConnection do: niladicValuable
	| oldFeConnection |
	oldFeConnection := FeConnection current.
	FeConnection current: newConnection.
	[niladicValuable value] ensure: [FeConnection current: oldFeConnection].! !
!AboraBuild categoriesFor: #baseDirectory!public! !
!AboraBuild categoriesFor: #build!public! !
!AboraBuild categoriesFor: #buildClub:expectedId:!public! !
!AboraBuild categoriesFor: #buildExampleWork!public! !
!AboraBuild categoriesFor: #buildFeClubs!public! !
!AboraBuild categoriesFor: #buildFeLinks!public! !
!AboraBuild categoriesFor: #buildLink:expectedId:!public! !
!AboraBuild categoriesFor: #buildSystemClubs!public! !
!AboraBuild categoriesFor: #buildTutorialWork!public! !
!AboraBuild categoriesFor: #buildUserHome!public! !
!AboraBuild categoriesFor: #buildVersionsWork!public! !
!AboraBuild categoriesFor: #buildWelcomeAndLicenseWorks!public! !
!AboraBuild categoriesFor: #buildWorksStorage!public! !
!AboraBuild categoriesFor: #clearConnections!public! !
!AboraBuild categoriesFor: #clearWorksStorage!public! !
!AboraBuild categoriesFor: #createFileNamed:with:!private! !
!AboraBuild categoriesFor: #createReleaseFiles!public! !
!AboraBuild categoriesFor: #createTextEdition:!public! !
!AboraBuild categoriesFor: #createTitleLinkOnFirstLine:!public! !
!AboraBuild categoriesFor: #createWorkDocumentOn:!public! !
!AboraBuild categoriesFor: #deployBeAbora!public! !
!AboraBuild categoriesFor: #deployFeAbora!public! !
!AboraBuild categoriesFor: #deployPackageNamed:!public! !
!AboraBuild categoriesFor: #faqContents!public! !
!AboraBuild categoriesFor: #highlightUrlsIn:for:!public! !
!AboraBuild categoriesFor: #implementationContents!public! !
!AboraBuild categoriesFor: #installContents!public! !
!AboraBuild categoriesFor: #licenseContents!public! !
!AboraBuild categoriesFor: #postLagoon!public! !
!AboraBuild categoriesFor: #releaseDirectory!public! !
!AboraBuild categoriesFor: #releaseVersion!public! !
!AboraBuild categoriesFor: #reserveSystemIds!public! !
!AboraBuild categoriesFor: #reviseTextEdition:for:!public! !
!AboraBuild categoriesFor: #tutorialContents!public! !
!AboraBuild categoriesFor: #urlsIn:!public! !
!AboraBuild categoriesFor: #urlsIn:match:hyperLinks:!private! !
!AboraBuild categoriesFor: #urlsIn:matchAny:hyperLinks:!private! !
!AboraBuild categoriesFor: #versionsContents!public! !
!AboraBuild categoriesFor: #versionString!public! !
!AboraBuild categoriesFor: #welcomeContents!public! !
!AboraBuild categoriesFor: #withFeConnection:do:!private! !

