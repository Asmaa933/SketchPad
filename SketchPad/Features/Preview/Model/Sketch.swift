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
    var imageName: String?
    let date: String?
    let time: String?
    let createdAt: Date?
    
    
    internal init(imageData: Data?, imageName: String? = nil) {
        self.id = UUID()
        self.imageData = imageData
        self.date = Date().toString(format: .dateFormat)
        self.time = Date().toString(format: .timeFormat)
        self.imageName = imageName
        self.createdAt = Date()
    }
    
    internal init(id: UUID?, imageData: Data?, imageName: String? , date: String?, time: String?, createdAt: Date?) {
        self.id = id
        self.imageData = imageData
        self.imageName = imageName
        self.date = date
        self.time = time
        self.createdAt = createdAt
    }
  
}
