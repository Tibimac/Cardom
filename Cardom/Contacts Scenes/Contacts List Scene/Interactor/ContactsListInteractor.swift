//
//  ContactsListInteractor.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import Foundation

class ContactsListInteractor: ContactsListInteractorCapable {
   
    var presenter: ContactsListPresenterCapable?
    
    private var loadedContacts: [Contact] = []
    private var lastAPIFetchSucceeded: Bool = false
    private var getWorker: GetContactsWorkerCapable
    private var cacheWorker: CacheContactsWorkerCapable
    
    init(withGetWorker getWorker: GetContactsWorkerCapable, cacheWorker: CacheContactsWorkerCapable) {
        self.getWorker = getWorker
        self.cacheWorker = cacheWorker
    }
    
    func getFirstContacts() {
        getWorker.get { [weak self] result in
            guard let self = self else { return }
            
            // Result of load from API
            switch result {
            case .success(let contacts):
                self.lastAPIFetchSucceeded = true
                self.loadedContacts = contacts
                self.cacheWorker.save(by: .replacing, withContacts: contacts)
                self.presenter?.prepareDisplay(ofContacts: contacts)
            case .failure(let error):
                self.lastAPIFetchSucceeded = false
                switch error {
                case .noResult:
                    let cachedContactsResult = self.cacheWorker.load()
                    // Result of load from cache
                    switch cachedContactsResult {
                    case .success(let cachedContacts):
                        self.loadedContacts = cachedContacts
                        self.presenter?.prepareDisplay(ofContacts: cachedContacts)
                    case .failure(_):
                        self.presenter?.displayLoadingError()
                    }
                }
            }
        }
    }
    
    func getNextContacts() {
        getWorker.get { [weak self] result in
            guard let self = self else { return }
            // Result of load from API
            switch result {
            case .success(let contacts):
                self.lastAPIFetchSucceeded = true
                self.loadedContacts.append(contentsOf: contacts)
                self.cacheWorker.save(by: .appending, withContacts: contacts)
                self.presenter?.prepareDisplay(ofContacts: self.loadedContacts)
            case .failure(_):
                self.presenter?.loadEnded()
                return
            }
        }
    }
    
    func contact(at index: Int) -> Contact? {
        guard index < loadedContacts.count else { return nil }
        return loadedContacts[index]
    }
}
