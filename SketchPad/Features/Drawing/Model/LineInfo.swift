//
//  LineInfo.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import Foundation
import UIKit.UIBezierPath
import UIKit.UIColor

struct LineInfo {
    let lineColor: UIColor
    let lineWidth: CGFloat
    var path: UIBezierPath
    var pointsCount: Int
    var isLine: Bool = false
}
