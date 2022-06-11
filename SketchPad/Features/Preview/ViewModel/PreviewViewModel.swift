//
//  PreviewViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol PreviewViewModelProtocol {
    var imageData: Data { get }
    var statePresenter: StatePresentable? { get set }
    func topBarButtonTapped(_ button: PreviewTopBarButton)
}

class PreviewViewModel {
    
    private var coordinator: PreviewCoordinatorProtocol
    private var canEdit: Bool
    private(set) var imageData: Data
    var statePresenter: StatePresentable?
    
    init(coordinator: PreviewCoordinatorProtocol,
         canEdit: Bool,
         imageData: Data) {
        self.coordinator = coordinator
        self.canEdit = canEdit
        self.imageData = imageData
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
}
