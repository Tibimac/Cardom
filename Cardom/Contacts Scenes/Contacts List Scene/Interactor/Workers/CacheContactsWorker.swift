//
//  CacheContactsWorker.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

class CacheContactsWorker: CacheContactsWorkerCapable {
   
    private let userDefaults = UserDefaults.standard
    private let contactsListKey = "contacts-list"
    
    func save(by savePolicy: SavePolicy, withContacts contacts: [Contact]) {
        switch savePolicy {
        case .appending:
        /* As we need to append given contacts to already saved ones,
         * we first need to retrieved saved contacts to merged them
         * with new ones. */
            let cachedContactsResult = load()
            switch cachedContactsResult {
            case .success(var existingContacts):
                existingContacts += contacts
                encodeAndSave(contacts: existingContacts)
            case .failure(_):
                encodeAndSave(contacts: contacts)
            }
        case .replacing:
            encodeAndSave(contacts: contacts)
        }
    }
    
    func load() -> Result<[Contact], CacheContactsWorkerError> {
        if let contacts = decodedContacts() {
            return .success(contacts)
        } else {
            return .failure(CacheContactsWorkerError.noResult)
        }
    }
    
    private static let jsonEncoder = JSONEncoder()
    private static let jsonDecoder = JSONDecoder()
    
    private func encodeAndSave(contacts: [Contact]) {
        guard let encodedContacts = try? CacheContactsWorker.jsonEncoder.encode(contacts) else { return }
        userDefaults.set(encodedContacts, forKey: contactsListKey)
    }
    
    private func decodedContacts() -> [Contact]? {
        guard let encodedContacts = userDefaults.data(forKey: contactsListKey) else { return nil }
        guard let decodedContacts = try? CacheContactsWorker.jsonDecoder.decode([Contact].self, from: encodedContacts) else { return nil }
        return decodedContacts
    }
    
}
