"This is a Dolphin Smalltalk workspace for Abora hypertext"

"Show main Abora client window"
Time millisecondsToRun: [FeShell show]. 

"Show server window"
BeShell show. 
Metaclass allInstances select: [:m| m instanceClass name = #LoggerPresenter]

"Test Cases"
SUnitBrowser sunitbShow: AboraTests.
SUnitBrowser sunitbShow: AboraBeTests.
SUnitBrowser sunitbShow: AboraFeTests.
SUnitBrowser sunitbShow: AboraFeUiTests.

SUnitBrowser sunitbShow: FeHyperLinkTest.
SUnitBrowser sunitbShow: ContentCacheTest.
SUnitBrowser sunitbShow: AboraSystemTest.

"Building"
AboraBuild new build.
AboraBuild new deployFeAbora. 
AboraBuild new deployBeAbora. 
AboraBuild new postLagoon.

"regenerate custom views - required if their instance shape changes"
FeConnection current: FeDirectConnection new.
FeTextPresenter addView: FeTextView asResource: View defaultView.
FeTranspointingPresenter addView: FeTranspointingView asResource: View defaultView.

"simulate start-up FE in deployed executable - clear down all servery defs to ensure we wont be confused by access to old local beX objects"
AboraBuild new clearWorksStorage; clearConnections.
AboraSessionManager basicNew main.

"simulate start-up BE in deployed executable - will try and load/save worksStorage file"
BeAboraSessionManager basicNew main.

"Start network listener"
BeNetworkListener current: (BeNetworkListener port: BeNetworkListener defaultPort).
BeNetworkListener current accept.
BeNetworkListener current close.

"====================================================================="
FeIdLookup current
FeTranspointingView allInstances first oneWayBecome: nil
AboraLoggerConstants
Transcript show: 'hh'
TranscriptShell current
LoggerLevel allInstances size
LoggerPresenter allInstances last view richText
AboraLogger connection debug: ['hello'].
AboraLogger connection info: ['info'].
AboraLogger connection warn: ['warning'].
AboraLogger connection error: ['error'].
AboraLogger connection fatal: ['fatal'].
Color choose
AboraLogger connection effectiveAppenders
Sound bell
AboraLoggerConstants := PoolDictionary new
AboraLogger connection
AboraLogger current appender
Win32Constants
Id nextId
FeIdLookup current size.
FeIdLookup allInstances
FeProxy allInstances size.
WorksStorage current
BeNetworkListener allInstances size
FeWork allInstances size.
FeEdition allInstances size.
BeEdition allInstances size. 
BeWork allInstances size.  
BeClub allInstances size. 
BeShell show
c := FeProxy allInstances first
b := ByteArray writeStream: 128.
(STBOutFiler on: b) context: #forBe;  nextPut: c.
b size
(STBDebugger on: (ReadStream on: b contents)) next

BeNetworkListener current: (BeNetworkListener port: BeNetworkListener defaultPort).
BeNetworkListener current accept.
BeNetworkListener current close.
BeNetworkListener current totalCalls. 
BeNetworkListener current: nil
BeNetworkListener current
BeNetworkListener allInstances do: [:y | y close]

FeConnection current connection
FeConnection current:  (FeNetworkConnection ip: #[127 0 0 1])
FeConnection current close.
FeConnection current: nil
FeConnection current: (FeBackgroundConnection onConnection: ((FeNetworkConnection ip: '127.0.0.1') connect; yourself))

BeServer current sessions last feContentElements size

BlockingCallMonitor allInstances
x := Transcript.
Transcript := x
Transcript := BeShell showa BeShell
Transcript show: 'hhel';cr
BeServer initialize
FindBeServerDialog showModalOn: (FeNetworkConnection ip: 'localhost')
WorksStorage initialize.
FeIdLookup initialize.
FeProxy forId:
FeConnection current send: (MessageSend receiver: Time selector: #now)
FeConnection current send: (MessageSend receiver: (FeProxy forId: WorksStorage current works first id class: WorksStorage current works first class) selector: #edition)
Sound errorBeep
Sound bell.
x := FeTextModel empty.
WorksStorage current lookupId: (Id new value: 107)
FeIdLookup current
File splitPathFrom: SessionManager current argv first
'hello %1 there' formatWith: 'bob'
FePreferencesDialog showa FePreferencesDialog
SessionManager
b := Font choose
b pointSize
WorksStorage current
(TextPresenter showOn: 'hello there') view topView caption: 'blah'
SplitNode allInstances size
bytes := (WeakLookupTable new at: 1 put: 'hello'; yourself) binaryStoreBytes.
a := Object fromBinaryStoreBytes:bytes.
a
a := nil
MemoryManager current compact;administerLastRites; directFunerals
Smalltalk at: #Integer
WorksStorage current idLookup. 
WorksStorage allInstances size. 
WorksStorage current knownIds. 
108
WorksStorage current binaryStoreBytes size

stream := STBOutFiler on: (WriteStream on: ByteArray new).
stream context: #forFe.
stream nextPut: WorksStorage current.
stream flush
stream stream contents size
a := Object fromBinaryStoreBytes: stream stream contents.
a idLookup postResize: a idLookup.
FeConnection current: FeDirectConnection new.
a 
a works first == WorksStorage current works first
isKindOf: BeClub
WorksStorage current
a := nil

BeEdition allInstances size - (BeEdition allInstances collect: [:b | b id]) asSet size
BeWork allInstances size - (BeWork allInstances collect: [:b | b id]) asSet size
['hello'] binaryStoreBytes size

Color choose
ProfileBrowser show.
Profiler reset.
Profiler profile: [10000 factorial]


conn := BeConnection port: 5678.
conn connect.
conn close.
"Client A"
socketA := Socket port: 5678 address: (InternetAddress ipAddress: #[127 0 0 1]).
socketA connect.
socketA send: '5 factorial'; receive. 
socketA close.
Transcript show: 'hell'