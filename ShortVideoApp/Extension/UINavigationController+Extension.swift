//
//  UINavigationController+Extension.swift
//  ShortVideoApp
//
//  Created by Biswajyoti Sahu on 08/05/21.
//

import UIKit

extension UINavigationController {
    
    func makeBarTransparent() {
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = UIColor.clear
    }
}
