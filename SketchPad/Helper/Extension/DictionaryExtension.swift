//
//  DictionaryExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import Foundation

extension Dictionary {
    func decodeJSON<T: Decodable>(mappingClass: T.Type) -> T? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let decodedObject = try? JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } else {
            return nil
        }
    }
}
