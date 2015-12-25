

import CoreGraphics.CGGeometry

class GameManager : System
{
    private var config : GameConfig
    private var creator : EntityCreator
    
    private var gameNodes : NodeList!
    private var spaceships : NodeList!
    private var asteroids : NodeList!
    private var bullets : NodeList!
    
    init( creator : EntityCreator, config : GameConfig )
    {
        self.creator = creator
        self.config = config
    }
    
    override func addToEngine( engine: Engine )
    {
        gameNodes = engine.getNodeList( GameNode )
        spaceships = engine.getNodeList( SpaceshipNode )
        asteroids = engine.getNodeList( AsteroidCollisionNode )
        bullets = engine.getNodeList( BulletCollisionNode )
    }
    
    override func update( time : Double )
    {
        if let node = gameNodes.head as? GameNode
        {
            if node.state.playing
            {
                if spaceships.empty
                {
                    if node.state.lives > 0
                    {
                        let newSpaceshipPosition =  CGPoint( x : config.width * 0.5, y : config.height * 0.5 )
                        var clearToAddSpaceship = true
                        for asteroidNode in asteroids
                        {
                            let asteroid = asteroidNode as! AsteroidCollisionNode
                            if CGPoint.distance( a : asteroid.position.position, b : newSpaceshipPosition ) <= asteroid.collision.radius + 50
                            {
                                clearToAddSpaceship = false
                                break
                            }
                        }
                        if clearToAddSpaceship
                        {
                            creator.createSpaceship()
                        }
                    }
                    else
                    {
                        node.state.playing = false
                        creator.createWaitForClick()
                    }
                }
                
                if asteroids.empty && bullets.empty && !spaceships.empty
                {
                    // next level
                    let spaceship : SpaceshipNode = spaceships.head as! SpaceshipNode
                    node.state.level++;
                    let asteroidCount : Int = 2 + node.state.level
                    for var i:Int = 0; i < asteroidCount; ++i
                    {
                        // check not on top of spaceship
                        var position = CGPointZero
                        repeat
                        {
                            position =  CGPoint( x: CGFloat.random() * config.width, y: CGFloat.random() * config.height )
                        }
                            while  CGPoint.distance( a: position, b: spaceship.position.position ) <= 80
                        creator.createAsteroid( radius: 30, x: position.x, y : position.y )
                    }
                }
            }
        }
    }
    
    override func removeFromEngine( engine: Engine )
    {
        gameNodes = nil
        spaceships = nil
        asteroids = nil
        bullets = nil
    }
}