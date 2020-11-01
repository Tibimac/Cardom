//
//  ContactDetailsInteractorCapable.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import Foundation

protocol ContactDetailsInteractorCapable {
    var presenter: ContactDetailsPresenterCapable? { get set }
}
