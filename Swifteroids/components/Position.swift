import SpriteKit

class Position : NSObject
{
    var position : CGPoint
    var rotation : CGFloat = 0

    init ( x : CGFloat, y : CGFloat, rotation : CGFloat)
    {
        position = CGPoint( x : x, y : y )
        self.rotation = rotation
    }
}
