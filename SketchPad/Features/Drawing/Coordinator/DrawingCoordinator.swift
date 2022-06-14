//
//  DrawingCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol DrawingCoordinatorProtocol {
    var imageDidPicked: ((Sketch) -> Void)? { get set }
    var colorDidPicked: ((UIColor) -> Void)? { get set }
    func showImagePicker()
    func showAlert(error: AppError, actions: [UIAlertAction])
    func openPreviewView(with sketch: Sketch)
    func showColorPicker(currentColor: UIColor)
}

class DrawingCoordinator: NSObject {
    
    private var navigationController: UINavigationController
    var imageDidPicked: ((Sketch) -> Void)?
    var colorDidPicked: ((UIColor) -> Void)?
    
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
    
    func showAlert(error: AppError, actions: [UIAlertAction]) {
        navigationController.showAlert(message: error.rawValue,
                                       actions: actions)
    }
    
    func openPreviewView(with sketch: Sketch) {
        let coordinator = PreviewCoordinator(navigationController: navigationController)
        let viewModel = PreviewViewModel(coordinator: coordinator,
                                         canEdit: true,
                                         sketch: sketch)
        let previewViewController = PreviewViewController(viewModel: viewModel)
        navigationController.pushViewController(previewViewController,
                                                animated: true)
    }
    
    func showColorPicker(currentColor: UIColor) {
        let colorPickerController = UIColorPickerViewController()
        colorPickerController.delegate = self
        colorPickerController.modalPresentationStyle = .popover
        colorPickerController.supportsAlpha = false
        colorPickerController.selectedColor = currentColor
        navigationController.present(colorPickerController,
                                     animated: true)
    }
   
}

extension DrawingCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let editedImage = info[.editedImage] as? UIImage,
              let imageData = editedImage.jpegData(compressionQuality: 0.5) else { return }
        imageDidPicked?(Sketch(imageData: imageData))
        navigationController.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        navigationController.dismiss(animated: true)
    }
}

extension DrawingCoordinator: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorDidPicked?(viewController.selectedColor)
    }
    
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        colorDidPicked?(viewController.selectedColor)
    }
}
