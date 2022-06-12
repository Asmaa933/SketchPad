//
//  HistoryDataProvider.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import Foundation

typealias SketchResult = Result<[Sketch], Error>

protocol HistoryDataProviderProtocol {
    func getHistory(_ completion: @escaping (SketchResult) -> Void)
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
            let sketches = cachedSketched.compactMap(mapResultToSketch(_:))
            completion(.success(sketches))
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
}

fileprivate extension HistoryDataProvider {
    func mapResultToSketch(_ result: CachedSketch) -> Sketch {
        return Sketch(imageData: result.imageData,
                      createdAt: result.createdAt,
                      imageName: result.imageName,
                      id: result.id)
    }
}


