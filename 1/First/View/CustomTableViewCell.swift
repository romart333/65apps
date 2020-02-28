//
//  CustomTableViewCell.swift
//  First
//
//  Created by user167101 on 2/25/20.
//  Copyright © 2020 Roman. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var customImageView: UIImageView!
    
    func setImage(_ image: UIImage) {
        customImageView.image = image
    }
}
