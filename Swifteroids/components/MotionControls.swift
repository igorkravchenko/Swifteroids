
import CoreGraphics.CGGeometry

class MotionControls : NSObject
{
    var left : UInt = 0
    var right : UInt = 0
    var accelerate : UInt = 0
    var accelerationRate : CGFloat = 0
    var rotationRate : CGFloat = 0

    init( left : UInt, right : UInt, accelerate : UInt, accelerationRate : CGFloat, rotationRate : CGFloat )
    {
        self.left = left
        self.right = right
        self.accelerate = accelerate
        self.accelerationRate = accelerationRate
        self.rotationRate = rotationRate
    }
}
