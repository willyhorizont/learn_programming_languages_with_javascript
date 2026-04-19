"
GNU Smalltalk Types
https://www.gnu.org/software/smalltalk/manual-base/html_node/Base-classes.html
Autoload
Object
  Behavior
    ClassDescription
      Class
      Metaclass
  BlockClosure
  Boolean
    False
    True
  CObject
    CAggregate
      CArray
      CPtr
        CString
    CCallable
      CCallbackDescriptor
      CFunctionDescriptor
    CCompound
      CStruct
      CUnion
    CScalar
      CChar
      CDouble
      CFloat
      CInt
      CLong
      CLongDouble
      CLongLong
      CShort
      CSmalltalk
      CUChar
        CByte
          CBoolean
      CUInt
      CULong
      CULongLong
      CUShort
  ContextPart
    BlockContext
    MethodContext
  Continuation
  CType
    CPtrCType
      CArrayCType
    CScalarCType
      CStringCType
  Delay
  Directory
  DLD
  DumperProxy
    AlternativeObjectProxy
      NullProxy
        VersionableObjectProxy
      PluggableProxy
      SingletonProxy
  DynamicVariable
  Exception
    Error
      ArithmeticError
        ZeroDivide
      MessageNotUnderstood
      SystemExceptions.InvalidValue
        SystemExceptions.EmptyCollection
        SystemExceptions.InvalidArgument
          SystemExceptions.AlreadyDefined
          SystemExceptions.ArgumentOutOfRange
            SystemExceptions.IndexOutOfRange
          SystemExceptions.InvalidSize
          SystemExceptions.NotFound
            SystemExceptions.PackageNotAvailable
        SystemExceptions.InvalidProcessState
        SystemExceptions.InvalidState
        SystemExceptions.NotIndexable
        SystemExceptions.ProcessTerminated
        SystemExceptions.ReadOnlyObject
        SystemExceptions.WrongClass
          SystemExceptions.MustBeBoolean
      SystemExceptions.MutationError
      SystemExceptions.NotEnoughElements
      SystemExceptions.NotImplemented
        SystemExceptions.NotYetImplemented
        SystemExceptions.ShouldNotImplement
          SystemExceptions.SubclassResponsibility
          SystemExceptions.WrongMessageSent
      SystemExceptions.VMError
        SystemExceptions.BadReturn
        SystemExceptions.NoRunnableProcess
        SystemExceptions.PrimitiveFailed
          SystemExceptions.CInterfaceError
          SystemExceptions.FileError
          SystemExceptions.WrongArgumentCount
        SystemExceptions.SecurityError
        SystemExceptions.UserInterrupt
        SystemExceptions.VerificationError
    Halt
    Notification
      SystemExceptions.EndOfStream
      SystemExceptions.ProcessBeingTerminated
      Warning
    SystemExceptions.UnhandledException
  ExceptionSet
  FilePath
    File
    VFS.ArchiveMember
      VFS.TmpFileArchiveMember
        VFS.StoredZipMember
    VFS.FileWrapper
      VFS.ArchiveFile
        VFS.ZipFile
  FileSegment
  Getopt
  Iterable
    Collection
      Bag
      HashedCollection
        Dictionary
          BindingDictionary
            AbstractNamespace
              Namespace
              RootNamespace
                SystemDictionary
          LookupTable
            IdentityDictionary
              MethodDictionary
            WeakValueLookupTable
              WeakValueIdentityDictionary
          WeakKeyDictionary
            WeakKeyIdentityDictionary
        Set
          IdentitySet
          WeakSet
            WeakIdentitySet
      MappedCollection
      SequenceableCollection
        ArrayedCollection
          Array
            WeakArray
          ByteArray
          CharacterArray
            String
              Symbol
            UnicodeString
          CompiledCode
            CompiledBlock
            CompiledMethod
          Interval
          LargeArrayedCollection
            LargeArray
            LargeByteArray
            LargeWordArray
          WordArray
        LinkedList
          Semaphore
        OrderedCollection
          RunArray
          SortedCollection
    Stream
      FileDescriptor
        FileStream
      Generator
      ObjectDumper
      PositionableStream
        ReadStream
        WriteStream
          ReadWriteStream
      Random
      TextCollector
  Kernel.PackageInfo
    Package
  Link
    Process
      CallinProcess
    SymLink
  Magnitude
    Character
      UnicodeCharacter
    Date
      DateTime
    LookupKey
      Association
        HomedAssociation
          VariableBinding
      DeferredVariableBinding
      ProcessVariable
    Number
      Float
        FloatD
        FloatE
        FloatQ
      Fraction
      Integer
        LargeInteger
          LargeNegativeInteger
          LargePositiveInteger
            LargeZeroInteger
        SmallInteger
      ScaledDecimal
    Time
      Duration
  Memory
  Message
    DirectedMessage
  MethodInfo
  NetClients.URIResolver
  NetClients.URL
  ObjectMemory
  PackageLoader
  Permission
  Point
  ProcessEnvironment
  ProcessorScheduler
  Rectangle
  RecursionLock
  Regex
  RegexResults
  SecurityPolicy
  SharedQueue
  UndefinedObject
  ValueAdaptor
    NullValueHolder
    PluggableAdaptor
      DelayedAdaptor
    ValueHolder
      Promise
