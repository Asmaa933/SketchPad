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
    func permissionIsDenied() -> Bool
}

class PhotoLibraryManager: PhotoLibraryManagerProtocol {
    
    func permissionIsDenied() -> Bool {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        return photoAuthorizationStatus == .denied
    }
        
    func saveIntoPhoto(imageData: Data?) {
        guard let imageData = imageData,
              let image = UIImage(data: imageData) else { return }
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
