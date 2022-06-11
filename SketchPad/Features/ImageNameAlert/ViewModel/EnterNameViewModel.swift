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
    
    init(coordinator: EnterNameCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension EnterNameViewModel: EnterNameViewModelProtocol {
}
