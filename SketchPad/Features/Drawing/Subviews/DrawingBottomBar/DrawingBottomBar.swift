//
//  DrawingBottomBar.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

enum BottomBarAction {
    case slider(newValue: CGFloat)
    case colorPicker
}

class DrawingBottomBar: UIView {

    @IBOutlet private weak var thicknessSlider: UISlider!
    @IBOutlet private weak var colorPickerButton: UIButton!
    
    var callBack: ((BottomBarAction) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }

    @IBAction private func colorPickerButtonAction(_ sender: UIButton) {
        callBack?(.colorPicker)
    }
    
    @IBAction private func thicknessSliderValueChanged(_ sender: UISlider) {
        let step: Float = 5.0
        let roundedValue = round(sender.value / step) * step
        thicknessSlider.setValue(roundedValue, animated: false)
        callBack?(.slider(newValue: CGFloat(Int(roundedValue))))
    }
    
    func colorChanged(to color: UIColor) {
        colorPickerButton.backgroundColor = color
    }
}
