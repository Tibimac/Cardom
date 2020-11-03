//
//  ContactsScenesRouter.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit
import MapKit
import MessageUI
import ContactsUI

class ContactsScenesRouter: NSObject, ContactsScenesRouterCapable {
    
    static var sceneDelegate: SceneDelegate {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { fatalError("could not get scene delegate ") }
        return sceneDelegate
    }
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetails(ofContact contact: Contact) {
        var contactDetailsViewController: ContactDetailsViewCapable = ContactDetailsTableViewController()
        ContactDetailsSceneBuilder.buildScene(forContact: contact, arroundView: &contactDetailsViewController)
        navigationController.pushViewController(contactDetailsViewController as! UIViewController, animated: true)
    }
    
    func showAddContact(contact: CNContact) {
        let addContactViewController = CNContactViewController(forUnknownContact: contact)
        addContactViewController.contactStore = CNContactStore()
        addContactViewController.delegate = self
        self.navigationController.present(addContactViewController, animated: true, completion: nil)
    }
    
    func openMailSheet(email: String) {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([email])
        navigationController.present(mailComposer, animated: true)
    }
    
    func startPhoneCall(number: String) {
        UIApplication.shared.open(URL(string: "tel://\(number)")!, options: [:], completionHandler: nil)
    }
    
    func openMaps(onItem item: MKMapItem, withOptions options: [String : Any]?) {
        item.openInMaps(launchOptions: options)
    }
}

extension ContactsScenesRouter: CNContactViewControllerDelegate {
    
}

extension ContactsScenesRouter: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
