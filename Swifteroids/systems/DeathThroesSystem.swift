
import CoreGraphics.CGGeometry

class DeathThroesSystem : ListIteratingSystem
{
    private var creator : EntityCreator
    
    init( creator:EntityCreator )
    {
        self.creator = creator
        super.init( nodeClass: DeathThroesNode.self, nodeUpdateSelector: "updateNode:time:" )
    }
    
    func updateNode( node : DeathThroesNode, time : NSNumber )
    {
        node.death.countdown -= CGFloat( time.floatValue )
        if node.death.countdown <= 0
        {
            creator.destroyEntity( node.entity! )
        }
    }
}