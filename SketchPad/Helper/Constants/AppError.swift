//
//  AppError.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

enum AppError: String, Error {
    case photoPermissionDenied = "Permission Denied, please allow it from it"
    case enterName = "Please enter image name"
    case generalError = "Something went wrong, try again"
    case confirmDelete = "Are you sure you want to delete sketch?"
    case confirmClose = "Are you sure you want to close sketch?"
    case saveError = "Error in saving sketch"
    case errorFetching = "Error in getting sketches"
    case errorDeleteSketch = "Error in deleting sketch"
    case noDataFound = "No data found"
}
