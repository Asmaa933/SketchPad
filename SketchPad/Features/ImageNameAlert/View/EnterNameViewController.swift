//
//  EnterNameViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

class EnterNameViewController: UIViewController {

    private lazy var enterNameAlert: EnterNameAlert = {
        let alert = EnterNameAlert()
        alert.translatesAutoresizingMaskIntoConstraints = false
        return alert
    }()
    
    private var viewModel: EnterNameViewModelProtocol
    
    init(viewModel: EnterNameViewModelProtocol) {
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

fileprivate extension EnterNameViewController {
    func handleViewDidLoad() {
        view.backgroundColor = .black.withAlphaComponent(0.3)
        viewModel.statePresenter = self
        addTapGestureToView()
        setupNameAlert()
        setupCallBack()
    }
    
    func addTapGestureToView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissView() {
        viewModel.handleAlertAction(.cancel)
    }
    
    func setupNameAlert() {
        enterNameAlert.setupTextField(text: viewModel.getImageName())
        view.addSubview(enterNameAlert)
        NSLayoutConstraint.activate([enterNameAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     enterNameAlert.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     enterNameAlert.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85)
        ])
    }
    
    func setupCallBack() {
        enterNameAlert.callBack = {[weak self] action in
            guard let self = self else { return }
            self.viewModel.handleAlertAction(action)
        }
    }
}

extension EnterNameViewController: StatePresentable {
    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let previewState = state as? EnterNameState else { return }
        switch previewState {
        case .showError(let error):
            view.showToast(with: error.rawValue)
        }
    }
}
