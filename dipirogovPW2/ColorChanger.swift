import UIKit

class ColorChanger {
    enum Constants {
        static let redDefault: Double = 0.0
        static let greenDefault: Double = 0.0
        static let blueDefault: Double = 0.0
        static let alphaDefault: Double = 1.0
    }
    var redComp: Double = Constants.redDefault
    var greenComp: Double = Constants.greenDefault
    var blueComp: Double = Constants.blueDefault
    
    init(redComp: Double = Constants.redDefault, greenComp: Double = Constants.greenDefault, blueComp: Double = Constants.blueDefault) {
        self.redComp = redComp
        self.greenComp = greenComp
        self.blueComp = blueComp
    }
    
    func getColor() -> UIColor {
        let col = UIColor(red: self.redComp, green: self.greenComp, blue: self.blueComp, alpha: Constants.alphaDefault)
        return col
    }
    
    func changeRed(val: Double) {
        redComp = val
    }
    
    func changeGreen(val: Double) {
        greenComp = val
    }
    
    func changeBlue(val: Double) {
        blueComp = val
    }
    
    
}
