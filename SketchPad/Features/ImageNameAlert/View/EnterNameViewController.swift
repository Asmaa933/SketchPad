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
        view.backgroundColor = .black.withAlphaComponent(30)
        setupNameAlert()
        setupCallBack()
    }
    
    func setupNameAlert() {
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
