
import SpriteKit

class StarFieldView : SKNode, Animatable
{
    var offset = CGPointZero
    var size = CGSizeZero
    
    private class Star : SKNode
    {
        let sprite = SKSpriteNode( imageNamed: "star" )
        static let maxRadius : CGFloat = 10
        static let minRadius : CGFloat = 3
        
        required init?( coder : NSCoder )
        {
            super.init( coder : coder )
        }
        
        init( radius : CGFloat )
        {
            super.init()
            sprite.setScale( radius * 2.0 / (sprite.texture?.size().width)! )
            sprite.alpha = radius / Star.maxRadius / 6.0
            addChild( sprite )
        }
    }
    
    private var stars = [ Star ]()
    
    required init?( coder : NSCoder )
    {
        super.init( coder : coder )
    }
    
    init( size : CGSize )
    {
        self.size = size
        
        super.init()
        
        for _ in 0 ..< 60
        {
            let radius = ceil( fmax(  CGFloat.random() * Star.maxRadius, Star.minRadius ) )
            let star = Star( radius : radius )
            star.position = CGPoint( x : CGFloat.random() * size.width, y : CGFloat.random() * size.height )
            stars.append( star )
            addChild( star )
        }
    }
    
    func animate( time : CGFloat )
    {
        for star in stars
        {
            var starPosition = star.position
            starPosition += ( -offset * ( star.sprite.xScale /  2.0 ) ) * time
            
            if starPosition.x > size.width
            {
                starPosition.x = 0
            }
            else if starPosition.x < 0
            {
                starPosition.x = size.width
            }
            
            if starPosition.y > size.height
            {
                starPosition.y = 0
            }
            else if starPosition.y < 0
            {
                starPosition.y = size.height
            }
            
            star.position = starPosition
        }
    }
}