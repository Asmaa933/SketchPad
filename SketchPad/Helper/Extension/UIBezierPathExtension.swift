//
//  UIBezierPathExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

extension UIBezierPath {
    //check if path has point after increase width
    func hasPoint(_ point: CGPoint, lineWidth: CGFloat) -> Bool {
        guard let tapTargetPath = CGPath(__byStroking: self.cgPath,
                transform: nil,
                lineWidth: CGFloat(fmaxf(35.0, Float(lineWidth))),
                lineCap: self.lineCapStyle,
                lineJoin: self.lineJoinStyle,
                miterLimit: self.miterLimit) else { return false }
        let newPath = UIBezierPath(cgPath: tapTargetPath)
        return newPath.contains(point)
    }
}
