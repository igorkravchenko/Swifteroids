
class Asteroid : NSObject
{
    var fsm : EntityStateMachine

    init ( fsm : EntityStateMachine )
    {
        self.fsm = fsm
    }
}
