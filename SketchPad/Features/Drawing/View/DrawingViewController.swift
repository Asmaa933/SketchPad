//
//  DrawingViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class DrawingViewController: UIViewController {
    
    private lazy var addPhotoButton = FilledButton()
    
    private lazy var sketchView: SketchView = SketchView()
    
    private var viewModel: DrawingViewModelProtocol
    
    init(viewModel: DrawingViewModelProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

fileprivate extension DrawingViewController {
    
    func handleViewDidLoad() {
        bindToViewModel()
        setupAddPhotoButton()
    }
    
    func bindToViewModel() {
        viewModel.statePresenter = self
    }
}

//MARK: - AddPhotoButton Helper Methods

fileprivate extension DrawingViewController {
    
    func setupAddPhotoButton() {
        addPhotoButton = FilledButton()
        addPhotoButton.title = .addPhoto
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .color(for: .backgroundColor)
        view.addSubview(addPhotoButton)
        NSLayoutConstraint.activate([addPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     addPhotoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     addPhotoButton.heightAnchor.constraint(equalToConstant: 50),
                                     addPhotoButton.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2)])
        addPhotoButton.tapped = {[weak self] in
            guard let self = self else { return }
            self.handleButtonTapped()
        }
    }
    
    func handleButtonTapped() {
        viewModel.getImage()
    }
    
    func removeAddPhotoButton() {
        addPhotoButton.removeFromSuperview()
    }
}

//MARK: - SketchView Helper Methods
fileprivate extension DrawingViewController {
    
    func setupSketchView(with imageData: Data) {
        sketchView = SketchView()
        sketchView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .color(for: .sketchBarColor)
        sketchView.setImage(imageData: imageData)
        sketchView.delegate = self
        view.addSubview(sketchView)
        NSLayoutConstraint.activate([sketchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     sketchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     sketchView.topAnchor.constraint(equalTo: view.topAnchor),
                                     sketchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    func removeSketchView() {
        sketchView.removeFromSuperview()
    }
}

extension DrawingViewController: StatePresentable {
    
    func render<T>(state: T, mapping: T.Type) where T : AppState {
        guard let drawingState = state as? DrawingState  else { return }
        switch drawingState {
            
        case .imagePicked(let imageData):
            self.removeAddPhotoButton()
            self.setupSketchView(with: imageData)
            
        case .draw(let lines):
            sketchView.draw(lines: lines)
            
        case .colorChanged(let newColor):
            sketchView.set(color: newColor)
            
        case .close:
            self.removeSketchView()
            self.setupAddPhotoButton()
            
        case .deleteMode(let isOn):
            if isOn {
                view.showToast(with: TitleConstant.deleteModeOn.rawValue)
                sketchView.changeTopButtonsHidden(hiddenButtons: [.redo,.undo,.delete],
                                                  unhiddenButtons: [])
            } else {
                sketchView.changeTopButtonsHidden(hiddenButtons: [],
                                                  unhiddenButtons: [.redo,.undo,.delete])
            }
            
        case .shouldChangeHidden(let hiddenButton, let notHiddenButton):
            sketchView.changeTopButtonsHidden(hiddenButtons: hiddenButton,
                                              unhiddenButtons: notHiddenButton)
        }
    }
}

extension DrawingViewController: SketchViewDelegate {
    
    func topBarButtonTapped(_ button: DrawingTopBarButton) {
        viewModel.topBarButtonTapped(button)
    }
    
    func didTouch(at point: CGPoint, eventType: TouchEvent) {
        viewModel.didTouchImage(at: point, eventType: eventType)
    }
    
    func bottomBarActionFired(_ action: BottomBarAction) {
        viewModel.bottomBarActionFired(action)
    }
    
    func doneButtonTapped(imageData: Data?) {
        viewModel.doneButtonTapped(imageData: imageData)
    }
}
