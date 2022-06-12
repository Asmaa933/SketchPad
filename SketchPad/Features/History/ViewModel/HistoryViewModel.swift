//
//  HistoryViewModel.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import Foundation

enum HistoryMode {
    case notSearching
    case searching(text: String)
}

protocol HistoryViewModelProtocol {
    var statePresenter: StatePresentable? { get set }
    func loadHistory()
    func getSectionsCount() -> Int
    func getTitle(for section: Int) -> String
    func getSketchesCount(in section: Int) -> Int
    func getSketch(for indexPath: IndexPath) -> DisplayedSketch?
    func sketchDidSelected(at indexPath: IndexPath)
    func deleteSketch(at indexPath: IndexPath)
    func editSketch(at indexPath: IndexPath)
    func searchForSketch(by text: String)
}

class HistoryViewModel {
    private var coordinator: HistoryCoordinatorProtocol
    private var dataProvider: HistoryDataProviderProtocol
    private var searchDispatcher: SearchDispatcher
    private var currentMode: HistoryMode = .notSearching
    private lazy var groupedSketches = [HistorySketchSection]() {
        didSet {
            reloadTableView()
        }
    }
    
    var statePresenter: StatePresentable?
    
    init(coordinator: HistoryCoordinatorProtocol,
         dataProvider: HistoryDataProviderProtocol,
         searchDispatcher: SearchDispatcher = SearchDispatchItem()) {
        self.coordinator = coordinator
        self.dataProvider = dataProvider
        self.searchDispatcher = searchDispatcher
    }
}

fileprivate extension HistoryViewModel {
    
    func handleHistoryResult(result: SketchResult) {
        switch result {
        case .success(let sketchesInSection):
            self.groupedSketches = sketchesInSection
        case .failure:
            coordinator.showError(message: .generalError)
        }
    }
    
    func reloadTableView() {
        statePresenter?.render(state: HistoryState.reloadHistoryTableView,
                               mapping: HistoryState.self)
    }
    
    func handleDeleteResult(_ result: CallBackResult, indexPath: IndexPath) {
        switch result {
        case .success(_):
            groupedSketches[indexPath.section].SectionData?.remove(at: indexPath.row)
        case .failure(let error):
            coordinator.showError(message: error)
        }
    }
    
    func searchForSketchesInCache(by imageName: String) {
        dataProvider.searchForSketches(by: imageName) {[weak self] result in
            guard let self = self else { return }
            self.handleHistoryResult(result: result)
        }
    }
}

extension HistoryViewModel: HistoryViewModelProtocol {
    
    func loadHistory() {
        dataProvider.getHistory {[weak self] result in
            guard let self = self else { return }
            self.handleHistoryResult(result: result)
        }
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
        guard let sketch = section.SectionData?[indexPath.row] else { return }
        coordinator.previewSketch(with: sketch)
    }
    #warning("show alert")
    func deleteSketch(at indexPath: IndexPath) {
        guard let sketches = groupedSketches[indexPath.section].SectionData,
              let id = sketches[indexPath.row].id else { return }
        dataProvider.deleteSketchFromCaching(id: id) {[weak self] result in
            guard let self = self else { return }
            self.handleDeleteResult(result, indexPath: indexPath)
        }
    }
    
    func editSketch(at indexPath: IndexPath) {
        
    }
    
    func searchForSketch(by text: String) {
        if text.isEmpty {
            currentMode = .notSearching
            dataProvider.getHistory {[weak self] result in
                guard let self = self else { return }
                self.handleHistoryResult(result: result)
            }
        } else {
            searchDispatcher.call {[weak self] in
                guard let self = self else { return }
                self.currentMode = .searching(text: text)
                self.searchForSketchesInCache(by: text)
            }
        }
    }
}
