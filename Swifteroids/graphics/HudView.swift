
import SpriteKit.SKNode
import SpriteKit.SKLabelNode

class HudView : SKNode
{
    private class func createTextField() -> SKLabelNode
    {
        let tf:SKLabelNode = SKLabelNode( fontNamed: "Helvetica-Bold" )
        tf.horizontalAlignmentMode = .Center
        tf.color = SKColor.whiteColor()
        tf.fontSize = 18
        return tf
    }

    private let score : SKLabelNode = HudView.createTextField()
    private let lives : SKLabelNode = HudView.createTextField()
    private var size : CGSize
    
    required init?(coder : NSCoder)
    {
        size = CGSizeZero
        super.init(coder : coder)
    }
    
    init( size : CGSize )
    {
        self.size = size
        super.init()
        addChild(score)
        addChild(lives)
    }
    
    func setScore( value : Int )
    {
        score.text = "SCORE: \(value)"
        score.position = CGPoint( x : size.width - CGRectGetWidth( score.frame ) / 2, y : size.height - CGRectGetHeight( score.frame ) - 5 )
    }
    
    func setLives( value : Int )
    {
        lives.text = "LIVES: \(value)"
        lives.position = CGPoint( x : CGRectGetWidth( lives.frame ) / 2 , y : size.height - CGRectGetHeight( lives.frame ) - 5)
    }
}