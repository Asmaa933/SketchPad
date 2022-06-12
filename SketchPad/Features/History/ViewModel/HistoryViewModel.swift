//
//  HistoryViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol HistoryViewModelProtocol {
    func viewDidLoad()
}

class HistoryViewModel {
    private var coordinator: HistoryCoordinatorProtocol
    private var dataProvider: HistoryDataProviderProtocol
    private lazy var sketches = [Sketch]()
    
    init(coordinator: HistoryCoordinatorProtocol, dataProvider: HistoryDataProviderProtocol) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
    }
}

fileprivate extension HistoryViewModel {
    func loadHistory() {
        dataProvider.getHistory {[weak self] result in
            guard let self = self else { return }
            self.handleHistoryResult(result: result)
        }
    }
    
    func handleHistoryResult(result: SketchResult) {
        switch result {
        case .success(let sketches):
            self.sketches = sketches
            debugPrint(sketches)
            #warning("reloadTableView")
        case .failure:
            coordinator.showError(message: .generalError)
        }
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {
    func viewDidLoad() {
        loadHistory()
    }

}
