//
//  HistoryViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol HistoryViewModelProtocol {
    
}

class HistoryViewModel {
    private var coordinator: HistoryCoordinatorProtocol
    
    init(coordinator: HistoryCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {
    
}
