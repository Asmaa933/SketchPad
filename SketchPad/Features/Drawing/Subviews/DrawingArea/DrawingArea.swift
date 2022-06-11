//
//  DrawingArea.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class DrawingArea: UIView {
    
    private lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleAspectFit
        return imageView
    }()
    
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
}

fileprivate extension DrawingArea {
    
   
}
