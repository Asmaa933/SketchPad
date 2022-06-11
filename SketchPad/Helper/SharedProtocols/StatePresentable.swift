//
//  StatePresentable.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol AppState {}

enum DrawingState: AppState {
    case imagePicked(imageData: Data)
    case draw(lines: [LineInfo])
    
}

protocol StatePresentable {
    func render<T: AppState>(state: T, mapping: T.Type)
}
