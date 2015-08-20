
import SpriteKit.SKNode

class Display : NSObject
{
    var displayObject : SKNode
    var displayOrder : Int = DisplayOrder.Background.rawValue

    init ( displayObject : SKNode, displayOrder : Int )
    {
        self.displayObject = displayObject
        self.displayOrder = displayOrder
    }
    
    init ( displayObject : SKNode )
    {
        self.displayObject = displayObject
    }

}
