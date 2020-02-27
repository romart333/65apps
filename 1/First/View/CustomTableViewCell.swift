//
//  CustomTableViewCell.swift
//  First
//
//  Created by user167101 on 2/25/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(_ image: UIImage) {
        customImageView.image = image
    }
}
