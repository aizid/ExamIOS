import Foundation
import UIKit

final class AppAppearance {
    
    static func setupAppearance() {
//        let navBackgroundImage:UIImage! = UIImage(named: "bg_toolbar")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
//        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage, for: .default)
//        UINavigationBar.appearance().tintColor = .white
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension UINavigationController {
    @objc override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
