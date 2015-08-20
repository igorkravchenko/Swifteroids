
import SpriteKit

class BulletView : SKNode
{
    private let sprite = SKSpriteNode( imageNamed: "bullet" )
    private let particles = SKEmitterNode ( fileNamed : "bullet-flame.sks" )!
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    override init()
    {
        super.init()
        sprite.setScale( 4.0 / (sprite.texture?.size().width)! )
        addChild(sprite)
        particles.setScale( sprite.xScale * 3.0 )
        addChild( particles )
    }
    
    override var position : CGPoint
    {
        didSet
        {
            let d = oldValue - position
            var distanceSQ = d.x * d.x + d.y * d.y
            distanceSQ = fmin( distanceSQ, 2 )
            particles.xAcceleration = distanceSQ * 1000.0
            particles.zRotation = atan2( d.y, d.x )
        }
    }
    
}