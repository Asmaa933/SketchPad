//
//  FakeHistoryViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import UIKit

class FakeHistoryViewController: StatePresentable {
    var isEmpty = true

    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let state = state as? HistoryState else { return }
        switch state {
        case .reloadHistoryTableView(let isEmpty):
            self.isEmpty = isEmpty
        }
    }
}
