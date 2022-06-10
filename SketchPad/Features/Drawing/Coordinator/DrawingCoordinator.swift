//
//  DrawingCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol DrawingCoordinatorProtocol {
    func showImagePicker()
    var imageDidPicked: ((Data) -> Void)? { get set }
}

class DrawingCoordinator: NSObject {
    
    private var navigationController: UINavigationController
    var imageDidPicked: ((Data) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DrawingCoordinator: DrawingCoordinatorProtocol {
    
    func showImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        navigationController.present(imagePickerController, animated: true)
    }
   
}

extension DrawingCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage,
              let imageData = editedImage.pngData() else { return }
        imageDidPicked?(imageData)
    }
}
