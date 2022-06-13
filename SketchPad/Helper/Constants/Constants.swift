//
//  TitleConstant.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

typealias CallBackResult = Result<Bool, AppError>

enum TitleConstant: String {
    case addPhoto = "+ Add Photo"
    case ok = "Ok"
    case openSettings = "Open Settings"
    case deleteModeOn = "Delete mode is on"
    case drawingModeOn = "Drawing mode is on"
    case sketchSaved = "Sketch saved successfully."
    case sketchEdited = "Sketch edited successfully."
    case edit = "Edit"
    case delete = "Delete"
    case cancel = "Cancel"
  
}

enum DateFormat: String {
    case dateFormat = "dd-MM-yyyy"
    case timeFormat = "hh:mm a"
}

enum NotificationName: String {
    case editImage = "edit_image"
}

enum Rotation {
    case rotateLeft
    case rotateRight
    
    var angle: CGFloat {
        switch self {
        case .rotateLeft:
            return -.pi / 2
        case .rotateRight:
            return .pi / 2
        }
    }
}
