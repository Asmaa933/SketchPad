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

class DrawingArea: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        contentMode = .scaleAspectFit
        return imageView
    }()
    
    var didTouchCallback: (((point: CGPoint, event: TouchEvent)) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView(with imageData: Data) {
        backgroundColor = .darkGray
        imageView.image = UIImage(data: imageData)
        addSubview(imageView)
        let heightRatio = frame.size.width * 1.3
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalTo: widthAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: heightRatio),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     imageView.centerYAnchor.constraint(equalTo: centerYAnchor)])
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
        guard let touch = touches.first, touch.view == imageView else { return }
        let currentPoint = touch.location(in: imageView)
        didTouchCallback?((currentPoint, type))
    }
}
