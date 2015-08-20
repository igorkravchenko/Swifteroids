
import SpriteKit.SKNode

class Asteroids : NSObject, SKSceneDelegate
{
    private var container : SKScene
    private let engine = Engine()

    private var creator : EntityCreator!
    private let keyPoll = TriggerPoll()
    private var config : GameConfig!

    private var previousTime : NSTimeInterval = 0

    init( container : SKScene, width : CGFloat, height : CGFloat )
    {
        self.container = container
        super.init()
        prepare( width : width, height : height )
    }
    
    private func prepare(width width : CGFloat, height : CGFloat )
    {
        
        config =  GameConfig()
        config.width = width
        config.height = height
        
        creator = EntityCreator( engine : engine, config : config, keyPoll : keyPoll )
        
        engine.addSystem( WaitForStartSystem( creator : creator ), priority : SystemPriorities.preUpdate.rawValue )
        engine.addSystem( GameManager( creator : creator, config : config ), priority : SystemPriorities.preUpdate.rawValue )
        engine.addSystem( MotionControlSystem( triggerPoll : keyPoll ), priority : SystemPriorities.update.rawValue )
        engine.addSystem( GunControlSystem( triggerPoll : keyPoll, creator: creator ), priority : SystemPriorities.update.rawValue )
        engine.addSystem( BulletAgeSystem( creator : creator ), priority : SystemPriorities.update.rawValue )
        engine.addSystem( DeathThroesSystem( creator : creator ), priority : SystemPriorities.update.rawValue )
        engine.addSystem( MovementSystem( config : config ), priority: SystemPriorities.move.rawValue )
        engine.addSystem( CollisionSystem( creator : creator ), priority: SystemPriorities.resolveCollisions.rawValue )
        engine.addSystem( AnimationSystem(), priority : SystemPriorities.animate.rawValue )
        engine.addSystem( HudSystem(), priority : SystemPriorities.animate.rawValue )
        engine.addSystem( RenderSystem( container : container ), priority: SystemPriorities.render.rawValue )
        engine.addSystem( AudioSystem( scene : container ), priority : SystemPriorities.render.rawValue )
        engine.addSystem( InputSystem( trigger: keyPoll ), priority: SystemPriorities.preUpdate.rawValue )
        engine.addSystem( StarFieldMovementSystem(), priority: SystemPriorities.animate.rawValue )
    
        creator.createControls()
        creator.createWaitForClick()
        creator.createGame()
        creator.createStarField()
        
        NSNotificationCenter.defaultCenter().addObserver( self, selector: "onApplicationDidBecomeActive:", name: UIApplicationDidBecomeActiveNotification, object: nil )
    }
    
    func start()
    {
        container.delegate = self
    }

    func update(currentTime : NSTimeInterval, forScene scene : SKScene)
    {
        if previousTime != 0
        {
            let delta = currentTime - previousTime

            engine.update(delta)
        }

        previousTime = currentTime
    }
    
    func onApplicationDidBecomeActive( notification : NSNotification )
    {
        container.view?.paused = false
    }
    
    deinit
    {
        NSNotificationCenter.defaultCenter().removeObserver( self )
    }
}