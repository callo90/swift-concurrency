//
//  CharactersStore.swift
//  SwiftConcurrency
//
//  Created by Koombea on 10/25/21.
//

import UIKit

struct CharactersStore {
        
    static func fetchCharacters() async throws -> [Character] {
        let url = URL(string: "https://593cdf8fb56f410011e7e7a9.mockapi.io/fighters")!
        let (data, response) = try await URLSession.shared.data(from: url)
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard statusCode >= 200 && statusCode < 300 else { throw APIErrors.requestError }
        let characters = try JSONDecoder().decode([Character].self, from: data)
        return characters
    }
}
