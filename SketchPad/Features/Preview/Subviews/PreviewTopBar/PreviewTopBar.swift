//
//  PreviewTopBar.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum PreviewTopBarButton {
    case back
    case rotateLeft
    case rotateRight
}

class PreviewTopBar: UIView {
    #warning("change icon to x when presenting")
    @IBOutlet private weak var saveButton: UIButton!
    
    weak var delegate: PreviewTopBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }

    @IBAction private func backAction(_ sender: UIButton) {
        delegate?.topBarButtonTapped(.back)
    }
    
    @IBAction private func saveAction(_ sender: UIButton) {
        delegate?.saveButtonTapped()
    }
    
    @IBAction private func rotateLeftAction(_ sender: UIButton) {
        delegate?.topBarButtonTapped(.rotateLeft)
    }
    
    @IBAction private func rotateRightAction(_ sender: UIButton) {
        delegate?.topBarButtonTapped(.rotateRight)
    }
    
    func shouldHideSave(_ isHidden: Bool) {
        saveButton.isHidden = isHidden
    }
}
