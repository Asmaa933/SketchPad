//
//  DrawingArea.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class DrawingArea: UIImageView {
    
    var selectedImageData = Data() {
        didSet {
            image = UIImage(data: selectedImageData)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImage()
    }
}

fileprivate extension DrawingArea {
    
    func setupImage() {
        contentMode = .scaleAspectFit
        backgroundColor = .darkGray
    }
}
