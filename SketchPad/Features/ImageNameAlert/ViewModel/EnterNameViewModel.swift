//
//  EnterNameViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import Foundation

protocol EnterNameViewModelProtocol {
    func handleAlertAction(_ action: NameAlertAction)
}

class EnterNameViewModel {
  
    private var coordinator: EnterNameCoordinatorProtocol
    
    init(coordinator: EnterNameCoordinatorProtocol, sketch: Sketch) {
        self.coordinator = coordinator
    }
}

extension EnterNameViewModel: EnterNameViewModelProtocol {
    func handleAlertAction(_ action: NameAlertAction) {
        switch action {
        case .save(let imageName):
            break
        case .cancel:
            coordinator.cancelAlert()
        }
    }
}
