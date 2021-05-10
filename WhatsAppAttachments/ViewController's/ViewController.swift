//
//  ViewController.swift
//  WhatsAppAttachments
//
//  Created by Musavir on 25/04/21.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableViewBottomConst: NSLayoutConstraint!

    // MARK: - Variables
    var viewModel: AttachmentViewModel?
    weak var mainCoodinator: MainCoordinator?
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setupUI()
    }

    // MARK: - IBActions
    @IBAction func showAttachments(_ sender: UIButton) {
        AttachmentHandler.openAttachment(from: self) { [unowned self] selectedItem in
            self.viewModel?.didSelectItem(selected: selectedItem)
        }
    }

    @IBAction func sendMessge(_ sender: UIButton) {
        if let text = messageTextField.text, !text.isEmpty {
            viewModel?.sendMessage(message: text)
            messageTextField.text = nil
        }
    }

    // MARK: - Private methods
    private func setupUI() {
        viewModel = AttachmentViewModel(self)
        self.tableView.dataSource = viewModel
        self.tableView.delegate = viewModel
        self.tableView.register(MessageTableViewCell.nib(), forCellReuseIdentifier: MessageTableViewCell.getIdentifier())
        viewModel?.setupMessageTextField(textField: messageTextField)
        viewModel?.mainCoodinator = mainCoodinator
    }

    private func reloadTableViewItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - ViewModel methods
extension ViewController: AttachmentActionDelegate {
    func moveMessgeField(height: CGFloat?) {
        if let keyBoardHeight = height {
            self.tableViewBottomConst.constant += self.view.frame.origin.y == .zero ? keyBoardHeight : .zero
        } else {
            self.tableViewBottomConst.constant = 0
        }
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
    }

    func didFinish() {
        self.reloadTableViewItems()
    }
}
