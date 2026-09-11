import SpriteKit
import UIKit

func lerp(a : CGFloat, b : CGFloat, fraction : CGFloat) -> CGFloat { return (b-a) * fraction + a }

struct ColorComponents {
    var red = CGFloat(0)
    var green = CGFloat(0)
    var blue = CGFloat(0)
    var alpha = CGFloat(0)
}

extension UIColor {
    
    func toComponents() -> ColorComponents {
        var components = ColorComponents()
        getRed(&components.red, green: &components.green, blue: &components.blue, alpha: &components.alpha)
        return components
    }
    
    struct MyPallete {
        static var green: UIColor = #colorLiteral(red: 0.4901960784, green: 0.8117647059, blue: 0.7137254902, alpha: 1)
        static var blue: UIColor = #colorLiteral(red: 0.2901960784, green: 0.4823529412, blue: 0.6156862745, alpha: 1)
        static var yellow: UIColor = #colorLiteral(red: 0.9411764706, green: 0.9647058824, blue: 0.431372549, alpha: 1)
        static var black: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3215686275, blue: 0.3529411765, alpha: 1)
        static var white: UIColor = #colorLiteral(red: 0.9294117647, green: 0.968627451, blue: 0.9647058824, alpha: 1)
    }
    
    struct MyAnswers {
        static var correct: UIColor = #colorLiteral(red: 0.5880194902, green: 0.9989247918, blue: 0.5124870539, alpha: 1)
        static var incorrect: UIColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0.4980392157, alpha: 1)
        static var wasNotResponded: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static var clear: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    struct MyCategories {
        static var population: UIColor = #colorLiteral(red: 0.06274509804, green: 0.2705882353, blue: 0.2784313725, alpha: 1)
        static var territory: UIColor = #colorLiteral(red: 0.1333333333, green: 0.1803921569, blue: 0.3137254902, alpha: 1)
        static var mortality: UIColor = #colorLiteral(red: 0.0431372549, green: 0.1254901961, blue: 0.1529411765, alpha: 1)
        static var incarceration: UIColor = #colorLiteral(red: 0.8431372549, green: 0.1490196078, blue: 0.2392156863, alpha: 1)
        static var energy: UIColor = #colorLiteral(red: 0.5568627451, green: 0.8901960784, blue: 0.937254902, alpha: 1)
        static var economy: UIColor = #colorLiteral(red: 0.8465492169, green: 0.7342714419, blue: 0.7915576526, alpha: 1)
        static var immigrants: UIColor = #colorLiteral(red: 0.3764705882, green: 0.3725490196, blue: 0.368627451, alpha: 1)
        static var ignorance: UIColor = #colorLiteral(red: 0.3058823529, green: 0, blue: 0.5568627451, alpha: 1)
    }
}

extension UIFont {
    static var myFontName : String {
        return "Kenney Future Narrow"
    }
    static func myFont(size: CGFloat) -> UIFont {
        return UIFont(name: myFontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIImage {
    static var tableRandomImage: UIImage {
        let avaliableTableImages: [UIImage] = [ UIImage(named: "table_1")!, UIImage(named: "table_2")!, UIImage(named: "table_3")! ]
        return avaliableTableImages[.random(in: 0 ..< avaliableTableImages.count)]
    }
}

extension SKAction {
    static func colorTransitionAction(fromColor : UIColor, toColor : UIColor, duration : Double = 0.4) -> SKAction
    {
        return SKAction.customAction(withDuration: duration, actionBlock: { (node : SKNode!, elapsedTime : CGFloat) -> Void in
            let fraction = CGFloat(elapsedTime / CGFloat(duration))
            let startColorComponents = fromColor.toComponents()
            let endColorComponents = toColor.toComponents()
            let transColor = UIColor(red: lerp(a: startColorComponents.red, b: endColorComponents.red, fraction: fraction),
                                     green: lerp(a: startColorComponents.green, b: endColorComponents.green, fraction: fraction),
                                     blue: lerp(a: startColorComponents.blue, b: endColorComponents.blue, fraction: fraction),
                                     alpha: lerp(a: startColorComponents.alpha, b: endColorComponents.alpha, fraction: fraction))
            (node as? SKShapeNode)?.fillColor = transColor
        }
        )
    }
}
