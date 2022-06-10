//
//  PreviewSketchView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class PreviewSketchView: UIView {
    
    @IBOutlet private weak var topBar: PreviewTopBar!
    @IBOutlet private weak var previewImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
}
