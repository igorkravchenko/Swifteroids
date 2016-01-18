
import CoreGraphics.CGGeometry

class GunControlSystem : ListIteratingSystem
{
    unowned var triggerPoll : TriggerPoll
    unowned var creator : EntityCreator
    
    init( triggerPoll : TriggerPoll, creator : EntityCreator )
    {
        self.triggerPoll = triggerPoll
        self.creator = creator
        super.init(nodeClass: GunControlNode.self, nodeUpdateSelector: "updateNode:time:")
    }
    
    func updateNode( node : GunControlNode, time : NSNumber )
    {
        let control = node.control
        let position = node.position
        let gun : Gun = node.gun
        
        gun.shooting = triggerPoll.has( control.trigger )
        gun.timeSinceLastShot += CGFloat( time.floatValue )
        if gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval
        {
            creator.createUserBullet(gun: gun, parentPosition: position )
            node.audio.play( AudioAsset.ShootGun.rawValue )
            gun.timeSinceLastShot = 0
        }
    }
}