//
//  MainCoordinator.swift
//  WhatsAppAttachments
//
//  Created by NoBroker on 09/05/21.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(nav: UINavigationController) {
        self.navigationController = nav
    }

    func start() {
        let masterViewController = ViewController.instantiate()
        masterViewController.mainCoodinator = self
        navigationController.pushViewController(masterViewController, animated: true)
    }

    deinit {
        print("removed cordinator")
    }
}
