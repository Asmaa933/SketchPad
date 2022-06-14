//
//  FakeHistoryDataProvider.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import Foundation

class FakeHistoryDataProvider: HistoryDataProviderProtocol {
    
    var sketches: [Sketch]
    var shouldReturnError: Bool
    var error: AppError?
    
    internal init(sketches: [Sketch], shouldReturnError: Bool, error: AppError? = nil) {
        self.sketches = sketches
        self.shouldReturnError = shouldReturnError
        self.error = error
    }
    
    func getHistory(_ completion: @escaping (SketchResult) -> Void) {
        if shouldReturnError {
            completion(.failure(error!))
            return
        }
        let groupedSketches = mapSketchesToGrouped(sketches)
        completion(.success(groupedSketches))
       
    }
    
     func deleteSketchFromCaching(id: UUID, _ completion: @escaping (CallBackResult) -> Void) {
        if shouldReturnError {
            completion(.failure(error!))
            return
        }
        sketches = sketches.filter { $0.id != id }
        completion(.success(true))
    }
    
    func searchForSketches(by imageName: String, _ completion: @escaping (SketchResult) -> Void) {
        if shouldReturnError {
            completion(.failure(error!))
            return
        }
        let sketches = sketches.filter { $0.imageName == imageName}
        let groupedSketches = mapSketchesToGrouped(sketches)
        completion(.success(groupedSketches))
    }
    
    private func mapSketchesToGrouped(_ sketches: [Sketch]) -> [HistorySketchSection] {
        let sortedArray = sketches.sorted {($0.createdAt ?? Date()) > ($1.createdAt ?? Date())}
        let grouped = Dictionary(grouping: sortedArray, by: { $0.date ?? "" })
        let sortedDates = grouped.keys.sorted(by: <)
        let sections = sortedDates.map { HistorySketchSection(date: $0, SectionData: grouped[$0])}
        return sections
    }
}
