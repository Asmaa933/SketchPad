//
//  Tab.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

enum Tab: Int, CaseIterable {
    case drawing
    case history
}

extension Tab {
    var tabTitle: String {
        switch self {
        case .drawing: return "Drawing"
        case .history: return "History"
        }
    }
    
    var imageName: AppImage {
        switch self {
        case .drawing: return .drawing
        case .history: return .history
        }
    }
}

