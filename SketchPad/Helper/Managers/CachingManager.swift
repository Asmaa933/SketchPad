//
//  CachingManager.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit
import CoreData

class CachingManager {
    
    static let shared = CachingManager()
    
    private init() {}
    
    func saveIntoCoreData(item: Sketch) {
        guard let context = getCoreDataObject(),
              let _ = mapToCoreDataModel(item: item) else { return }
        do {
            try context.save()
            debugPrint("Saved.")
        } catch (let error) {
            debugPrint("error in saving >> \(error)")
        }
    }
}

fileprivate extension CachingManager {
    
    func getCoreDataObject() -> NSManagedObjectContext? {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.persistentContainer.viewContext
    }
    
    func mapToCoreDataModel(item: Sketch) -> CachedSketch? {
        guard let context = getCoreDataObject() else { return nil }
        let cachedSketch = CachedSketch(context: context)
        cachedSketch.imageData = item.imageData
        cachedSketch.imageName = item.imageName
        cachedSketch.createdAt = item.createdAt
        return cachedSketch
    }
}
