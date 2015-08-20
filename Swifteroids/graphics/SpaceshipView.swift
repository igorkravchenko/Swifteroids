
import SpriteKit.SKSpriteNode

class SpaceshipView : SKNode
{
    let sprite = SKSpriteNode( imageNamed : "spaceship")
    let particles = SKEmitterNode ( fileNamed: "spaceship-flame.sks" )!
    
    required init?( coder: NSCoder )
    {
        super.init( coder: coder )
    }
    
    init( radius : CGFloat )
    {
        super.init()
        sprite.zRotation = -CGFloat.PI / 2.0
        sprite.setScale( radius * 2.0 / (sprite.texture?.size().width)! )
        addChild( sprite )
        particles.zRotation = -CGFloat.PI
        particles.setScale( sprite.xScale )
        particles.position = CGPoint( x : -radius * 0.8, y : 0 )
        addChild( particles )
    }
    
    override var position : CGPoint
    {
        didSet
        {
            let d = oldValue - position
            let distanceSQ = d.x * d.x + d.y * d.y
            particles.particleLifetime = distanceSQ / 70.0
        }
    }

    
}