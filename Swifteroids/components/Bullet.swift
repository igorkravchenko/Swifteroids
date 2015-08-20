
import CoreGraphics.CGGeometry

class Bullet : NSObject
{
    var lifeRemaining : CGFloat

    init ( lifetime : CGFloat )
    {
        lifeRemaining = lifetime
    }
}
