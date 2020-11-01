//
//  ContactsListViewCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol ContactsListViewCapable {
    var router: ContactsScenesRouterCapable? { get set }
    var interactor: ContactsListInteractorCapable? { get set }
    func displayContacts(contacts: [ContactViewModel])
    func displayLoadingError(title: String, message: String, button: String)
}