"

jsLikeType := Dictionary from: { 'Null' -> 'Null'. 'Boolean' -> 'Boolean'. 'String' -> 'String'. 'Numeric' -> 'Numeric'. 'Object' -> 'Object'. 'Array' -> 'Array'. 'Function' -> 'Function'. }.
smalltalkTypesJsLikeNull := { 'UndefinedObject' }.
smalltalkTypesJsLikeNumeric := { 'Number'. 'Float'. 'FloatD'. 'FloatE'. 'FloatQ'. 'Fraction'. 'Integer'. 'LargeInteger'. 'LargeNegativeInteger'. 'LargePositiveInteger'. 'LargeZeroInteger'. 'SmallInteger'. 'ScaledDecimal' }.
smalltalkTypesJsLikeString := { 'CString'. 'CStringCType'. 'String'. 'Symbol'. 'Character' }.
smalltalkTypesJsLikeBoolean := { 'Boolean'. 'True'. 'False' }.
smalltalkTypesJsLikeObject := { 'Dictionary' }.
smalltalkTypesJsLikeArray := { 'OrderedCollection'. 'Array' }.
smalltalkTypesJsLikeFunction := { 'BlockClosure' }.
isLikeJsNull := [ :variadicArguments | [ :anything | ((smalltalkTypesJsLikeNull includes: (anything class name asString)) & (anything ifNil: [ true ] ifNotNil: [ false ])) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsBoolean := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ ((smalltalkTypesJsLikeBoolean includes: (anything class name asString)) & ((anything = true) | (anything = false))) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsString := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ (smalltalkTypesJsLikeString includes: (anything class name asString)) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsNumeric := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ (smalltalkTypesJsLikeNumeric includes: (anything class name asString)) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsObject := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ (smalltalkTypesJsLikeObject includes: (anything class name asString)) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsArray := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ (smalltalkTypesJsLikeArray includes: (anything class name asString)) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
isLikeJsFunction := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ false ] ifFalse: [ (smalltalkTypesJsLikeFunction includes: (anything class name asString)) ]) ] valueWithArguments: { (variadicArguments at: 1) } ].
getType := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ (jsLikeType at: 'Null' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsBoolean value: { anything }) ifTrue: [ (jsLikeType at: 'Boolean' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsString value: { anything }) ifTrue: [ (jsLikeType at: 'String' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsNumeric value: { anything }) ifTrue: [ (jsLikeType at: 'Numeric' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsArray value: { anything }) ifTrue: [ (jsLikeType at: 'Array' ifAbsent: [ 'undefined' ]) ] ifFalse: [  ((isLikeJsObject value: { anything }) ifTrue: [ (jsLikeType at: 'Object' ifAbsent: [ 'undefined' ]) ] ifFalse: [  ((isLikeJsFunction value: { anything }) ifTrue: [ (jsLikeType at: 'Function' ifAbsent: [ 'undefined' ]) ] ifFalse: [ (anything class name asString) ]) ]) ]) ]) ]) ]) ]) ] valueWithArguments: { (variadicArguments at: 1) } ]. "getTypeV2"

