//
//  PreviewSketchView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol PreviewSketchViewDelegate: AnyObject {
    func topBarButtonTapped(_ button: PreviewTopBarButton)
    func saveButtonTapped(imageData: Data?)
}

class PreviewSketchView: UIView {
    
    @IBOutlet private weak var topBar: PreviewTopBar!
    @IBOutlet private weak var previewImageView: UIImageView!
    
    weak var delegate: PreviewSketchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
        setupTopBarCallBack()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
        setupTopBarCallBack()
    }
    
    func setImage(with imageData: Data?) {
        guard let imageData = imageData else { return }
        previewImageView.image = UIImage(data: imageData)
    }
    
    func rotateImage(by angle: CGFloat) {
        previewImageView.image = previewImageView.image?.rotate(by: angle)
    }
}

fileprivate extension PreviewSketchView {
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
            self.delegate?.saveButtonTapped(imageData: imageData)
        default:
            self.delegate?.topBarButtonTapped(button)
        }
    }
}


