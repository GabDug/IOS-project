//
//  NameUtils.swift
//  Events
//
//  Created by user187551 on 4/6/21.
//

import Foundation

class NameUtils {
    static func initialsFromName(name: String) -> String {
        
        var initials = ""
        
        // Words to ignore
        let ignore = ["of", "a", "for", "an", "the"]

        // Iterating through the words in the name
        for word in name.split(separator: " ") {
            if (!ignore.contains(word.lowercased())) {
                initials = initials + String(word.first!)
            }
        }

        // Return uppercased initials string
        return initials.uppercased()
    }
}
