
class InputSystem : ListIteratingSystem
{
    var trigger : TriggerPoll
    
    init( trigger : TriggerPoll )
    {
        self.trigger = trigger
        super.init(nodeClass : InputNode.self, nodeUpdateSelector : "updateNode:time:" )
    }
    
    func updateNode( node : InputNode, time : NSNumber)
    {
        let inputView = node.input.view
        inputView.left.highlighted ? trigger.add( Trigger.Left.rawValue ) : trigger.remove( Trigger.Left.rawValue )
        inputView.right.highlighted ? trigger.add( Trigger.Right.rawValue ) : trigger.remove( Trigger.Right.rawValue )
        inputView.shoot.highlighted ? trigger.add( Trigger.Gun.rawValue ) : trigger.remove( Trigger.Gun.rawValue )
        inputView.accelerate.highlighted ? trigger.add( Trigger.Up.rawValue ) : trigger.remove( Trigger.Up.rawValue )
    }
}