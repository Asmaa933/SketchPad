//
//  HistoryViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class HistoryViewController: UIViewController {

    private lazy var sketchHistoryView: SketchHistoryView = {
       let view = SketchHistoryView()
        view.translatesAutoresizingMaskIntoConstraints = false
       return view
    }()
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
        setupSketchHistoryView()
        viewModel.viewDidLoad()
    }
    
    func setupSketchHistoryView() {
        view.addSubview(sketchHistoryView)
        NSLayoutConstraint.activate([sketchHistoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     sketchHistoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     sketchHistoryView.topAnchor.constraint(equalTo: view.topAnchor),
                                     sketchHistoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension HistoryViewController: StatePresentable {
    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let state = state as? HistoryState else { return }
        
        switch state {
        case .reloadHistoryTableView:
            sketchHistoryView.reloadHistoryTableView()
        }
    }
    
    
}
