//
//  ContactsListTableViewController.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit
import Reusable

class ContactsListTableViewController: UITableViewController, ContactsListViewCapable {

    // MARK: - ContactsListViewCapable
    
    var router: ContactsScenesRouterCapable?
    var interactor: ContactsListInteractorCapable?
    
    // MARK: - Properties
    
    private var dataSource: [ContactViewModel] = []
    
    // MARK: - Views
    
    private let loader: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        title = "Contacts"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(cellType: ContactListTableViewCell.self)
        tableView.tableFooterView = loader
        loader.startAnimating()
        interactor?.getFirstContacts()
    }
    
    func loadEnded() {
        DispatchQueue.main.async { self.loader.stopAnimating() }
    }
    
    func displayContacts(contacts: [ContactViewModel]) {
        DispatchQueue.main.async { self.loader.stopAnimating() }
        guard contacts != dataSource else { return }
        dataSource = contacts
        DispatchQueue.main.async { self.tableView.reloadData() }
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
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row <= dataSource.count else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(for: indexPath) as ContactListTableViewCell
        let viewModel = dataSource[indexPath.row]
        cell.viewModel = viewModel
        cell.handleEmailButton = { [weak self] in
            self?.router?.openMailSheet(email: viewModel.email, from: self)
        }
        cell.handlePhoneButton = { [weak self] in
            self?.router?.startPhoneCall(number: viewModel.phone)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < dataSource.count, indexPath.row == dataSource.count - 1, !loader.isAnimating else { return }
        loader.startAnimating()
        self.interactor?.getNextContacts()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row <= dataSource.count else { return }
        let selectedContact = dataSource[indexPath.row]
        router?.showDetails(ofContact: selectedContact)
    }
    
}

