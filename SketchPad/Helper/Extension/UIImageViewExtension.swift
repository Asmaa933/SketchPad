//
//  UIImageViewExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//
import UIKit

extension UIImageView {
    
    func drawLinesOnImage(_ lines: [LineInfo]) {
        guard !lines.isEmpty else { return }
        let size = calculateSize()
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image?.draw(in: CGRect(origin: .zero, size: size))
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
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        } else {
            debugPrint("DrawContext is nil")
        }
    }
    
    private func calculateSize() -> CGSize {
        let viewSize = frame.size
        let imageSize = image?.size ?? .zero
        let xScale = imageSize.width > 0 ? viewSize.width / imageSize.width : 1
        let yScale = imageSize.height > 0 ? viewSize.height / imageSize.height : 1
        let scale = (xScale > 0 && yScale > 0) ? max (xScale, yScale) : 1
        return CGSize (width: scale * imageSize.width, height: scale * imageSize.height)
    }
}
