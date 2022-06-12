//
//  HistoryViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

protocol HistoryViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func viewDidLoaded()
    func getSectionsCount() -> Int
    func getTitle(for section: Int) -> String
    func getSketchesCount(in section: Int) -> Int
    func getSketch(for indexPath: IndexPath) -> DisplayedSketch?
    func sketchDidSelected(at indexPath: IndexPath)
//    func deleteSketch(at index: Int)
//    func editSketch(at index: Int)z
}

class HistoryViewModel {
    private var coordinator: HistoryCoordinatorProtocol
    private var dataProvider: HistoryDataProviderProtocol
    private lazy var groupedSketches = [HistorySketchSection]()
    private lazy var loadedSketches = [Sketch]()
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
        case .success((let sketchesInSection, let sketches)):
            self.groupedSketches = sketchesInSection
            self.loadedSketches = sketches
            debugPrint(sketches)
            statePresenter?.render(state: HistoryState.reloadHistoryTableView,
                                   mapping: HistoryState.self)
        case .failure:
            coordinator.showError(message: .generalError)
        }
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {

    func viewDidLoaded() {
        loadHistory()
    }
    
    func getSectionsCount() -> Int {
        return groupedSketches.count
    }
    
    func getTitle(for section: Int) -> String {
        return groupedSketches[section].date
    }
    
    func getSketchesCount(in section: Int) -> Int {
        return groupedSketches[section].SectionData?.count ?? 0
    }
    
    func getSketch(for indexPath: IndexPath) -> DisplayedSketch? {
        return groupedSketches[indexPath.section].SectionData?[indexPath.row].toDisplay
    }
    
    func sketchDidSelected(at indexPath: IndexPath) {
        let section = groupedSketches[indexPath.section]
        guard let sketch = section.SectionData?[indexPath.row].toDisplay else { return }
        coordinator.previewSketch(with: sketch.imageData)
    }
}
