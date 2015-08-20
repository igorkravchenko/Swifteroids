
import CoreGraphics.CGGeometry

class BulletAgeSystem : ListIteratingSystem
{
    private var creator : EntityCreator
    
    init( creator:EntityCreator )
    {
        self.creator = creator
        super.init( nodeClass : BulletAgeNode.self, nodeUpdateSelector : "updateNode:time:" )
    }
    
    func updateNode( node : BulletAgeNode, time: NSNumber )
    {
        let bullet = node.bullet
        bullet.lifeRemaining -= CGFloat( time.floatValue )
        if ( bullet.lifeRemaining <= 0)
        {
            creator.destroyEntity( node.entity! )
        }
    }
}