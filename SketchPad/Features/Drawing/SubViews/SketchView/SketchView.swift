//
//  DrawingView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol SketchViewDelegate: AnyObject {
    func topBarButtonTapped(_ button: DrawingTopBarButton)
}

class SketchView: UIView {
    
    @IBOutlet private weak var topBar: DrawingTopBar!
    @IBOutlet private weak var drawingArea: DrawingArea!
    @IBOutlet private weak var bottomBar: DrawingBottomBar!
    
    weak var delegate: SketchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
        setupCallBacks()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
        setupCallBacks()
    }
    
    func setImage(imageData: Data) {
        drawingArea.selectedImageData = imageData
    }
    
}

fileprivate extension SketchView {
    
    func setupCallBacks() {
        setupTopBarCallBack()
    }
    
    func setupTopBarCallBack() {
        topBar.topBarButtonTapped = {[weak self] button in
            guard let self = self else { return }
        }
    }
}
