//
//  PreviewViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol PreviewSketchViewDelegate: AnyObject {
    func topBarButtonTapped(_ button: PreviewTopBarButton)
    func saveButtonTapped(imageData: Data?)
}

class PreviewViewController: UIViewController {
    
    
    @IBOutlet private weak var topBar: PreviewTopBar!
    @IBOutlet private weak var previewImageView: UIImageView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
}

fileprivate extension PreviewViewController {
    func handleViewDidLoad() {
        viewModel.viewDidLoad()
        setupTopBarCallBack()
        setImage(with: viewModel.sketch.imageData)
    }
    
    func setupTopBarCallBack() {
        topBar.topBarButtonTapped = {[weak self] button in
            guard let self = self else { return }
            self.handleTapBarCallBack(button)
        }
    }
    
    func handleTapBarCallBack( _ button: PreviewTopBarButton) {
        switch button {
        case .save:
            let imageData = previewImageView.image?.pngData()
            viewModel.saveButtonTapped(imageData: imageData)
        default:
            viewModel.topBarButtonTapped(button)
        }
    }
    
    func setImage(with imageData: Data?) {
        guard let imageData = imageData else { return }
        previewImageView.image = UIImage(data: imageData)
    }
    
    func rotateImage(by angle: CGFloat) {
        previewImageView.image = previewImageView.image?.rotate(by: angle)
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
            rotateImage(by: angle)
            
        case .canEdit(let canEdit):
            topBar.shouldHideSave(!canEdit)
        }
    }
}
