//
//  EnterNameViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

class EnterNameViewController: UIViewController {
    
    @IBOutlet private weak var alertView: UIView!
    @IBOutlet private weak var nameTextField: UITextField!
    
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
    
    @IBAction private func saveAction(_ sender: UIButton) {
        nameTextField.resignFirstResponder()
        viewModel.handleAlertAction(.save(imageName: nameTextField.text ?? ""))
    }
    
    @IBAction private func cancelAction(_ sender: UIButton) {
        dismissView()
    }
    
    @IBAction private func backgroundViewTapped(_ sender: UITapGestureRecognizer) {
        dismissView()
    }
}

fileprivate extension EnterNameViewController {
    
    func handleViewDidLoad() {
        viewModel.statePresenter = self
        setupView()
    }
    
    func setupView() {
        alertView.addShadow()
        nameTextField.text = viewModel.getImageName()
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.color(for: .sketchBarColor)]
        )
    }
    
    func dismissView() {
        viewModel.handleAlertAction(.cancel)
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
