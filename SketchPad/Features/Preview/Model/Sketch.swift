//
//  Sketch.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import Foundation

struct Sketch {
    
    let id: UUID?
    let imageData: Data?
    let createdAt: Date?
    var imageName: String?
    
    init(imageData: Data?, createdAt: Date?, imageName: String? = "", id: UUID? = UUID()) {
        self.imageData = imageData
        self.createdAt = createdAt
        self.imageName = imageName
        self.id = id
    }
}
