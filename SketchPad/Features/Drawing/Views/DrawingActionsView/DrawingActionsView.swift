//
//  DrawingActionsView.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

fileprivate enum SketchActionButton {
    case close
    case undo
    case redo
    case delete
    case done
}

class DrawingActionsView: UIView {
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var redoButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
    
    @IBAction private func closeButtonAction(_ sender: UIButton) {
    }
    
    @IBAction private func undoButtonAction(_ sender: UIButton) {
    }
    
    @IBAction private func redoButtonAction(_ sender: UIButton) {
    }
    
    @IBAction private func deleteButtonAction(_ sender: UIButton) {
    }
    
    @IBAction private func doneButtonAction(_ sender: UIButton) {
    }
}
