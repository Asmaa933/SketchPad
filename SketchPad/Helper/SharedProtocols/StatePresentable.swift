//
//  StatePresentable.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation
import UIKit.UIColor

protocol AppState {}

enum DrawingState: AppState {
    case imagePicked(imageData: Data)
    case draw(lines: [LineInfo])
    case colorChanged(newColor: UIColor)
    case close
    case deleteMode(isOn: Bool)
    case shouldChangeHidden(hiddenButtons: [DrawingTopBarButton],
                            notHiddenButtons: [DrawingTopBarButton])
}

enum PreviewState: AppState {
    case saveButtonIsHidden(Bool)
    case rotate(angle: CGFloat)
}

enum EnterNameState: AppState {
    case showError(error: AppError)
}

enum HistoryState: AppState {
    case reloadHistoryTableView(isEmpty: Bool)
}

protocol StatePresentable {
    func render<T: AppState>(state: T, mapping: T.Type)
}
