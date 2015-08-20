
class StarFieldMovementSystem : System
{
    var starfields : NodeList!
    var spaceships : NodeList!
    
    override func addToEngine( engine : ASHEngine! )
    {
        starfields = engine.getNodeList( StarFieldNode )
        spaceships = engine.getNodeList( MotionControlNode )
    }
    
    override func removeFromEngine( engine : ASHEngine! )
    {
        starfields = nil
        spaceships = nil
    }
    
    override func update(time: Double)
    {
        for spaceshipNode in spaceships
        {
            let spaceship = spaceshipNode as! MotionControlNode
            
            for starfieldNode in starfields
            {
                let starfield = starfieldNode as! StarFieldNode
                starfield.starField.view.offset = spaceship.motion.velocity
            }
        }
    }
}