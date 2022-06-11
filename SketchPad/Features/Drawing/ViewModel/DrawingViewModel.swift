//
//  DrawingViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import UIKit

protocol DrawingViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func getImage()
    func topBarButtonTapped(_ button: DrawingTopBarButton)
    func didTouchImage(at point: CGPoint, eventType: TouchEvent)
}

class DrawingViewModel {
    
    private var coordinator: DrawingCoordinatorProtocol
    var statePresenter: StatePresentable?
    var imageDidPicked: ((Data) -> Void)?
    
    init(coordinator: DrawingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

fileprivate extension DrawingViewModel {
    
    func getImageFromCoordinator() {
        coordinator.imageDidPicked = {[weak self] imageData in
            guard let self = self else { return }
            self.statePresenter?.render(state: .imagePicked(imageData: imageData),
                                        mapping: DrawingState.self)
        }
        coordinator.showImagePicker()
    }
}

extension DrawingViewModel: DrawingViewModelProtocol {
    
    func getImage() {
        let photoLibraryManager: PhotoLibraryManagerProtocol = PhotoLibraryManager()
        photoLibraryManager.getPermission {[weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.getImageFromCoordinator()
                case .failure(let error):
                    self.coordinator.showPermissionDeniedAlert(error: error)
                }
            }
        }
    }
    
    func topBarButtonTapped(_ button: DrawingTopBarButton) {
        switch button {
        case .close:
            break
        case .undo:
            break
        case .redo:
            break
        case .delete:
            break
        case .done:
            #warning("Capture sketch image and convert to before navigate to preview")
            guard let dummyImage = UIImage.getImage(from: .drawing).pngData() else { return }
            coordinator.openPreviewView(with: dummyImage)
        }
    }
    
    func didTouchImage(at point: CGPoint, eventType: TouchEvent) {
        debugPrint("didTouch at \(point) eventType \(eventType) ")
    }
}
