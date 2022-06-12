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
    func viewDidLoaded()
    func topBarButtonTapped(_ button: PreviewTopBarButton)
    func saveButtonTapped(imageData: Data?)
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
            coordinator.popViewController()
        case .save:
            break
        case .rotateLeft:
            statePresenter?.render(state: PreviewState.rotate(angle: -.pi / 2),
                                               mapping: PreviewState.self)
        case .rotateRight:
            statePresenter?.render(state: PreviewState.rotate(angle: .pi / 2),
                                               mapping: PreviewState.self)
        }
    }
    
    func saveButtonTapped(imageData: Data?) {
        guard let imageData = imageData else { return }
        let sketch = Sketch(imageData: imageData)
        coordinator.presentEnterNameViewController(with: sketch)
    }
    
    func viewDidLoaded() {
        statePresenter?.render(state: PreviewState.canEdit(canEdit),
                               mapping: PreviewState.self)
    }
}
