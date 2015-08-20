
import SpriteKit

class Gun : NSObject
{
    var shooting : Bool = false
    var offsetFromParent : CGPoint
    var timeSinceLastShot : CGFloat = 0
    var minimumShotInterval : CGFloat = 0
    var bulletLifetime : CGFloat = 0

    init( offsetX : CGFloat, offsetY : CGFloat, minimumShotInterval : CGFloat, bulletLifetime : CGFloat )
    {
        offsetFromParent = CGPoint( x : offsetX, y : offsetY )
        self.minimumShotInterval = minimumShotInterval
        self.bulletLifetime = bulletLifetime
    }
}
