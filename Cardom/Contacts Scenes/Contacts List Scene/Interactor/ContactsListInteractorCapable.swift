//
//  ContactsListInteractorCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol ContactsListInteractorCapable {
    var presenter: ContactsListPresenterCapable? { get set }
    func getFirstContacts()
    func getNextContacts()
}
