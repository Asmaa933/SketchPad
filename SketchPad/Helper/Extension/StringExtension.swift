//
//  StringExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 14/06/2022.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let userFormatter = DateFormatter()
        userFormatter.dateFormat = "yyyy-MM-dd HH:mm a"
        let dateFromString = userFormatter.date(from: self)
        return dateFromString
    }
}
