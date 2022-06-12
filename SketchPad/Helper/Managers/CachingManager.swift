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
    
    func saveIntoCache(item: Sketch, _ completion: @escaping((Result<Bool,Error>)-> Void)) {
        guard let context = getCoreDataObject(),
              let _ = mapToCoreDataModel(item: item) else { return }
        do {
            try context.save()
            completion(.success(true))
        } catch (let error) {
            debugPrint("error in saving >> \(error)")
            completion(.failure(error))
        }
    }
    
    func getSketchesFromCache() -> Result<[CachedSketch],AppError> {
        guard let context = getCoreDataObject() else { return .failure(.generalError) }
        do{
            let sketches = try context.fetch(CachedSketch.fetchRequest())
            return .success(sketches)
        }
        catch (let error){
            debugPrint("error in get sketches >> \(error.localizedDescription)")
            return .failure(.generalError)
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
        cachedSketch.id = item.id
        cachedSketch.imageData = item.imageData
        cachedSketch.imageName = item.imageName
        cachedSketch.date = item.date
        cachedSketch.time = item.time
        cachedSketch.createdAt = item.createdAt
        return cachedSketch
    }
}
