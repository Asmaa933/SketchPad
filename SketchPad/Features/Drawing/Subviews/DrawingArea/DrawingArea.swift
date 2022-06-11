//
//  DrawingArea.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum TouchEvent {
    case began
    case moved
    case ended
}

class DrawingArea: UIImageView {
        
    var didTouchCallback: (((point: CGPoint, event: TouchEvent)) -> Void)?
    private var imageData = Data() {
        didSet {
            image = UIImage(data: imageData)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(with imageData: Data) {
        isUserInteractionEnabled = true
        backgroundColor = .clear
        contentMode = .scaleAspectFit
        self.imageData = imageData
    }
    
    func set(lines: [LineInfo]) {
        image = UIImage(data: imageData)
        drawLinesOnImage(lines)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouches(touches, type: .began)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouches(touches, type: .moved)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouches(touches, type: .ended)
    }
}

fileprivate extension DrawingArea {
    
    func didTouches(_ touches: Set<UITouch>, type: TouchEvent) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        didTouchCallback?((currentPoint, type))
    }
}
