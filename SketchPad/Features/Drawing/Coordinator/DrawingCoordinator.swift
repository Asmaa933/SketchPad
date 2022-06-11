//
//  DrawingCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol DrawingCoordinatorProtocol {
    var imageDidPicked: ((Data) -> Void)? { get set }
    var colorDidPicked: ((UIColor) -> Void)? { get set }
    func showImagePicker()
    func showPermissionDeniedAlert(error: AppError)
    func openPreviewView(with imageData: Data)
    func showColorPicker(currentColor: UIColor)
}

class DrawingCoordinator: NSObject {
    
    private var navigationController: UINavigationController
    var imageDidPicked: ((Data) -> Void)?
    var colorDidPicked: ((UIColor) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

fileprivate extension DrawingCoordinator {
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) else { return }
        UIApplication.shared.open(settingsURL)
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
    
    func showPermissionDeniedAlert(error: AppError) {
        let settingsAction = UIAlertAction(title: TitleConstant.openSettings.rawValue, style: .destructive) {[weak self] _ in
            guard let self = self else { return }
            self.openSettings()
        }
        let okAlert = UIAlertAction(title: TitleConstant.ok.rawValue, style: .default)
        navigationController.showAlert(error: error,
                                       actions: [okAlert,settingsAction])
    }
    
    func openPreviewView(with imageData: Data) {
        let coordinator = PreviewCoordinator(navigationController: navigationController)
        let viewModel = PreviewViewModel(coordinator: coordinator,
                                         canEdit: true,
                                         imageData: imageData)
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
              let imageData = editedImage.pngData() else { return }
        imageDidPicked?(imageData)
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
}
