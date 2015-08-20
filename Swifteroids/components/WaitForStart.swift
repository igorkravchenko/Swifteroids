
class WaitForStart : NSObject
{
    
    var waitForStart : WaitForStartView
    var startGame : Bool = false

    func setStartGame()
    {
        startGame = true
    }

    init( waitForStart : WaitForStartView )
    {
        self.waitForStart = waitForStart
        super.init()
        self.waitForStart.click.addListener( self, action: "setStartGame" )
    }
}