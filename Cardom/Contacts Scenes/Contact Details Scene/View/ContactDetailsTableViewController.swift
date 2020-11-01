//
//  ContactDetailsTableViewController.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController, ContactDetailsViewCapable {
    
    var router: ContactsScenesRouterCapable?
    var interactor: ContactDetailsInteractorCapable?
    
    let contact: ContactViewModel
    
    init(forContact contact: ContactViewModel) {
        self.contact = contact
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
