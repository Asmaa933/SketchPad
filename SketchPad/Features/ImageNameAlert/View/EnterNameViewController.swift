//
//  EnterNameViewController.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

class EnterNameViewController: UIViewController {

    private var viewModel: EnterNameViewModelProtocol
    
    init(viewModel: EnterNameViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleViewDidLoad()
    }
    
    
}

fileprivate extension EnterNameViewController {
}
