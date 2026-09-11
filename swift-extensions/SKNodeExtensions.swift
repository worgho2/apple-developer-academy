import SpriteKit

extension SKNode {
    
    func addChildren(nodes: [SKNode])
    {
        for node in nodes {
            self.addChild(node)
        }
    }
    
    var rootNode: SKNode?
    {
        if let parentNode = self.parent
        {
            if parentNode is SKScene
            {
                return parentNode
            }
            else
            {
                return parentNode.rootNode
            }
        }
        else
        {
            return nil
        }
    }
    
    var positionInScene : CGPoint?
    {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to:scene)
        } else {
            return nil
        }
    }

}
