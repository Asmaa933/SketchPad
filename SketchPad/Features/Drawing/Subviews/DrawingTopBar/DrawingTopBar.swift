//
//  DrawingTopBar.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum DrawingTopBarButton {
    case close
    case undo
    case redo
    case delete
    case done
}

class DrawingTopBar: UIView {
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var undoButton: UIButton!
    @IBOutlet private weak var redoButton: UIButton!
    @IBOutlet private weak var deleteButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    
    var topBarButtonTapped: ((DrawingTopBarButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
    
    @IBAction private func closeButtonAction(_ sender: UIButton) {
        topBarButtonTapped?(.close)
    }
    
    @IBAction private func undoButtonAction(_ sender: UIButton) {
        topBarButtonTapped?(.undo)
    }
    
    @IBAction private func redoButtonAction(_ sender: UIButton) {
        topBarButtonTapped?(.redo)
    }
    
    @IBAction private func deleteButtonAction(_ sender: UIButton) {
        topBarButtonTapped?(.delete)
    }
    
    @IBAction private func doneButtonAction(_ sender: UIButton) {
        topBarButtonTapped?(.done)
    }
    
    func changeTopButtonsHidden(hiddenButtons: [DrawingTopBarButton],
                                unhiddenButtons: [DrawingTopBarButton]) {
        hiddenButtons.forEach { button in
            isButtonHidden(button, isHidden: true)
        }
        
        unhiddenButtons.forEach { button in
            isButtonHidden(button, isHidden: false)
        }
    }
    
    private func isButtonHidden(_ button: DrawingTopBarButton, isHidden: Bool) {
        switch button {
        case .undo:
            undoButton.isHidden = isHidden
        case .redo:
            redoButton.isHidden = isHidden
        case .delete:
            deleteButton.isHidden = isHidden
        default:
            break
        }
    }
}
