//
//  PreviewTopBar.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum PreviewTopBarButton {
    case back
    case save
    case rotateLeft
    case rotateRight
}

class PreviewTopBar: UIView {
    
    var topBarButtonTapped: ((PreviewTopBarButton) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }

    @IBAction private func backAction(_ sender: UIButton) {
        topBarButtonTapped?(.back)
    }
    
    @IBAction private func saveAction(_ sender: UIButton) {
        topBarButtonTapped?(.save)
    }
    
    @IBAction private func rotateLeftAction(_ sender: UIButton) {
        topBarButtonTapped?(.rotateLeft)
    }
    
    @IBAction private func rotateRightAction(_ sender: UIButton) {
        topBarButtonTapped?(.rotateRight)
    }
}
