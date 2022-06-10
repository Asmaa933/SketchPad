//
//  DrawingView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class SketchView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
    
}
