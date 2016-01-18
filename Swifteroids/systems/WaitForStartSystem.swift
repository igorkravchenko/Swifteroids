
class WaitForStartSystem : System
{
    weak private var engine : Engine!
    weak private var creator : EntityCreator!
    
    weak private var gameNodes : NodeList!
    weak private var waitNodes : NodeList!
    weak private var asteroids : NodeList!
    
    init( creator : EntityCreator )
    {
        self.creator = creator
        super.init()
    }
    
    override func addToEngine( engine : Engine )
    {
        self.engine = engine
        waitNodes = engine.getNodeList( WaitForStartNode )
        gameNodes = engine.getNodeList( GameNode )
        asteroids = engine.getNodeList( AsteroidCollisionNode )
    }
    
    override func update( time : NSTimeInterval )
    {
        if let node  = waitNodes.head as? WaitForStartNode
        {
            if let game = gameNodes.head as? GameNode
            {
                if node.wait.startGame
                {
                    for asteroidNode in asteroids
                    {
                        let asteroid = asteroidNode as! AsteroidCollisionNode
                        creator.destroyEntity( asteroid.entity );
                    }
                    
                    game.state.setForStart()
                    node.wait.startGame = false
                    engine.removeEntity( node.entity )
                }
            }
        }
    }
    
    override func removeFromEngine( engine : Engine )
    {
        gameNodes = nil
        waitNodes = nil
    }
}