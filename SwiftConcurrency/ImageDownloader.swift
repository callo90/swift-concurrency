//
//  Error.swift
//  SwiftConcurrency
//
//  Created by Koombea on 10/25/21.
//

import UIKit

struct Model: Codable {
    var imageURL: URL
}

struct ModelWrapper {
    var model: Model
    var image: UIImage
}

enum APIErrors: Error {
    case requestError
    case imageRequestError
}

struct Downloader {
    
    func fetchData(from url: URL, withCompletion completion: @escaping (Result<ModelWrapper, Error>) -> Void) -> Void {
        
        let firstTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                // 😱 DID NOT RETURN!
            }
            
            guard let data = data else {
                completion(.failure(APIErrors.requestError))
                return
            }
            
            guard let model = try? JSONDecoder().decode(Model.self, from: data) else {
                // 😱 DID NOT CALL COMPLETION HANDLER!
                return
            }
            
            let imageUrl = model.imageURL
            let secondTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                
                // 😱 PYRAMID OF DOOM STARTING TO FORM!
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIErrors.imageRequestError))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    // 😱 DID NOT CALL COMPLETION HANDLER!
                    return
                }
                
                let modelWrapper = ModelWrapper(model: model, image: image)
                completion(.success(modelWrapper))
            }
            
            secondTask.resume()
        }
        
        firstTask.resume()
    }
}
