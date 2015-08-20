
import CoreGraphics.CGGeometry

class MotionControlSystem : ListIteratingSystem
{
    private var triggerPoll : TriggerPoll
    
    init( triggerPoll : TriggerPoll )
    {
        self.triggerPoll = triggerPoll
        super.init(nodeClass: MotionControlNode.self, nodeUpdateSelector: "updateNode:time:")
    }
    
    func updateNode( node : MotionControlNode, time : NSNumber )
    {
        let control = node.control
        let position  = node.position
        let motion = node.motion
        let time = CGFloat ( time.floatValue )
        
        if triggerPoll.has( control.left )
        {
            position.rotation += control.rotationRate * time
        }
        
        if triggerPoll.has( control.right )
        {
            position.rotation -= control.rotationRate * time
        }
        
        if triggerPoll.has( control.accelerate )
        {
            motion.velocity.x += cos( position.rotation ) * control.accelerationRate * time
            motion.velocity.y += sin( position.rotation ) * control.accelerationRate * time
        }
    }
}