//
//  DateExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 12/06/2022.
//

import Foundation


extension Date {
    func toString(format : DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
