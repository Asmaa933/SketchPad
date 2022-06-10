//
//  AppColor.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum AppColor: String {
    case backgroundColor
    case tintColor
    case tabbarBackgroundColor
    case sketchBarColor
}


extension UIColor {
    
    static func color(for appColor: AppColor) -> UIColor {
        UIColor(named: appColor.rawValue) ?? UIColor()
    }
}
