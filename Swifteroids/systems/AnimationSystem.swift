
import CoreGraphics.CGGeometry

class AnimationSystem : ListIteratingSystem
{
    override init()
    {
        super.init(nodeClass: AnimationNode.self, nodeUpdateSelector: "updateNode:time:" )
    }
    
    func updateNode(node : AnimationNode, time : NSNumber )
    {
        node.animation.animation.animate( CGFloat( time.floatValue ) )
    }
}