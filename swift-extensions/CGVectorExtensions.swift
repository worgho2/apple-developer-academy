import UIKit

extension CGVector {
    
    func distanceTo(_ point: CGVector) -> CGFloat {
        return CGFloat(sqrt(pow(dx - point.dx, 2) + pow(dy - point.dy, 2)))
    }
    
    func normalized() -> CGVector {
        let vectorLength = self.module()
        return CGVector(dx: dx / vectorLength, dy: dy / vectorLength)
    }
    
    func module() -> CGFloat {
        return sqrt(dx*dx + dy*dy)
    }
    
    func forcedLength(length: CGFloat) -> CGVector {
        return self.normalized() * length
    }
    
    static func randomVector(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat) -> CGVector {
        return CGVector(dx: CGFloat.random(in: minX...maxX), dy: CGFloat.random(in: minY...maxY))
    }
    
    static func randomVector(totalLength: CGFloat) -> CGVector {
        return CGVector(dx: CGFloat.random(in: -1...1), dy: CGFloat.random(in: -1...1)).forcedLength(length: totalLength)
    }

    func angle() -> CGFloat {
        return atan2(dy, dx)
    }
    
    func toCGPoint() -> CGPoint {
        return CGPoint(x: dx, y: dy)
    }
    
}

func + (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx + right.dx, dy: left.dy + right.dy)
}

func + (left: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: left.dx + scalar, dy: left.dy + scalar)
}

func - (left: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: left.dx - scalar, dy: left.dy - scalar)
}

func - (left: CGVector, right: CGVector) -> CGVector
{
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

func * (left: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: left.dx * scalar, dy: left.dy * scalar)
}

func / (left: CGVector, scalar: CGFloat) -> CGVector
{
    return CGVector(dx: left.dx / scalar, dy: left.dy / scalar)
}
