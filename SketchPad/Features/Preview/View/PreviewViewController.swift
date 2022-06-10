//
//  PreviewViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class PreviewViewController: UIViewController {
    
    
    //    private var viewModel: PreviewViewModelProtocol
    private lazy var previewSketchView: PreviewSketchView = {
        let view = PreviewSketchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
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
}
