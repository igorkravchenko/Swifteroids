
import UIKit.UIViewController
import SpriteKit.SKView

class RootViewController : UIViewController
{
    private var asteroids : Asteroids?

    required init?( coder aDecoder : NSCoder )
    {
        super.init( coder : aDecoder )
    }

    private init ( view:UIView? )
    {
        super.init( nibName : nil, bundle : nil )
        super.view = view
    }

    convenience init ()
    {
        self.init( view: SKView() )
    }

    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        let skView = self.view as! SKView

        if skView.scene == nil
        {
            skView.showsFPS = true
            let scene = SKScene.init( size : skView.bounds.size )
            scene.scaleMode = .AspectFill
            asteroids = Asteroids( container : scene, width : scene.size.width, height : scene.size.height )
            skView.presentScene( scene )
            asteroids?.start()
        }
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        return .Landscape
    }
}
