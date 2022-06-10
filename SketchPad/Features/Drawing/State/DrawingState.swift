//
//  DrawingState.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

enum DrawingState {
    case imagePicked(imageData: Data)
    
    
}

protocol DrawingStatePresentable {
    func render(state: DrawingState)
}
