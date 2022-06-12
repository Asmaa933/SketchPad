//
//  HistoryTableViewCell.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var savedImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var imageNameLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.addShadow()
    }
}
