//
//  PreviewViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol PreviewViewModelProtocol {
    var sketch: Sketch { get }
    var statePresenter: StatePresentable? { get set }
    func viewDidLoad()
    func topBarButtonTapped(_ button: PreviewTopBarButton)
    func saveButtonTapped(imageData: Data?)
    func getCloseButtonImageName() -> AppImage
}

class PreviewViewModel {
    
    private var coordinator: PreviewCoordinatorProtocol
    private var canEdit: Bool
    private(set) var sketch: Sketch
    
    var statePresenter: StatePresentable?
    
    init(coordinator: PreviewCoordinatorProtocol,
         canEdit: Bool,
         sketch: Sketch) {
        self.coordinator = coordinator
        self.canEdit = canEdit
        self.sketch = sketch
    }
}

extension PreviewViewModel: PreviewViewModelProtocol {
    func topBarButtonTapped(_ button: PreviewTopBarButton) {
        switch button {
        case .back:
            coordinator.closeView(canEdit: canEdit)
        
        case .rotateLeft:
            statePresenter?.render(state: PreviewState.rotate(angle: Rotation.rotateLeft.angle),
                                   mapping: PreviewState.self)
        case .rotateRight:
            statePresenter?.render(state: PreviewState.rotate(angle: Rotation.rotateRight.angle),
                                   mapping: PreviewState.self)
        }
    }
    
    func saveButtonTapped(imageData: Data?) {
        guard let imageData = imageData else { return }
        sketch.imageData = imageData
        coordinator.presentEnterNameViewController(with: sketch)
    }
    
    func viewDidLoad() {
        statePresenter?.render(state: PreviewState.saveButtonIsHidden(!canEdit),
                               mapping: PreviewState.self)
    }
    
    func getCloseButtonImageName() -> AppImage {
        return canEdit ? .back : .close
    }
}
