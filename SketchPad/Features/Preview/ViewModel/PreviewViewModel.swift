//
//  PreviewViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol PreviewViewModelProtocol {
    var imageData: Data { get }
}

class PreviewViewModel {
    
    private var coordinator: PreviewCoordinatorProtocol
    private var canEdit: Bool
    private(set) var imageData: Data
    
    init(coordinator: PreviewCoordinatorProtocol,
         canEdit: Bool,
         imageData: Data) {
        self.coordinator = coordinator
        self.canEdit = canEdit
        self.imageData = imageData
    }
    
}

extension PreviewViewModel: PreviewViewModelProtocol {
    
}
