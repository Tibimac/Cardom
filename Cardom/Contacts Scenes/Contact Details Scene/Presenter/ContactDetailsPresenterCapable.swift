//
//  ContactDetailsPresenterCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol ContactDetailsPresenterCapable {
    var view: ContactDetailsViewCapable? { get set }
    func prepareDisplay(ofContact: Contact)
    func prepareToAdd(contact: Contact)
}
