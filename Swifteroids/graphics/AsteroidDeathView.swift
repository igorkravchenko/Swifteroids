
import SpriteKit.SKEmitterNode

class AsteroidDeathView : SKNode, Animatable
{
    private let particles = SKEmitterNode( fileNamed : "asteroid-death.sks" )!
    private var radius : CGFloat = 0
    
    required init?( coder : NSCoder )
    {
        super.init( coder : coder )
    }
    
    init( radius : CGFloat )
    {
        self.radius = radius
        super.init()
        addChild( particles )
        particles.setScale( radius / 30.0 )
        
    }
    
    func animate( time : CGFloat )
    {
        if( particles.xScale - time > 0 )
        {
            particles.setScale( particles.xScale - time / 2.0 )
            particles.alpha = particles.xScale
        }
    }
}
