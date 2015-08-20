
import SpriteKit.SKSpriteNode
import SpriteKit.SKEmitterNode

class SpaceshipDeathView : SKNode, Animatable
{
    private let particles = SKEmitterNode( fileNamed: "spaceship-death.sks" )!
    
    required init?( coder: NSCoder )
    {
        super.init( coder:coder )
    }
    
    override init()
    {
        super.init()
        addChild(particles)
    }
    
    func animate( time : CGFloat )
    {
        let scale = super.xScale
        
        if( scale > 0 )
        {
            super.hidden = false
            super.setScale( scale - time )
        }
        else
        {
            super.hidden = true
        }
    }
}