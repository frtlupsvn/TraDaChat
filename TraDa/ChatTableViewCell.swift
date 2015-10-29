//
//  ChatTableViewCell.swift
//  TraDa
//
//  Created by Zoom NGUYEN on 10/27/15.
//  Copyright © 2015 Zoom NGUYEN. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chatTextLbel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var backgroundMessage: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundMessage.layer.cornerRadius = 5.0
        
        userAvatar.layer.cornerRadius = userAvatar.frame.width/2
        userAvatar.layer.masksToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
