//
//  Character.swift
//  SwiftConcurrency
//
//  Created by Koombea on 10/25/21.
//

import UIKit

struct Character: Codable {
    
    var name: String?
    var imageURL: String?
    
    enum CharacterKeys: String, CodingKey {
        case name
        case imageURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CharacterKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CharacterKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(name, forKey: .imageURL)
    }
}
