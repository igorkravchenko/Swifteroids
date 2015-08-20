
import SpriteKit.SKSpriteNode

class InputView : IKSKNode
{
    class Button : SKSpriteNode
    {
        var highlighted : Bool
        {
            get
            {
                return alpha == 0.5
            }
            
            set ( value )
            {
                alpha = value ? 0.5 : 1
            }
        }
    }
    
    let left = Button( imageNamed : "left-button" )
    let right = Button( imageNamed : "right-button" )
    let shoot = Button ( imageNamed : "shoot-button" )
    let accelerate = Button ( imageNamed : "accelerate-button" )
    
    required init?( coder aDecoder : NSCoder )
    {
        super.init( coder : aDecoder )
    }
    
    init( size : CGSize )
    {
        super.init()
        addChild( left )
        left.position = CGPoint( x : CGRectGetWidth( left.frame ), y : CGRectGetHeight( left.frame ) )
        addChild( right )
        right.position = CGPoint( x : CGRectGetWidth( right.frame ) * 2.5, y : CGRectGetHeight( right.frame ) )
        addChild( shoot )
        shoot.position = CGPoint( x : size.width - CGRectGetWidth( shoot.frame ) * 2.5, y : CGRectGetHeight( shoot.frame ) )
        addChild( accelerate )
        accelerate.position = CGPoint( x : size.width - CGRectGetWidth( accelerate.frame ), y : CGRectGetHeight( accelerate.frame ) )
        
        let touchToButtonsMap = NSMapTable( keyOptions : NSMapTableObjectPointerPersonality, valueOptions : NSMapTableStrongMemory )
        
        let buttons = [ left, right, shoot, accelerate ]
        
        touchesBeganHandler =
        {
            touches, event in
            
            for touch in touches
            {
                let touchPosistion = touch.locationInNode( self )
                
                for button in buttons
                {
                    if CGRectContainsPoint( button.frame, touchPosistion )
                    {
                        button.highlighted = true
                        let touchedButtons = touchToButtonsMap[ touch ] as? NSMutableSet ?? NSMutableSet()
                        touchToButtonsMap[ touch ] = touchedButtons
                        touchedButtons.addObject( button )
                    }
                    else
                    {
                        if let touchedButtons = touchToButtonsMap[ touch ] as? NSMutableSet
                        {
                            var removeButtons : [ Button ] = []
                            for touchedButton in touchedButtons
                            {
                                if !CGRectContainsPoint( touchedButton.frame, touchPosistion )
                                {
                                    removeButtons.append( touchedButton as! Button )
                                }
                            }
                            
                            while ( removeButtons.count > 0)
                            {
                                let removeButton : Button = removeButtons.removeLast()
                                touchedButtons.removeObject( removeButton )
                                removeButton.highlighted = false
                            }
                            
                            if( touchedButtons.count == 0)
                            {
                                touchToButtonsMap.removeObjectForKey( touch )
                            }
                        }
                    }
                }
            }
        }
        
        touchesMovedHandler = touchesBeganHandler
        
        touchesEndedHandler =
        {
            touches, event in
            
            var removeButtons = Set<Button>()
            
            for touch in touches
            {
                if let touchedButtons = touchToButtonsMap[ touch ] as? NSMutableSet
                {
                    for button in touchedButtons
                    {
                        removeButtons.insert( button as! Button )
                    }
                    
                    touchToButtonsMap.removeObjectForKey( touch )
                }
            }
            
            for relevantTouch in touchToButtonsMap
            {
                if let touchedButtons = touchToButtonsMap[ relevantTouch ] as? NSMutableSet
                {
                    for button in touchedButtons
                    {
                        removeButtons.remove( button as! Button )
                    }
                }
            }
            
            for removeButton in removeButtons
            {
                removeButton.highlighted = false
            }
        }
        
        touchesCancelledHandler =
        {
            [ unowned self ] ( touches, event ) in
            
            if let cancelTouches = touches
            {
                self.touchesEnded( cancelTouches, withEvent: event )
            }
        }
        
        userInteractionEnabled = true
    }
}