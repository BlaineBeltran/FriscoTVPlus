//
//  Constants.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/7/23.
//

import Foundation

/// Enum that will contain all strings used within the app. (Excluding those returned from APIs)
enum Constants {
    
    enum home {
        static let title = String(localized: "Watch Now", comment: "The title used for the watch now tab")

    }
    
    enum library {
        static let title = String(localized: "Library", comment: "The title used for the library tab")
    }
    
    enum search {
        static let title = String(localized: "Search", comment: "The title used for the search tab")
    }
    
    enum profile {
        static let title = String(localized: "Profile", comment: "The title used for the profile bar ")
    }
}
