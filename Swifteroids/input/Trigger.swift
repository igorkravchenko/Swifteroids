
enum Trigger : UInt
{
    case Left
    case Right
    case Up
    case Gun
}

class TriggerPoll
{
    private var list:Set<UInt> = Set<UInt>()
    
    func add( trigger : UInt )
    {
        list.insert( trigger )
    }
    
    func remove( trigger : UInt )
    {
        list.remove( trigger )
    }
    
    func has( trigger : UInt ) -> Bool
    {
        return list.contains( trigger )
    }
}