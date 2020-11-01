//
//  ContactsListPresenterCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol ContactsListPresenterCapable {
    var view: ContactsListViewCapable? { get set }
    func prepareDisplay(ofContacts: [Contact])
    func displayLoadingError()
}
