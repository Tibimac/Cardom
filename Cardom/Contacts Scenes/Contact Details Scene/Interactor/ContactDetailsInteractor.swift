//
//  ContactDetailsInteractor.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import Foundation

class ContactDetailsInteractor: ContactDetailsInteractorCapable {
    
    var presenter: ContactDetailsPresenterCapable?
    
    private let contact: Contact
    
    init(contact: Contact) {
        self.contact = contact
    }
    
    func getContactDetailsViewModel() {
        presenter?.prepareDisplay(ofContact: contact)
    }
    
    func addToContacts() {
        presenter?.prepareToAdd(contact: contact)
    }
}
