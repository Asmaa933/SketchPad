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
    func bottomBarActionFired(_ action: BottomBarAction)
    func doneButtonTapped(imageData: Data?)
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
    
    func draw(lines: [LineInfo]) {
        drawingArea.set(lines: lines)
    }
    
    func set(color: UIColor) {
        bottomBar.colorChanged(to: color)
    }
    
    func changeTopButtonsHidden(hiddenButtons: [DrawingTopBarButton],
                                unhiddenButtons: [DrawingTopBarButton]) {
        topBar.changeTopButtonsHidden(hiddenButtons: hiddenButtons,
                                      unhiddenButtons: unhiddenButtons)
    }
}

fileprivate extension SketchView {
    
    func setupCallbacks() {
        setupTopBarCallback()
        setupDrawingCallback()
        setupBottomBarCallback()
    }
    
    func setupTopBarCallback() {
        topBar.topBarButtonTapped = {[weak self] button in
            guard let self = self else { return }
            self.handleTopBarButtonCallBack(button)
        }
    }
    
    func handleTopBarButtonCallBack(_ button: DrawingTopBarButton) {
        switch button {
        case .done:
            self.delegate?.doneButtonTapped(imageData: drawingArea.getCurrentImageData())
        default:
            self.delegate?.topBarButtonTapped(button)
        }
    }
    
    func setupDrawingCallback() {
        drawingArea.didTouchCallback = {[weak self] touch in
            guard let self = self else { return }
            self.delegate?.didTouch(at: touch.point, eventType: touch.event)
        }
    }
    
    func setupBottomBarCallback() {
        bottomBar.callBack = {[weak self] action in
            guard let self = self else { return }
            self.delegate?.bottomBarActionFired(action)
        }
    }
}
