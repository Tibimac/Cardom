//
//  ContactsListSceneBuilder.swift
//  Cardom
//
//  Created by Thibault Le Cornec on 01/11/2020.
//

import UIKit

class ContactsListSceneBuilder {

    class func buildScene(arroundView view: inout ContactsListViewCapable) {
        
        // MARK: Initialise components.
        let presenter = ContactsListPresenter()
        let interactor = ContactsListInteractor(withGetWorker: GetContactsWorker(), cacheWorker: CacheContactsWorker())
        let navigationController = ContactsScenesRouter.sceneDelegate.rootNavigationController
        let router = ContactsScenesRouter(navigationController: navigationController)
        
        // MARK: Link VIP components.
        view.router = router
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
    }
}
