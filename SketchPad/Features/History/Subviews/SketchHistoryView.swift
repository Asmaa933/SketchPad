//
//  SketchHistoryView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class SketchHistoryView: UIView {

    @IBOutlet private weak var historyTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
        setupView()
    }
    
    func reloadHistoryTableView() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            self.historyTableView.reloadData()
        }
    }
}

fileprivate extension SketchHistoryView {
    func setupView() {
        setupSearchBar()
        setupHistoryTableView()
    }
    
    func setupSearchBar() {
        
    }
    
    func setupHistoryTableView() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.registerCellNib(cellClass: HistoryTableViewCell.self)
    }
    
    
    
}

extension SketchHistoryView: UITableViewDelegate {
    
}

extension SketchHistoryView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as HistoryTableViewCell
        return cell
    }
}
