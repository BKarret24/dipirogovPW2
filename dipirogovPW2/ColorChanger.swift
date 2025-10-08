import UIKit

class ColorChanger {
    enum Constants {
        static let redDefault: Double = 0.0
        static let greenDefault: Double = 0.0
        static let blueDefault: Double = 0.0
        static let alphaDefault: Double = 1.0
        static let randomRange: ClosedRange<Double> = 0...1
    }

    var redComp: Double
    var greenComp: Double
    var blueComp: Double

    init(redComp: Double = Constants.redDefault, greenComp: Double = Constants.greenDefault, blueComp: Double = Constants.blueDefault) {
        self.redComp = redComp
        self.greenComp = greenComp
        self.blueComp = blueComp
    }

    func getColor() -> UIColor {
        UIColor(red: redComp, green: greenComp, blue: blueComp, alpha: Constants.alphaDefault)
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
    
    func setFromHex(_ hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return }

        redComp = Double((rgb & 0xFF0000) >> 16) / 255
        greenComp = Double((rgb & 0x00FF00) >> 8) / 255
        blueComp = Double(rgb & 0x0000FF) / 255
    }

    func setRandom() {
            redComp = Double.random(in: Constants.randomRange)
            greenComp = Double.random(in: Constants.randomRange)
            blueComp = Double.random(in: Constants.randomRange)
        }
}

