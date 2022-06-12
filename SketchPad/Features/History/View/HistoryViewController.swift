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
        viewModel.viewDidLoad()
    }
    
    func setupHistoryTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.registerCellNib(cellClass: HistoryTableViewCell.self)
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
    
}

extension HistoryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HistoryTableViewCell
        return cell
    }
}
