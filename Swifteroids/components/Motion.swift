
import SpriteKit

class Motion : NSObject
{
    var velocity : CGPoint =  CGPoint()
    var angularVelocity : CGFloat = 0
    var damping : CGFloat = 0

    init( velocityX : CGFloat, velocityY : CGFloat, angularVelocity : CGFloat, damping : CGFloat )
    {
        velocity =  CGPoint( x : velocityX, y : velocityY )
        self.angularVelocity = angularVelocity
        self.damping = damping
    }
}
