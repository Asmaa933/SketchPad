//
//  PreviewSketchView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol PreviewSketchViewDelegate: AnyObject {
    func topBarButtonTapped(_ button: PreviewTopBarButton)
}

class PreviewSketchView: UIView {
    
    @IBOutlet private weak var topBar: PreviewTopBar!
    @IBOutlet private weak var previewImageView: UIImageView!
    
    weak var delegate: PreviewSketchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
        handleTopBarCallBack()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
        handleTopBarCallBack()
    }
    
    func setImage(with imageData: Data) {
        previewImageView.image = UIImage(data: imageData)
    }
    
    func rotateImage(by angle: CGFloat) {
        previewImageView.image = previewImageView.image?.rotate(by: angle)
    }
}

fileprivate extension PreviewSketchView {
    func handleTopBarCallBack() {
        topBar.topBarButtonTapped = {[weak self] button in
            guard let self = self else { return }
            self.delegate?.topBarButtonTapped(button)
        }
    }
}


