
import SpriteKit.SKSpriteNode

class AsteroidView : SKNode
{
    private let particles = SKEmitterNode( fileNamed: "asteroid-flame.sks" )!
    private let sprite = SKSpriteNode( imageNamed : "asteroid" )
    
    required init?(coder : NSCoder)
    {
        super.init( coder : coder )
    }
    
    init( radius : CGFloat )
    {
        super.init();
        addChild( particles )
        sprite.setScale( radius * 2.0 / (sprite.texture?.size().width)! )
        particles.setScale( sprite.xScale * 5.5 )
        addChild( sprite )
    }
    
    override var zRotation: CGFloat
    {
        set( value )
        {
            sprite.zRotation = value
        }

        get
        {
            return sprite.zRotation
        }
    }
    
    override var position : CGPoint
    {
        didSet
        {
            let d = oldValue - position
            var distanceSQ = d.x * d.x + d.y * d.y
            distanceSQ = fmin( distanceSQ, 0.75 )
            particles.xAcceleration = distanceSQ * 500.0
            particles.zRotation = atan2( d.y, d.x )
        }
    }

}