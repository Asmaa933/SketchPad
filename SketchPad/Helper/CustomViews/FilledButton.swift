//
//  FilledButton.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class FilledButton: UIButton {
    
    var tapped: (() -> Void)?
    var title: TitleConstant? {
        didSet {
            setTitle(title?.rawValue, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
}

fileprivate extension FilledButton {
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor.color(for: .tintColor)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        cornerRadius = 8
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        tapped?()
    }
}
