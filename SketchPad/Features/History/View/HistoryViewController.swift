//
//  HistoryViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet private weak var historyTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewDidLoad()
    }
    
    private var viewModel: HistoryViewModelProtocol
    
    init(viewModel: HistoryViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension HistoryViewController {
    
    func handleViewDidLoad() {
        viewModel.statePresenter = self
        setupHistoryTableView()
        viewModel.viewDidLoaded()
    }
    
    func setupHistoryTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.registerCellNib(cellClass: HistoryTableViewCell.self)
    }
    
    func createSwipeActions(for indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let deleteAction = UIContextualAction(style: .normal,
                                              title: TitleConstant.delete.rawValue) {[weak self] _, _, completion in
            guard let self = self else { return }
            self.viewModel.deleteSketch(at: indexPath)
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .normal,
                                            title: TitleConstant.edit.rawValue) {[weak self] _, _, completion in
            guard let self = self else { return }
            self.viewModel.editSketch(at: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
}

extension HistoryViewController: StatePresentable {
    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let state = state as? HistoryState else { return }
        
        switch state {
        case .reloadHistoryTableView:
            historyTableView.reloadData()
            break
        }
    }

}

extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sketchDidSelected(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return createSwipeActions(for: indexPath)
    }
}

extension HistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getSectionsCount()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getTitle(for: section)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSketchesCount(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HistoryTableViewCell
        cell.configureCell(with: viewModel.getSketch(for: indexPath))
        return cell
    }
}
