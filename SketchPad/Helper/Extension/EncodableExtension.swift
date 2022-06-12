//
//  EncodableExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import Foundation

extension Encodable {
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self), options: .allowFragments)) as? [String: Any] ?? [:]
    }
}
