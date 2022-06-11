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
        viewModel.statePresenter = self
        handleViewDidLoad()
    }
    
}

fileprivate extension PreviewViewController {
    func handleViewDidLoad() {
        addPreviewView()
    }
    
    func addPreviewView() {
        view.addSubview(previewSketchView)
        previewSketchView.delegate = self
        previewSketchView.setImage(with: viewModel.imageData)
        NSLayoutConstraint.activate([previewSketchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     previewSketchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     previewSketchView.topAnchor.constraint(equalTo: view.topAnchor),
                                     previewSketchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}

extension PreviewViewController: PreviewSketchViewDelegate {
    func topBarButtonTapped(_ button: PreviewTopBarButton) {
        viewModel.topBarButtonTapped(button)
    }
    
    func saveButtonTapped(imageData: Data?) {
        viewModel.saveButtonTapped(imageData: imageData)
    }
}

extension PreviewViewController: StatePresentable {
    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let previewState = state as? PreviewState  else { return }
        switch previewState {
        case .rotate(let angle):
            previewSketchView.rotateImage(by: angle)
        }
    }
}
