//
//  PhotoLibraryManager.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import Photos

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
}
