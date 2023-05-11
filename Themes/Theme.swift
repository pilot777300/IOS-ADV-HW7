

import Foundation
import UIKit

struct DarkTheme: ThemeProtocol {
    
    var textColor: UIColor = .white
    
    var backgroundColor: UIColor = .black
    
    
}

struct GreenTheme: ThemeProtocol {
    
    
    var textColor: UIColor = .black
    
    var backgroundColor =  UIColor(red: 0.05, green: 0.85, blue: 0.26 , alpha: 4.9)
    
    var buttonBackGround = UIColor(red: 0.45, green: 0.53, blue: 0.02, alpha: 4.9)
}

struct LightTheme: ThemeProtocol {
    
    var textColor: UIColor = .black
    
    var backgroundColor: UIColor = .systemGray5
    
    var backGroundForPost: UIColor = .white
}
