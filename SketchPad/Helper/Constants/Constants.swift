//
//  TitleConstant.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

typealias CallBackResult = Result<Bool, AppError>

enum TitleConstant: String {
    case addPhoto = "+ Add Photo"
    case ok = "Ok"
    case openSettings = "Open Settings"
    case deleteModeOn = "Delete mode is on"
    case drawingModeOn = "Drawing mode is on"
    case sketchSaved = "Sketch Saved Successfully."
    case edit = "Edit"
    case delete = "Delete"
}

enum DateFormat: String {
    case dateFormat = "dd-MM-yyyy"
    case timeFormat = "hh:mm a"
}

enum NotificationName: String {
    case editImage = "edit_image"
}
