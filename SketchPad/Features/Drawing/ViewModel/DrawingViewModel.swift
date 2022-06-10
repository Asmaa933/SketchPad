//
//  DrawingViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol DrawingViewModelProtocol {
    func getImage()
    var imageDidPicked: ((Data) -> Void)? { get set }

}

class DrawingViewModel {
    
    private var coordinator: DrawingCoordinatorProtocol
    var imageDidPicked: ((Data) -> Void)?
    
    init(coordinator: DrawingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}

fileprivate extension DrawingViewModel {
    
    func getImageFromCoordinator() {
        coordinator.imageDidPicked = {[weak self] imageData in
            guard let self = self else { return }
            self.imageDidPicked?(imageData)
        }
        coordinator.showImagePicker()
    }
}

extension DrawingViewModel: DrawingViewModelProtocol {
    
    func getImage() {
        let photoLibraryManager: PhotoLibraryManagerProtocol = PhotoLibraryManager()
        photoLibraryManager.getPermission {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.getImageFromCoordinator()
            case .failure(let error):
                debugPrint("permission denied")
            }
        }
    }
}
