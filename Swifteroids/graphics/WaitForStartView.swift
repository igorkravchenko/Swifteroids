
import SpriteKit.SKNode

class WaitForStartView : SKNode
{
    private var gameOver : SKLabelNode
    private var clickToStart : SKLabelNode
    let click:Signal0 = Signal0()

    let createGameOver:( CGSize ) -> SKLabelNode =
    {
        size in
        
        let tf:SKLabelNode = SKLabelNode( fontNamed : "Helvetica-Bold" )
        tf.horizontalAlignmentMode = .Center
        tf.color = SKColor.whiteColor()
        tf.fontSize = 32
        tf.text = "ASTEROIDS"
        tf.position = CGPoint( x : size.width / 2, y : size.height / 2 + CGRectGetHeight( tf.frame ) / 2 )
        return tf
    }

    let createClickToStart:( CGSize ) -> SKLabelNode =
    {
        size in
        let tf:SKLabelNode = SKLabelNode( fontNamed : "Helvetica-Bold" )
        tf.horizontalAlignmentMode = .Center
        tf.color = SKColor.whiteColor()
        tf.fontSize = 18
        tf.text = "CLICK TO START"
        tf.position = CGPoint ( x : size.width / 2, y : size.height / 2 - 50 + CGRectGetHeight( tf.frame ) / 2 )
        return tf
    }

    required init?( coder aDecoder : NSCoder )
    {
        gameOver = createGameOver( CGSizeZero )
        clickToStart = createClickToStart( CGSizeZero )
        super.init( coder : aDecoder )
    }

    init( size : CGSize )
    {
        gameOver = createGameOver( size )
        clickToStart = createClickToStart( size )

        super.init()
        userInteractionEnabled = true
        addChild( gameOver )
        addChild( clickToStart )
    }
    
    override func removeFromParent()
    {
        super.removeFromParent()
        gameOver.text = "GAME OVER"
    }

    override func touchesBegan( touches: Set<UITouch>, withEvent event: UIEvent? )
    {
        super.touchesBegan( touches, withEvent : event)
        click.dispatch()
    }
}
