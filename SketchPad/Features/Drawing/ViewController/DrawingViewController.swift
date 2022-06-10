//
//  DrawingViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class DrawingViewController: UIViewController {
    
    private lazy var addPhotoButton: FilledButton = {
        let button = FilledButton()
        button.title = .addPhoto
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var sketchView: SketchView = {
        let view = SketchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewDidLoad()
    }

}

fileprivate extension DrawingViewController {
    
    func handleViewDidLoad() {
        setupAddPhotoButton()
    }
//MARK: - AddPhotoButton Helper Methods

fileprivate extension DrawingViewController {
    
    func setupAddPhotoButton() {
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
    
    #warning("get Image with coordinator")
    func handleButtonTapped() {
        debugPrint("add button tapped")
    }
    
    func removeAddPhotoButton() {
        addPhotoButton.removeFromSuperview()
    }
}

//MARK: - SketchView Helper Methods
fileprivate extension DrawingViewController {
    
    func setupSketchView() {
        view.backgroundColor = .color(for: .sketchBarColor)
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
