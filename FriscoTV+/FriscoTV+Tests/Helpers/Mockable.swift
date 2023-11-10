//
//  Mockable.swift
//  FriscoTV+Tests
//
//  Created by Blaine Beltran on 11/10/23.
//

import Foundation

protocol Mockable: AnyObject {
    /// The resource group where the file lives that we want to test
    var bundle: Bundle { get }
    
    /// The function used to load our json file from a bundle and turn it into the swift object we want
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T
}

extension Mockable {
    
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load mock json data")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let object = try decoder.decode(type, from: data)
            return object
        } catch {
            fatalError("Failed to decode mock json data for filename: \(filename) to object \(type). Error: \(error)")
        }
    }
}

