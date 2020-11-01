//
//  ContactsListTableViewController.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit

class ContactsListTableViewController: UITableViewController, ContactsListViewCapable {

    var router: ContactsScenesRouterCapable?
    var interactor: ContactsListInteractorCapable?
    
    var dataSource: [ContactViewModel]?

    override func viewDidLoad() {
        interactor?.getContacts()
    }
    
    func displayContacts(contacts: [ContactViewModel]) {
        dataSource = contacts
        tableView.reloadData()
    }
    
    func displayLoadingError(title: String, message: String, button: String) {
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: button, style: .default, handler: nil)
        alertCtrl.addAction(alertAction)
        DispatchQueue.main.async {
            self.present(alertCtrl, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        router.
    }
}

