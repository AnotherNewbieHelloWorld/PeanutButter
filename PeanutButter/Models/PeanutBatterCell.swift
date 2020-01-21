//
//  PeanutBatterCell.swift
//  PeanutButter
//
//  Created by Apple User on 18.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit
import Cosmos

class PeanutButterCell: UITableViewCell {
    @IBOutlet weak var jarImage: UIImageView! {
        didSet {
            jarImage?.layer.cornerRadius = jarImage.frame.size.height / 2
            jarImage?.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet {
            cosmosView.settings.updateOnTouch = false
        }
    }
}
