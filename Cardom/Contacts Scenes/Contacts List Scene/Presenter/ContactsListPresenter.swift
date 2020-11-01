//
//  ContactsListPresenter.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit

class ContactsListPresenter: ContactsListPresenterCapable {
    
    var view: ContactsListViewCapable?

    func prepareDisplay(ofContacts contacts: [Contact]) {
        let contactsViewModel = contacts.map{ ContactViewModel(contact: $0) }
        view?.displayContacts(contacts: contactsViewModel)
    }
    
    func loadEnded() {
        view?.loadEnded()
    }
    
    func displayLoadingError() {
        let title = "Erreur"
        let message = "Une erreur est survenue au chargement des contacts."
        let button = "OK"
        view?.displayLoadingError(title: title, message: message, button: button)
    }
    
}
