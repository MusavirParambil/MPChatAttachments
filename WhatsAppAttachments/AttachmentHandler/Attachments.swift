//
//  AttachmentTypes.swift
//  WhatsAppAttachments
//
//  Created by NoBroker on 09/05/21.
//

import UIKit

enum Attachments: String, CaseIterable {
    case camera
    case gallery
    case document
    case location
    case contact

    var title: String {
        switch self {
        case .camera:
            return "Camera"
        case .gallery:
            return "Photos & Video Library"
        case .document:
            return "Document"
        case .location:
            return "Location"
        case .contact:
            return "Contact"
        }
    }

    var icon: String? {
        switch self {
        case .document:
            return "ic_attachment_document"
        case .camera:
            return "ic_attachment_camera"
        case .gallery:
            return "ic_attachment_galery"
        case .location:
            return "ic_attachment_location"
        case .contact:
            return "ic_attachment_contact"
        }
    }

    var style: CATextLayerAlignmentMode? {
        return .left
    }
}

class AttachmentHandler {
    static func openAttachment(from controller: UIViewController, attachementHandler: @escaping (_ attachment: Attachments) -> Void) {
        let attchments = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Attachments.allCases.forEach({ attachment in
            let actionItem = UIAlertAction(title: attachment.title, style: .default) { _ in
                attachementHandler(attachment)
            }

            if let icon = attachment.icon {
                actionItem.setValue(UIImage(named: icon), forKey: "image")
            }

            if let fontStyle = attachment.style {
                actionItem.setValue(fontStyle, forKey: "titleTextAlignment")
            }

            attchments.addAction(actionItem)
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        attchments.addAction(cancel)
        attchments.view.tintColor = .darkGray
        controller.present(attchments, animated: true, completion: nil)
    }
}
