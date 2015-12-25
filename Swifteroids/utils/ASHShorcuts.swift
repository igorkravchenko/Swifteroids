typealias ComponentMatchingFamily = ASHComponentMatchingFamily
typealias Engine = ASHEngine
typealias Entity = ASHEntity
typealias EntityList = ASHEntityList
typealias Family = ASHFamily
typealias Node = ASHNode
typealias NodeList = ASHNodeList
typealias NodePool = ASHNodePool
typealias System = ASHSystem
typealias SystemList	 = ASHSystemList

typealias ComponentTypeProvider = ASHComponentTypeProvider
typealias EngineStateMachine = ASHEngineStateMachine
typealias EntityState = ASHEntityState
typealias DynamicSystemProvider = ASHDynamicSystemProvider
typealias DynamicComponentProvider = ASHDynamicComponentProvider
typealias SystemProvider = ASHSystemProvider
typealias EngineState = ASHEngineState
typealias ComponentSingletonProvider = ASHComponentSingletonProvider
typealias EntityStateMachine = ASHEntityStateMachine
typealias StateSystemMapping = ASHStateSystemMapping
typealias ComponentInstanceProvider = ASHComponentInstanceProvider
typealias StateComponentMapping = ASHStateComponentMapping
typealias SystemInstanceProvider = ASHSystemInstanceProvider
typealias SystemSingletonProvider = ASHSystemSingletonProvider
typealias ComponentProvider = ASHComponentProvider

typealias EngineCodec = ASHEngineCodec
typealias EngineDecoder = ASHEngineDecoder
typealias EngineEncoder = ASHEngineEncoder
typealias JsonEngineCodec = ASHJsonEngineCodec
typealias ObjectEngineCodec = ASHObjectEngineCodec

typealias ArrayObjectCodec = ASHArrayObjectCodec
typealias ClassObjectCodec = ASHClassObjectCodec
typealias CodecManager = ASHCodecManager
typealias NativeObjectCodec = ASHNativeObjectCodec
typealias ObjectCodec = ASHObjectCodec
typealias ObjectReflection = ASHObjectReflection
typealias ObjectReflectionFactory = ASHObjectReflectionFactory
typealias ReflectionObjectCodec = ASHReflectionObjectCodec
typealias TypeAssociations = ASHTypeAssociations
typealias ValueObjectCodec = ASHValueObjectCodec

typealias ListenerNode = ASHListenerNode
typealias ListenerNodePool = ASHListenerNodePool
typealias Signal0 = ASHSignal0
typealias Signal1 = ASHSignal1
typealias Signal2 = ASHSignal2
typealias Signal3 = ASHSignal3
typealias SignalAny = ASHSignalAny
typealias SignalBase = ASHSignalBase

typealias FixedTickProvider = ASHFixedTickProvider
typealias FrameTickProvider = ASHFrameTickProvider
typealias TickProvider = ASHTickProvider

typealias ComponentPool = ASHComponentPool
typealias ListIteratingSystem = ASHListIteratingSystem

extension Entity
{
    func add( component : AnyObject ) -> Entity
    {
        return addComponent( component )
    }
    
    func get( componentClass : AnyClass ) -> AnyObject?
    {
        return getComponent( componentClass )
    }
}

extension SignalBase
{
    func add( target : AnyObject, action : Selector )
    {
        self.addListener( target, action: action )
    }
    
    func addOnce( target : AnyObject, action : Selector )
    {
        self.addListenerOnce( target, action: action )
    }
    
    func remove( target : AnyObject, action : Selector )
    {
        self.removeListener( target, action: action )
    }
}

extension NodeList : SequenceType
{
    var empty : Bool
    {
        get
        {
            return self.isEmpty()
        }
    }
    
    public func generate() -> NSFastGenerator
    {
        return NSFastGenerator( self )
    }
}
