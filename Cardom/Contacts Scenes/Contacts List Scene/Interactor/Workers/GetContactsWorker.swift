//
//  GetContactsWorker.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import Foundation

class GetContactsWorker: GetContactsWorkerCapable {
    
    private static let apiURL = "https://randomuser.me/api/?results=10"
    
    private static let dateFormatter: DateFormatter = {
        $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return $0
    }(DateFormatter())
    
    private static let decoder: JSONDecoder = {
        $0.dateDecodingStrategy = .formatted(dateFormatter)
        return $0
    }(JSONDecoder())
    
    // Protocol compliance
    
    func get(completion: @escaping (Result<[Contact], GetContactsWorkerError>) -> Void) {
        guard let url = URL(string: GetContactsWorker.apiURL) else {
            completion(.failure(GetContactsWorkerError.noResult)); return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(.failure(GetContactsWorkerError.noResult)); return
            }
            do {
                let result = try GetContactsWorker.decoder.decode(ApiResult.self, from: data)
                completion(.success(result.contacts))
            } catch {
                completion(.failure(GetContactsWorkerError.noResult))
            }
        }.resume()
    }
}
