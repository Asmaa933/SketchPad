//
//  UIImageExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

extension UIImage {
    
    func drawLinesOnImage(_ lines: [LineInfo]) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        draw(in: CGRect(origin: .zero, size: size))
        if let drawContext = UIGraphicsGetCurrentContext() {
            for line in lines {
                drawContext.addPath(line.path.cgPath)
                drawContext.setLineWidth(line.lineWidth)
                if line.isLine {
                    drawContext.setStrokeColor(line.lineColor.cgColor)
                    drawContext.strokePath()
                } else {
                    drawContext.setFillColor(line.lineColor.cgColor)
                    drawContext.fillPath()
                }
            }
            let sketchedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return sketchedImage ?? self
        } else {
            debugPrint("DrawContext is nil")
            return self
        }
    }
}
