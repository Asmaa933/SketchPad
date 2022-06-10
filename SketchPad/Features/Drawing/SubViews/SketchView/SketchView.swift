//
//  DrawingView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class SketchView: UIView {
    
    @IBOutlet private weak var topBar: DrawingTopBar!
    @IBOutlet private weak var drawingArea: DrawingArea!
    @IBOutlet private weak var bottomBar: DrawingBottomBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
    
    func setImage(imageData: Data) {
        drawingArea.selectedImageData = imageData
    }
    
}
