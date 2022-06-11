//
//  EnterNameViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import Foundation

protocol EnterNameViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func handleAlertAction(_ action: NameAlertAction)
}

class EnterNameViewModel {
    
    private var coordinator: EnterNameCoordinatorProtocol
    private var sketch: Sketch
    private var cachingManager: CachingManager
    var statePresenter: StatePresentable?
    
    init(coordinator: EnterNameCoordinatorProtocol,
         sketch: Sketch,
         cachingManger: CachingManager = .shared) {
        self.coordinator = coordinator
        self.sketch = sketch
        self.cachingManager = cachingManger
    }
}

extension EnterNameViewModel: EnterNameViewModelProtocol {
    func handleAlertAction(_ action: NameAlertAction) {
        switch action {
        case .save(let imageName):
            if validate(imageName: imageName) {
                sketch.imageName = imageName
                cachingManager.saveIntoCoreData(item: sketch)
            }
        case .cancel:
            coordinator.cancelAlert()
        }
    }
    
    func validate(imageName: String) -> Bool {
        if imageName.isEmpty {
            statePresenter?.render(state: EnterNameState.showError(error: .enterName),
                                   mapping: EnterNameState.self)
            return false
        } else {
            return true
        }
    }
}
