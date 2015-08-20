
import CoreGraphics

class EntityCreator
{
    private var engine : Engine
    private var config : GameConfig
    private var keyPoll : TriggerPoll
    lazy private var waitEntity:Entity =
    {
        let waitView = WaitForStartView( size : CGSize( width : self.config.width, height : self.config.height ) )
        let entity = Entity( name: "wait" )
            .add( WaitForStart( waitForStart : waitView ) )
            .add( Display( displayObject : waitView ) )
            .add( Position( x : 0, y : 0, rotation : 0 ) )
        return entity
    }()
    
    init( engine : Engine, config : GameConfig, keyPoll : TriggerPoll)
    {
        self.engine = engine
        self.config = config
        self.keyPoll = keyPoll
    }
    
    func destroyEntity( entity:Entity )
    {
        engine.removeEntity( entity )
    }
    
    func createGame() -> Entity
    {
        let hud  =  HudView( size : CGSize( width : config.width, height : config.height ) )
    
        let gameEntity = Entity( name: "game" )
            .add( GameState() )
            .add( Hud( view : hud ) )
            .add( Display( displayObject : hud ) )
            .add( Position( x : 0, y : 0, rotation : 0 ) )
        engine.addEntity( gameEntity )
        return gameEntity
    }
    
    func createWaitForClick() -> Entity
    {
        ( waitEntity.get( WaitForStart ) as! WaitForStart).startGame = false
        engine.addEntity( waitEntity )
        return waitEntity
    }
    
    func createAsteroid(radius radius : CGFloat, x : CGFloat, y : CGFloat ) -> Entity
    {
        let asteroid : Entity = Entity()
        
        let fsm = EntityStateMachine( entity: asteroid )
        
        fsm.createState( "alive" )
        
            .add( Motion ).withInstance( Motion( velocityX : ( CGFloat.random() - 0.5 ) * 4 * ( 50 - radius ),
                                                     velocityY : ( CGFloat.random() - 0.5 ) * 4 * ( 50 - radius ),
                                                     angularVelocity : CGFloat.random() * 2 - 1,
                                                     damping : 0 ) )
            .add( Collision ).withInstance( Collision( radius : radius ) )
            .add( Display ).withInstance( Display( displayObject : AsteroidView( radius : radius ) ) )
        
        let deathView : AsteroidDeathView = AsteroidDeathView( radius : radius )
        fsm.createState( "destroyed" )
            .add( DeathThroes ).withInstance( DeathThroes( duration : 3 ) )
            .add( Display ).withInstance( Display( displayObject : deathView ) )
            .add( Animation ).withInstance( Animation( animation : deathView ) )
        
        
        asteroid
            .add( Asteroid( fsm : fsm ) )
            .add( Position( x : x, y : y, rotation : 0 ) )
            .add( Audio() )
                    
        fsm.changeState( "alive" );

        engine.addEntity( asteroid );
        return asteroid;
    }
    
    func createSpaceship() -> Entity
    {
        let spaceship  = Entity()
        let fsm = EntityStateMachine( entity : spaceship )
        
        fsm.createState( "playing" )
            .add( Motion ).withInstance(  Motion( velocityX : 0, velocityY : 0, angularVelocity : 0, damping : 15 ) )
            .add( MotionControls ).withInstance( MotionControls( left: Trigger.Left.rawValue, right: Trigger.Right.rawValue,
                accelerate:Trigger.Up.rawValue, accelerationRate : 100, rotationRate : 3 ) )
            .add( Gun ).withInstance( Gun( offsetX : 8, offsetY : 0, minimumShotInterval : 0.3, bulletLifetime : 2 ) )
            .add( GunControls ).withInstance( GunControls( trigger: Trigger.Gun.rawValue ) )
            .add( Collision ).withInstance( Collision( radius : 18 ) )
            .add( Display ).withInstance( Display( displayObject : SpaceshipView( radius : 18 ) ) )
        
        let deathView = SpaceshipDeathView()
        fsm.createState( "destroyed" )
            .add( DeathThroes ).withInstance( DeathThroes( duration : 5 ) )
            .add( Display ).withInstance( Display( displayObject: deathView ) )
            .add( Animation ).withInstance(  Animation( animation: deathView ) )
        
        spaceship
            .add( Spaceship( fsm : fsm ) )
            .add( Position( x : config.width / 2, y : config.height / 2, rotation : 0 ) )
            .add( Audio() )
                    
        fsm.changeState( "playing" )
        engine.addEntity( spaceship )
        return spaceship;
    }
    
    func createUserBullet(gun gun : Gun, parentPosition : Position ) -> Entity
    {
        let cosine = cos( parentPosition.rotation )
        let sine = sin( parentPosition.rotation )
        let bullet = Entity()
            .add( Bullet( lifetime: gun.bulletLifetime ) )
            .add( Position(
        x : cosine * gun.offsetFromParent.x - sine * gun.offsetFromParent.y + parentPosition.position.x,
        y : sine * gun.offsetFromParent.x + cosine * gun.offsetFromParent.y + parentPosition.position.y, rotation: 0 ) )
            .add( Collision( radius : 0 ) )
            .add( Motion( velocityX : cosine * 150, velocityY : sine * 150, angularVelocity : 0, damping : 0 ) )
            .add( Display( displayObject : BulletView() ) )
        engine.addEntity( bullet )
        return bullet;
    }
    
    func createControls () -> Entity
    {
        let inputView = InputView( size: CGSize( width: config.width, height: config.height ) )
        let controls = Entity( name : "controls" )
            .add( Input( view : inputView) )
            .add( Display( displayObject : inputView, displayOrder : DisplayOrder.Foreground.rawValue ) )
            .add( Position( x : 0, y : 0, rotation : 0) )
        engine.addEntity( controls )
        return controls
    }
    
    func createStarField() -> Entity
    {
        let starFieldView = StarFieldView( size: CGSize( width : config.width, height : config.height ) )
        let starField = Entity()
            .add( StarField( view : starFieldView) )
            .add( Animation( animation : starFieldView ) )
            .add( Display( displayObject : starFieldView, displayOrder : DisplayOrder.Stars.rawValue ) )
            .add( Position( x : 0, y : 0, rotation : 0) )
        engine.addEntity( starField )
        return starField
    }
}