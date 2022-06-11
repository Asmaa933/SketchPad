//
//  EnterNameAlert.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import UIKit

enum NameAlertAction {
    case save(imageName: String)
    case cancel
}

class EnterNameAlert: UIView {

    @IBOutlet private weak var nameTextField: UITextField!
    
    var callBack: ((NameAlertAction) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addShadow()
    }
    
    @IBAction private func saveAction(_ sender: UIButton) {
        nameTextField.resignFirstResponder()
        callBack?(.save(imageName: nameTextField.text ?? ""))
    }
    
    @IBAction private func cancelAction(_ sender: UIButton) {
        callBack?(.cancel)
    }

}
