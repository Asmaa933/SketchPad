//
//  DrawingViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol DrawingViewModelProtocol {
    func getImage()
    var imageDidPicked: ((Data) -> Void)? { get set }

}

class DrawingViewModel {
    
    private var coordinator: DrawingCoordinatorProtocol
    var imageDidPicked: ((Data) -> Void)?
    
    init(coordinator: DrawingCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    
}

extension DrawingViewModel: DrawingViewModelProtocol {
    
    func getImage() {
    }
}
