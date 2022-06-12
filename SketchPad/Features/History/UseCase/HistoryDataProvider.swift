//
//  HistoryDataProvider.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import Foundation

typealias SketchResult = Result<([HistorySketchSection], [Sketch]), Error>

protocol HistoryDataProviderProtocol {
    func getHistory(_ completion: @escaping (SketchResult) -> Void)
    func deleteSketchFromCaching(id: UUID, _ completion: @escaping (CallBackResult) -> Void)
}

class HistoryDataProvider: HistoryDataProviderProtocol {
    
    private var cachingManager: CachingManager
    init(cachingManager: CachingManager = .shared) {
        self.cachingManager = cachingManager
    }
    
    func getHistory(_ completion: @escaping (SketchResult) -> Void) {
        let result = cachingManager.getSketchesFromCache()
        switch result {
        case .success(let cachedSketched):
            let sketches = cachedSketched
                .compactMap(mapResultToSketch(_:))
            let sections = mapSketchesToGrouped(sketches)
            completion(.success((sections, sketches)))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    func deleteSketchFromCaching(id: UUID, _ completion: @escaping (CallBackResult) -> Void) {
         let result = cachingManager.deleteFromCache(id: id)
        completion(result)
    }
}

fileprivate extension HistoryDataProvider {
    func mapResultToSketch(_ result: CachedSketch) -> Sketch {
        return Sketch(id: result.id,
                      imageData: result.imageData,
                      imageName: result.imageName,
                      date: result.date,
                      time: result.time,
                      createdAt: result.createdAt)
    }
    
    func mapSketchesToGrouped(_ sketches: [Sketch]) -> [HistorySketchSection] {
        let sortedArray = sketches.sorted {($0.createdAt ?? Date()) > ($1.createdAt ?? Date())}
        let grouped = Dictionary(grouping: sortedArray, by: { $0.date ?? "" })
        let sortedDates = grouped.keys.sorted(by: >)
        let sections = sortedDates.map { HistorySketchSection(date: $0, SectionData: grouped[$0])}
        return sections
    }
}


