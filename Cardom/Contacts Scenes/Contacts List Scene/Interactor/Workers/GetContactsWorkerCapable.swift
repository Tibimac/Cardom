//
//  GetContactsWorkerCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol GetContactsWorkerCapable {
    func get(completion: @escaping (Result<[Contact], GetContactsWorkerError>) -> Void)
}

enum GetContactsWorkerError: Error {
    case noResult
}
