
import SpriteKit.SKNode

class IKSKNode : SKNode
{
    var touchesBeganHandler : ( ( Set<UITouch>, UIEvent? ) -> ( ) )?
    var touchesMovedHandler : ( ( Set<UITouch>, UIEvent? ) -> ( ) )?
    var touchesEndedHandler : ( ( Set<UITouch>, UIEvent? ) -> ( ) )?
    var touchesCancelledHandler : ( ( Set<UITouch>?, UIEvent? ) -> ( ) )?
    
    override func touchesBegan(touches : Set<UITouch>, withEvent event : UIEvent? )
    {
        super.touchesBegan( touches, withEvent : event )
        touchesBeganHandler?(touches, event)
    }
    
    override func touchesMoved( touches : Set<UITouch>, withEvent event : UIEvent? )
    {
        super.touchesMoved( touches, withEvent : event )
        touchesMovedHandler?( touches, event )
    }
    
    override func touchesEnded( touches : Set<UITouch>, withEvent event : UIEvent? )
    {
        super.touchesEnded( touches, withEvent : event )
        touchesEndedHandler?( touches, event )
    }
    
    override func touchesCancelled( touches: Set<UITouch>?, withEvent event: UIEvent? )
    {
        super.touchesCancelled( touches, withEvent: event )
        touchesCancelledHandler?( touches, event )
    }
}
