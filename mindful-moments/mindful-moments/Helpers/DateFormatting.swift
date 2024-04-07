//
//  DateFormatting.swift
//  mindful-moments
//
//  Created by Nicholas LoPilato on 3/20/24.
//

import Foundation

class DateFormatting {
    static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter
    }()
}
