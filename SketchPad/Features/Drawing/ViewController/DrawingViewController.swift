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

    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewDidLoad()
    }

}

fileprivate extension DrawingViewController {
    
    func handleViewDidLoad() {
        setupAddPhotoButton()
    }
    
    func setupAddPhotoButton() {
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
