import UIKit

extension CGPoint {
    
    func distanceTo(_ point: CGPoint) -> CGFloat
    {
        return CGFloat(sqrt(pow(x - point.x, 2) + pow(y - point.y, 2)))
    }
    
    func normalized() -> CGPoint
    {
        let vectorLength = self.module()
        return CGPoint(x: x / vectorLength, y: y / vectorLength)
    }
    
    func module() -> CGFloat
    {
        return sqrt(x*x + y*y)
    }
    
    func forcedLength(length: CGFloat) -> CGPoint
    {
        return self.normalized() * length
    }
    
    static func randomPoint(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat) -> CGPoint 
    {
        return CGPoint(x: CGFloat.random(in: minX...maxX), y: CGFloat.random(in: minY...maxY))
    }
    
    static func randomPoint(totalLength: CGFloat) -> CGPoint
    {
        return CGPoint(x: CGFloat.random(in: -1...1), y: CGFloat.random(in: -1...1)).forcedLength(length: totalLength)
    }
    
    
    func toCGVector() -> CGVector
    {
        return CGVector(dx: x, dy: y)
    }
    
}

func + (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func + (left: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x + scalar, y: left.y + scalar)
}

func - (left: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x - scalar, y: left.y - scalar)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint
{
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x * scalar, y: left.y * scalar)
}

func / (left: CGPoint, scalar: CGFloat) -> CGPoint
{
    return CGPoint(x: left.x / scalar, y: left.y / scalar)
}
