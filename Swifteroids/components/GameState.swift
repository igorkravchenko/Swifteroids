
class GameState : NSObject
{
    var lives : Int = 0
    var level : Int = 0
    var hits : Int = 0
    var playing : Bool = false

    func setForStart()
    {
        lives = 3
        level = 0
        hits = 0
        playing = true
    }
}
