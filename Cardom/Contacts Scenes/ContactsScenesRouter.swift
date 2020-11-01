//
//  ContactsScenesRouter.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 31/10/2020.
//

import UIKit

class ContactsScenesRouter: ContactsScenesRouterCapable {
    
    static var sceneDelegate: SceneDelegate {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { fatalError("could not get scene delegate ") }
        return sceneDelegate
    }
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetails(ofContact contact: ContactViewModel) {
        var contactDetailsViewController: ContactDetailsViewCapable = ContactDetailsTableViewController(forContact: contact)
        ContactDetailsSceneBuilder.buildScene(arroundView: &contactDetailsViewController)
        
        navigationController.pushViewController(contactDetailsViewController as! UIViewController, animated: true)
    }
    
}