"getTypeV1"
getTypeV1 := [ :variadicArguments |
    [ :anything |
        ((isLikeJsNull value: { anything })
            ifTrue: [ (jsLikeType at: 'Null' ifAbsent: [ 'undefined' ]) ]
            ifFalse: [
                ((isLikeJsBoolean value: { anything })
                    ifTrue: [ (jsLikeType at: 'Boolean' ifAbsent: [ 'undefined' ]) ]
                    ifFalse: [
                        ((isLikeJsString value: { anything })
                            ifTrue: [ (jsLikeType at: 'String' ifAbsent: [ 'undefined' ]) ]
                            ifFalse: [
                                ((isLikeJsNumeric value: { anything })
                                    ifTrue: [ (jsLikeType at: 'Numeric' ifAbsent: [ 'undefined' ]) ]
                                    ifFalse: [
                                        ((isLikeJsArray value: { anything })
                                            ifTrue: [ (jsLikeType at: 'Array' ifAbsent: [ 'undefined' ]) ]
                                            ifFalse: [ 
                                                ((isLikeJsObject value: { anything })
                                                    ifTrue: [ (jsLikeType at: 'Object' ifAbsent: [ 'undefined' ]) ]
                                                    ifFalse: [ 
                                                        ((isLikeJsFunction value: { anything })
                                                            ifTrue: [ (jsLikeType at: 'Function' ifAbsent: [ 'undefined' ]) ]
                                                            ifFalse: [ (anything class name asString) ])
                                                    ])
                                             ])
                                    ])
                            ])
                    ])
            ])
    ] valueWithArguments: { (variadicArguments at: 1) }
].

getTypeV2 := [ :variadicArguments | [ :anything | ((isLikeJsNull value: { anything }) ifTrue: [ (jsLikeType at: 'Null' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsBoolean value: { anything }) ifTrue: [ (jsLikeType at: 'Boolean' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsString value: { anything }) ifTrue: [ (jsLikeType at: 'String' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsNumeric value: { anything }) ifTrue: [ (jsLikeType at: 'Numeric' ifAbsent: [ 'undefined' ]) ] ifFalse: [ ((isLikeJsArray value: { anything }) ifTrue: [ (jsLikeType at: 'Array' ifAbsent: [ 'undefined' ]) ] ifFalse: [  ((isLikeJsObject value: { anything }) ifTrue: [ (jsLikeType at: 'Object' ifAbsent: [ 'undefined' ]) ] ifFalse: [  ((isLikeJsFunction value: { anything }) ifTrue: [ (jsLikeType at: 'Function' ifAbsent: [ 'undefined' ]) ] ifFalse: [ (anything class name asString) ]) ]) ]) ]) ]) ]) ]) ] valueWithArguments: { (variadicArguments at: 1) } ]. "getTypeV2"

anyString := 'foo'.
anyNumeric := 123.
anyBoolean := true.
anyNull := nil.
anyArray := { 1. 2. 3 }.
anyObject := Dictionary from: { 'foo' -> 'bar' }.
anyFunction := [ :variadicArguments | [ :rectangleWidth :rectangleLength | (rectangleWidth * rectangleLength) ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) } ].

anyFunction1 := [ :variadicArguments |
    rectangleWidth := variadicArguments at: 1.
    rectangleLength := variadicArguments at: 2.
    (rectangleWidth * rectangleLength).
].
anyFunction2 := [ :variadicArguments |
    [ :rectangleWidth :rectangleLength |
        (rectangleWidth * rectangleLength).
    ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) }.
].
anyFunction3 := [ :variadicArguments | [ :rectangleWidth :rectangleLength | (rectangleWidth * rectangleLength) ] valueWithArguments: { (variadicArguments at: 1). (variadicArguments at: 2) } ].

(getTypeV1 value: { anyString }) displayNl.
(getTypeV1 value: { anyNumeric }) displayNl.
(getTypeV1 value: { anyBoolean }) displayNl.
(getTypeV1 value: { anyNull }) displayNl.
(getTypeV1 value: { anyArray }) displayNl.
(getTypeV1 value: { anyObject }) displayNl.
(getTypeV1 value: { anyFunction }) displayNl.
(anyFunction1 value: { 7. 5 }) displayNl.
(anyFunction2 value: { 7. 5 }) displayNl.
(anyFunction3 value: { 7. 5 }) displayNl.
