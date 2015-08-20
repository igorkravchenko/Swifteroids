
import CoreGraphics.CGGeometry

class MovementSystem : ListIteratingSystem
{
    private var config : GameConfig
    
    init( config : GameConfig )
    {
        self.config = config
        super.init( nodeClass: MovementNode.self, nodeUpdateSelector: "updateNode:time:" )
    }
    
    func updateNode(node : MovementNode, time : NSNumber )
    {
        let position = node.position
        let motion = node.motion
        let time = CGFloat( time.floatValue )
        
        position.position.x += motion.velocity.x * time
        position.position.y += motion.velocity.y * time
        if position.position.x < 0
        {
            position.position.x += config.width
        }
        if position.position.x > config.width
        {
            position.position.x -= config.width
        }
        if position.position.y < 0
        {
            position.position.y += config.height
        }
        if position.position.y > config.height
        {
            position.position.y -= config.height
        }
        position.rotation += motion.angularVelocity * time
        if motion.damping > 0
        {
            let xDamp = abs( cos( position.rotation ) * motion.damping * time )
            let yDamp = abs( sin( position.rotation ) * motion.damping * time )
            if motion.velocity.x > xDamp
            {
                motion.velocity.x -= xDamp
            }
            else if motion.velocity.x < -xDamp
            {
                motion.velocity.x += xDamp
            }
            else
            {
                motion.velocity.x = 0
            }
            if motion.velocity.y > yDamp
            {
                motion.velocity.y -= yDamp;
            }
            else if motion.velocity.y < -yDamp
            {
                motion.velocity.y += yDamp
            }
            else
            {
                motion.velocity.y = 0
            }
        }
    }
}