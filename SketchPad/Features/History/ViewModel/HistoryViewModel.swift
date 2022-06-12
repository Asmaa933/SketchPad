//
//  HistoryViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol HistoryViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func viewDidLoad()
    func getSketchesCount() -> Int
    func getSketch(at index: Int) -> HistorySketchSection
//    func sketchDidSelected(at index: Int)
//    func deleteSketch(at index: Int)
//    func editSketch(at index: Int)z
}

class HistoryViewModel {
    private var coordinator: HistoryCoordinatorProtocol
    private var dataProvider: HistoryDataProviderProtocol
    private lazy var sketches = [HistorySketchSection]()
    var statePresenter: StatePresentable?
    
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
            statePresenter?.render(state: HistoryState.reloadHistoryTableView,
                                   mapping: HistoryState.self)
        case .failure:
            coordinator.showError(message: .generalError)
        }
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {

    func viewDidLoad() {
        loadHistory()
    }
    
    func getSketchesCount() -> Int {
        return sketches.count
    }

    func getSketch(at index: Int) -> HistorySketchSection {
        return sketches[index]
    }
}
