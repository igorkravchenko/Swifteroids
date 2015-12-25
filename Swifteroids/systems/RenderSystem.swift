
import SpriteKit.SKNode

class RenderSystem : System
{
    var container : SKNode
    var nodes : NodeList!
    
    init ( container : SKNode )
    {
        self.container = container
        super.init()
    }
    
    override func addToEngine(engine: Engine)
    {
        nodes = engine.getNodeList( RenderNode )
        for node in nodes
        {
            addToDisplay( node as! RenderNode )
        }

        nodes.nodeAdded.add( self, action: "addToDisplay:" )
        nodes.nodeRemoved.add( self, action: "removeFromDisplay:" )
    }
    
    func addToDisplay( node : RenderNode )
    {
        container.addChild( node.display.displayObject )
    }
    
    func removeFromDisplay( node : RenderNode )
    {
        node.display.displayObject.removeFromParent()
    }
    
    override func update(time: Double)
    {
        for node in nodes
        {
            let renderNode = node as! RenderNode
            let display = renderNode.display
            let displayObject = display.displayObject
            let position = renderNode.position
            
            displayObject.position = position.position
            displayObject.zRotation = position.rotation
            displayObject.zPosition = -CGFloat( display.displayOrder )
        }
    }

    override func removeFromEngine( engine : Engine )
    {
        nodes = nil
    }
}
