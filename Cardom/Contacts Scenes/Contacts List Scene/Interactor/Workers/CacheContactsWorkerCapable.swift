//
//  CacheContactsWorkerCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol CacheContactsWorkerCapable {
    func save(by: SavePolicy, withContacts: [Contact])
    func load() -> Result<[Contact], CacheContactsWorkerError>
}

enum SavePolicy {
    case appending
    case replacing
}

enum CacheContactsWorkerError: Error {
    case noResult
}
