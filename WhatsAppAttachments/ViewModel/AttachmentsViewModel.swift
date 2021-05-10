//
//  AttachmentsViewModel.swift
//  WhatsAppAttachments
//
//  Created by Musavir on 08/05/21.
//

import UIKit

protocol AttachmentActionDelegate: AnyObject {
    func didFinish()
    func moveMessgeField(height: CGFloat?)
}

final class AttachmentViewModel: NSObject, UINavigationBarDelegate{
    weak var delegate: AttachmentActionDelegate?
    weak var mainCoodinator: MainCoordinator?

    var attachmentHandler: (() -> Void)?
    var dataSource = [String]() {
        didSet {
            self.delegate?.didFinish()
        }
    }

    convenience init(_ delegate: AttachmentActionDelegate) {
        self.init()
        self.delegate = delegate
    }

    func setupMessageTextField(textField: UITextField) {
        textField.delegate = self
        textField.keyboardType = .alphabet
        textField.autocorrectionType = .no
        textField.returnKeyType = .send
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyBoard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func sendMessage(message: String) {
        self.dataSource.append(message)
    }

    func didSelectItem(selected attchemt: Attachments) {
        switch attchemt {
        case .camera:
            break
        case .gallery:
            break
        case .document:
            break
        case .location:
            break
        case .contact:
            break
        }
    }

    // MARK: - Private methods
    private func loadMessageTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.getIdentifier(), for: indexPath) as? MessageTableViewCell {
            cell.messageLabel.text = self.dataSource[indexPath.row]
            cell.messageLabel.textAlignment = indexPath.row % 2 == .zero ? .left : .right
            return cell
        }

        return UITableViewCell()
    }

    @objc private func showKeyBoard(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.delegate?.moveMessgeField(height: keyboardSize.height)
        }
    }

    @objc private func hideKeyBoard(notification: Notification) {
        self.delegate?.moveMessgeField(height: nil)
    }

    deinit {
        print("removed viewModel")
    }
}

// MARK:- TableView DataSouceMethods
extension AttachmentViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return loadMessageTableViewCell(tableView, cellForRowAt: indexPath)
    }
}

// MARK:- TableView DelegateMethods
extension AttachmentViewModel: UITableViewDelegate {}

// MARK:- UITextField DelegateMethods
extension AttachmentViewModel: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK:- UIDocumentPickerDelegate DelegateMethods
extension AttachmentViewModel: UIDocumentPickerDelegate {}

// MARK:- UIImagePickerControllerDelegate & UINavigationControllerDelegate  Methods
extension AttachmentViewModel: UIImagePickerControllerDelegate, UINavigationControllerDelegate {}
