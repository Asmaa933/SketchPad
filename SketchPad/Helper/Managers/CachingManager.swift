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
    
    func saveIntoCache(item: Sketch) -> CallBackResult {
        guard let context = getCoreDataObject(),
              let _ = mapToCoreDataModel(item: item) else { return .failure(.generalError)}
        do {
            try context.save()
            return .success(true)
        } catch (let error) {
            debugPrint("error in saving >> \(error)")
            return .failure(.generalError)
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
    
    @discardableResult
    func deleteFromCache(id: UUID) -> CallBackResult {
        guard let context = getCoreDataObject(),
              let mappedSketch = getItemFromCacheByID(id)
        else { return .failure(.generalError) }
        context.delete(mappedSketch)
        do{
            try context.save()
            return .success(true)
        }
        catch{
            debugPrint("error in delete data")
            return .failure(.generalError)
        }
    }
    
    func searchForSketch(by imageName: String) -> Result<[CachedSketch],AppError> {
        let predicate = NSPredicate(format: "imageName contains[c] %@", imageName)
        let sketches = fetchFromCache(predicate: predicate)
        if let sketches = sketches {
            return .success(sketches)
        } else {
            return .failure(.generalError)
        }
    }
    
    func updateSketch(_ sketch: Sketch) -> CallBackResult  {
        guard let sketchID = sketch.id else { return .failure(.generalError)}
        deleteFromCache(id: sketchID)
        return saveIntoCache(item: sketch)
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
    
    func fetchFromCache(predicate: NSPredicate) -> [CachedSketch]? {
        guard let context = getCoreDataObject() else { return nil }
        guard let entityName = CachedSketch.entity().name else { return nil }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        do {
            let sketches =  try context.fetch(request) as? [CachedSketch]
            return sketches
        } catch(let error) {
            debugPrint("Error getting item by Id >> \(error.localizedDescription )")
            return nil
        }
    }
    
    func getItemFromCacheByID(_ id: UUID) -> CachedSketch? {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        return fetchFromCache(predicate: predicate)?.first
    }
}

