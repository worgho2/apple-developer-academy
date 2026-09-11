import UIKit

extension CGSize {
    
    func proportion() -> CGSize
    {
        let minVal = min(self.width, self.height)
        return CGSize(width: self.width / minVal, height: self.height / minVal)
    }
    
}

func * (left: CGSize, scalar: CGFloat) -> CGSize
{
    return CGSize(width: left.width * scalar, height: left.height * scalar)
}

