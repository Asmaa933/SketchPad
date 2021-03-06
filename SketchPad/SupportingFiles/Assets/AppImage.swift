//
//  AppImage.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum AppImage: String {
    case logo
    case drawing = "scribble"
    case history = "paintpalette.fill"
    case colorPicker
    case emptyState = "magnifyingglass"
    case close = "xmark"
    case back = "arrow.backward"
}

extension AppImage {
    var isSystemImage: Bool {
        switch self {
        case .logo, .colorPicker:
            return false
        default:
            return true
        }
    }
}

extension UIImage {
    static func getImage(from appImage: AppImage) -> UIImage {
        switch appImage.isSystemImage {
        case true:
            return UIImage(systemName: appImage.rawValue) ?? UIImage()
        case false:
            return UIImage(named: appImage.rawValue) ?? UIImage()
        }
    }
}
