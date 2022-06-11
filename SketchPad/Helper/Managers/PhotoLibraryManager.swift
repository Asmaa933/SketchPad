//
//  PhotoLibraryManager.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import Photos
import UIKit

protocol PhotoLibraryManagerProtocol {
    func getPermission(_ completion: @escaping ((Result<Bool,AppError>) -> Void))
}

class PhotoLibraryManager: PhotoLibraryManagerProtocol {
    
    func getPermission(_ completion: @escaping ((Result<Bool,AppError>) -> Void)) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            completion(.success(true))
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                newStatus == .authorized ? completion(.success(true)) : completion(.failure(.photoPermissionDenied))
            }
        case .denied:
            completion(.failure(.photoPermissionDenied))
            
        default:
            break
        }
    }
    
    func saveIntoPhoto(imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)},
                                               completionHandler: {success, error in
            if success {
                debugPrint("Saved successfully in Photo ")
            } else {
                debugPrint("error in saving in Photo >> \(error?.localizedDescription ?? "")")
            }
        })
    }
}
