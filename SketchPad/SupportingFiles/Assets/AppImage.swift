//
//  AppImage.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum AppImage: String {
    case logo
}

extension UIImage {
    static func getImage(from appImage: AppImage) -> UIImage {
        UIImage(named: appImage.rawValue) ?? UIImage()
    }
}
