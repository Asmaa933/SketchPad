//
//  PreviewTopBar.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

fileprivate enum PreviewTopBarButton {
    case back
    case save
    case rotateLeft
    case rotateRight
}

class PreviewTopBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }

    @IBAction private func backAction(_ sender: UIButton) {
    }
    
    
    @IBAction private func saveAction(_ sender: UIButton) {
    }
    
    @IBAction private func rotateLeftAction(_ sender: UIButton) {
    }
    
    @IBAction private func rotateRightAction(_ sender: UIButton) {
    }
}
