//
//  ContactsScenesRouterCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit
import MapKit
import Contacts

protocol ContactsScenesRouterCapable {
    var navigationController: UINavigationController { get set }
    func showDetails(ofContact: Contact)
    func showAddContact(contact: CNContact)
    func openMailSheet(email: String)
    func startPhoneCall(number: String)
    func openMaps(onItem: MKMapItem, withOptions: [String : Any]?)
}
