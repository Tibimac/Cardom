//
//  ContactDetailsViewCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation
import ContactsUI

protocol ContactDetailsViewCapable {
    var router: ContactsScenesRouterCapable? { get set }
    var interactor: ContactDetailsInteractorCapable? { get set }
    func display(viewModel: ContactDetailsTableViewController.ViewModel)
    func displayAddContact(contact: CNContact)
}
