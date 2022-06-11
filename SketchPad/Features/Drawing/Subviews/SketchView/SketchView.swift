//
//  DrawingView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol SketchViewDelegate: AnyObject {
    func topBarButtonTapped(_ button: DrawingTopBarButton)
    func didTouch(at point: CGPoint, eventType: TouchEvent)
}

class SketchView: UIView {
    
    @IBOutlet private weak var topBar: DrawingTopBar!
    @IBOutlet private weak var drawingArea: DrawingArea!
    @IBOutlet private weak var bottomBar: DrawingBottomBar!
    
    weak var delegate: SketchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
        setupCallbacks()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
        setupCallbacks()
    }
    
    func setImage(imageData: Data) {
        drawingArea.setupView(with: imageData)
    }
    
}

fileprivate extension SketchView {
    
    func setupCallbacks() {
        setupTopBarCallback()
        setupDrawingCallback()
    }
    
    func setupTopBarCallback() {
        topBar.topBarButtonTapped = {[weak self] button in
            guard let self = self else { return }
            self.delegate?.topBarButtonTapped(button)
        }
    }
    
    func setupDrawingCallback() {
        drawingArea.didTouchCallback = {[weak self] touch in
            guard let self = self else { return }
            self.delegate?.didTouch(at: touch.point, eventType: touch.event)
        }
    }
}
