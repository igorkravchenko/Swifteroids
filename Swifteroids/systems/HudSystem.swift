
import CoreGraphics.CGGeometry

class HudSystem : ListIteratingSystem
{
    override init()
    {
        super.init(nodeClass : HudNode.self, nodeUpdateSelector : "updateNode:time:")
    }
    
    func updateNode( node : HudNode, time : NSNumber )
    {
        node.hud.view.setLives( node.state.lives )
        node.hud.view.setScore( node.state.hits )
    }
}