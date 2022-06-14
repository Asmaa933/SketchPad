//
//  Sketch.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import Foundation

struct Sketch: Codable {
    
    let id: UUID?
    var imageData: Data?
    var imageName: String?
    let date: String?
    let time: String?
    let createdAt: Date?
    
    
     init(imageData: Data?, imageName: String? = nil) {
        self.id = UUID()
        self.imageData = imageData
        self.date = Date().toString(format: .dateFormat)
        self.time = Date().toString(format: .timeFormat)
        self.imageName = imageName
        self.createdAt = Date()
    }
    
     init(id: UUID?, imageData: Data?, imageName: String? , date: String?, time: String?, createdAt: Date?) {
        self.id = id
        self.imageData = imageData
        self.imageName = imageName
        self.date = date
        self.time = time
        self.createdAt = createdAt
    }
}

struct DisplayedSketch {
    let imageName: String
    let imageData: Data
    let time: String
    let id: UUID
}

extension Sketch {
    var toDisplay: DisplayedSketch? {
        guard let imageName = imageName,
              let imageData = imageData,
              let time = time,
              let id = id else { return nil }
        
        return DisplayedSketch(imageName: imageName,
                               imageData: imageData,
                               time: time,
                               id: id)
    }
}
