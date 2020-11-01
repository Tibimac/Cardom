//
//  ContactsScenesRouterCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit

protocol ContactsScenesRouterCapable {
    var navigationController: UINavigationController { get set }
    func showDetails(ofContact: ContactViewModel)
    func openMailSheet(email: String, from: UIViewController?)
    func startPhoneCall(number: String)
}
