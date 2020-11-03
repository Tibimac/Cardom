//
//  ContactDetailsInfoViewModel.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 02/11/2020.
//

import Foundation

struct ContactDetailsInfoViewModel {
    let label: String
    let value: String
    let selectionHandler: (ContactsScenesRouterCapable) -> Void
}
