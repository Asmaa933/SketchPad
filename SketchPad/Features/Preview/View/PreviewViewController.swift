//
//  PreviewViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class PreviewViewController: UIViewController {
    
    private lazy var previewSketchView: PreviewSketchView = {
        let view = PreviewSketchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var viewModel: PreviewViewModelProtocol

    init(viewModel: PreviewViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewDidLoad()
    }
    
}

fileprivate extension PreviewViewController {
    func handleViewDidLoad() {
        addPreviewView()
    }
    
    func addPreviewView() {
        view.addSubview(previewSketchView)
        NSLayoutConstraint.activate([previewSketchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     previewSketchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     previewSketchView.topAnchor.constraint(equalTo: view.topAnchor),
                                     previewSketchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
