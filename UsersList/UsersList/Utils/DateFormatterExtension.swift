//
//  DateFormatterExtension.swift
//  UsersList
//
//  Created by Lucian Cristea on 15.08.2024.
//

import Foundation

extension DateFormatter {
    
    private enum DateFormat: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    }
    
    private static func iso8601DateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.iso8601.rawValue
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    static func time(from dateString: String, outputFormat: String = "HH:mm") -> String? {
        let dateFormatter = iso8601DateFormatter()
        
        guard let date = dateFormatter.date(from: dateString) else {
            print("Error: Could not parse date string '\(dateString)' with format '\(DateFormat.iso8601.rawValue)'")
            return nil
        }
        dateFormatter.dateFormat = outputFormat
        
        return dateFormatter.string(from: date)
    }
}
