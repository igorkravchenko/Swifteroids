
import CoreGraphics.CGGeometry

class CollisionSystem : System
{
    unowned var creator : EntityCreator

    weak var games : NodeList!
    weak var spaceships : NodeList!
    weak var asteroids : NodeList!
    weak var bullets : NodeList!
    
    init( creator : EntityCreator )
    {
        self.creator = creator
        super.init()
    }
    
    override func addToEngine(engine: Engine)
    {
        games = engine.getNodeList( GameNode )
        spaceships = engine.getNodeList( SpaceshipCollisionNode )
        asteroids = engine.getNodeList( AsteroidCollisionNode )
        bullets = engine.getNodeList( BulletCollisionNode )
    }
    
    override func update( time : Double )
    {
        for bulletNode in bullets
        {
            let bullet = bulletNode as! BulletCollisionNode
            for asteroidNode in asteroids
            {
                let asteroid = asteroidNode as! AsteroidCollisionNode
                // TODO: calclate distance as squared
                if CGPoint.distance( a: asteroid.position.position, b: bullet.position.position ) <= asteroid.collision.radius
                {
                    creator.destroyEntity( bullet.entity )
                    if asteroid.collision.radius > 10
                    {
                        creator.createAsteroid( radius: asteroid.collision.radius - 10,
                            x: asteroid.position.position.x + CGFloat.random() * 10 - 5,
                            y: asteroid.position.position.y + CGFloat.random() * 10 - 5 )
                        creator.createAsteroid(radius: asteroid.collision.radius - 10,
                            x: asteroid.position.position.x + CGFloat.random() * 10 - 5,
                            y: asteroid.position.position.y + CGFloat.random() * 10 - 5 )
                    }
                    asteroid.asteroid.fsm.changeState( "destroyed" )
                    asteroid.audio.play( AudioAsset.ExplodeAsteroid.rawValue )
                    
                    if let game = games.head as? GameNode
                    {
                        game.state.hits++
                    }
                    break
                }
            }
        }
        
        for spaceshipNode in spaceships
        {
            let spaceship = spaceshipNode as! SpaceshipCollisionNode
            for asteroidNode in asteroids
            {
                let asteroid = asteroidNode as! AsteroidCollisionNode
                if CGPoint.distance( a : asteroid.position.position, b : spaceship.position.position ) <= asteroid.collision.radius + spaceship.collision.radius
                {
                    spaceship.spaceship.fsm.changeState( "destroyed" )
                    spaceship.audio.play( AudioAsset.ExplodeShip.rawValue )
                    
                    if let game = games.head as? GameNode
                    {
                        game.state.lives--
                    }

                    break
                }
            }
        }
    }

    override func removeFromEngine( engine : Engine )
    {
        spaceships = nil
        asteroids = nil
        bullets = nil
    }
}