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
    func getImageName() -> String
}

class EnterNameViewModel {
    
    private var coordinator: EnterNameCoordinatorProtocol
    private var sketch: Sketch
    private var cachingManager: CachingManager
    private var isEdit: Bool
    var statePresenter: StatePresentable?
    
    init(coordinator: EnterNameCoordinatorProtocol,
         sketch: Sketch,
         cachingManger: CachingManager = .shared) {
        self.coordinator = coordinator
        self.sketch = sketch
        self.cachingManager = cachingManger
        self.isEdit = sketch.imageName != nil
    }
}

extension EnterNameViewModel: EnterNameViewModelProtocol {
    
    func handleAlertAction(_ action: NameAlertAction) {
        switch action {
            
        case .save(let imageName):
            if validate(imageName: imageName) {
                sketch.imageName = imageName
                isEdit ? update() : save()
            }
            
        case .cancel:
            coordinator.cancelAlert()
        }
    }
    
    func getImageName() -> String {
        return sketch.imageName ?? ""
    }
}

fileprivate extension EnterNameViewModel {
    
    func validate(imageName: String) -> Bool {
        if imageName.isEmpty {
            statePresenter?.render(state: EnterNameState.showError(error: .enterName),
                                   mapping: EnterNameState.self)
            return false
        } else {
            return true
        }
    }
    
    func save() {
        let result = cachingManager.saveIntoCache(item: sketch)
        self.handleSaveResult(result: result)
    }
    
    func update() {
        let result = cachingManager.updateSketch(sketch)
        self.handleSaveResult(result: result)
    }
    
    func handleSaveResult(result: Result<Bool,AppError>) {
        switch result {
        case .success:
            PhotoLibraryManager().saveIntoPhoto(imageData: sketch.imageData)
            coordinator.showSavedSuccessfully(message: TitleConstant.sketchSaved)
        case .failure:
            statePresenter?.render(state: EnterNameState.showError(error: .generalError),
                                   mapping: EnterNameState.self)
        }
    }
}
