//
//  SentMessageTableViewCell.swift
//  WhatsAppAttachments
//
//  Created by NoBroker on 09/05/21.
//

import UIKit

class SentMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    class func nib() -> UINib {
        return UINib(nibName: SentMessageTableViewCell.getIdentifier(), bundle: nil)
    }
    
}

extension UITableViewCell {
    static func getIdentifier() -> String {
        let className = NSStringFromClass(self).components(separatedBy: ".").last!
        return className
    }
}
