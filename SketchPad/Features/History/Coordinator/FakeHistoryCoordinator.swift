//
//  FakeHistoryCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import UIKit

class FakeHistoryCoordinator: HistoryCoordinatorProtocol {
    var errorShowed = false
    var previewedSketchUUID: UUID?
    var wentToDrawing = false
    
    func showError(message: AppError, actions: [UIAlertAction]) {
        errorShowed = true
    }
    
    func previewSketch(with sketch: Sketch) {
        previewedSketchUUID = sketch.id
    }
    
    func goToDrawing() {
        wentToDrawing = true
    }
}
