//
//  Coordinator.swift
//  WhatsAppAttachments
//
//  Created by NoBroker on 09/05/21.
//

import UIKit

protocol Coordinator: AnyObject {
    var children: [Coordinator] { get set}
    var navigationController: UINavigationController { get set }

    func start()
}
