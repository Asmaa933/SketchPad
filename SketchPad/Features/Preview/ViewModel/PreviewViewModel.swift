//
//  PreviewViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol PreviewViewModelProtocol {
    var imageData: Data { get }
    func topBarButtonTapped(_ button: PreviewTopBarButton)
    func saveButtonTapped(imageData: Data?)
}

class PreviewViewModel {
    
    private var coordinator: PreviewCoordinatorProtocol
    private var canEdit: Bool
    private(set) var imageData: Data
    private var cachingManager: CachingManager
    
    init(coordinator: PreviewCoordinatorProtocol,
         canEdit: Bool,
         imageData: Data,
         cachingManager: CachingManager = .shared) {
        self.coordinator = coordinator
        self.canEdit = canEdit
        self.imageData = imageData
        self.cachingManager = cachingManager
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
            break
        case .rotateRight:
            break
        }
    }
    
    func saveButtonTapped(imageData: Data?) {
        guard let imageData = imageData else { return }
        let sketch: Sketch = Sketch(imageName: "xxxx",
                                    imageData: imageData,
                                    createdAt: Date())
        cachingManager.saveIntoCoreData(item: sketch)
    }
}
