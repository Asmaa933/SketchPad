//
//  DrawingViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import UIKit

enum Mode {
    case drawing
    case delete
}

protocol DrawingViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func getImage()
    func topBarButtonTapped(_ button: DrawingTopBarButton)
    func didTouchImage(at point: CGPoint, eventType: TouchEvent)
}

class DrawingViewModel {
    
    private var coordinator: DrawingCoordinatorProtocol
    private lazy var linesInfo = [LineInfo]()
    private var currentColor: UIColor = .black
    private var currentThickness: CGFloat = 20
    private var currentMode: Mode = .drawing
    
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
        switch eventType {
        case .began:
            touchBegan(at: point)
        case .moved:
            touchMoved(at: point)
        case .ended:
            touchEnded(at: point)
        }
    }
}

fileprivate extension DrawingViewModel {
    
    func touchBegan(at point: CGPoint) {
        switch currentMode {
        case .drawing:
            let path = UIBezierPath()
            path.lineWidth = currentThickness
            path.move(to: point)
            let lineInfo = LineInfo(lineColor: currentColor,
                                    path: path,
                                    pointsCount: 1)
            linesInfo.append(lineInfo)
        case .delete:
            break
        }
    }
    
    func touchMoved(at point: CGPoint) {
        guard currentMode == .drawing,
              var lastLine = linesInfo.last else { return }
        lastLine.path.addLine(to: point)
        lastLine.pointsCount = lastLine.pointsCount + 1
        lastLine.isLine = true
    }
    
    func touchEnded(at point: CGPoint) {
        guard currentMode == .drawing, var lastLine = linesInfo.last else { return }
        if lastLine.pointsCount == 1 {
            lastLine.path = UIBezierPath(ovalIn: CGRect(x: point.x,
                                                        y: point.y,
                                                        width: currentThickness,
                                                        height: currentThickness))
        }
    }
}
