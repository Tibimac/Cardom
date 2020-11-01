//
//  ContactsListInteractor.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import Foundation

class ContactsListInteractor: ContactsListInteractorCapable {
   
    var presenter: ContactsListPresenterCapable?
    
    var getWorker: GetContactsWorkerCapable
    var cacheWorker: CacheContactsWorkerCapable
    
    init(withGetWorker getWorker: GetContactsWorkerCapable, cacheWorker: CacheContactsWorkerCapable) {
        self.getWorker = getWorker
        self.cacheWorker = cacheWorker
    }
    
    func getContacts() {
        getWorker.get { [weak self] result in
            guard let self = self else { return }
            // Result of load from API
            switch result {
            case .success(let contacts):
                self.cacheWorker.save(by: .appending, withContacts: contacts)
                self.presenter?.prepareDisplay(ofContacts: contacts)
            case .failure(let error):
                switch error {
                case .noResult:
                    let cachedContacts = self.cacheWorker.load()
                    // Result of load from cache
                    switch cachedContacts {
                    case .success(let contacts):
                        self.presenter?.prepareDisplay(ofContacts: contacts)
                    case .failure(_):
                        self.presenter?.displayLoadingError()
                    }
                }
            }
        }
    }
}
