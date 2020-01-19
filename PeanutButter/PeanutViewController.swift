//
//  PeanutViewController.swift
//  PeanutButter
//
//  Created by Apple User on 19.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit

class PeanutViewController: UIViewController{
    var peanutButter: PeanutButter!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tasteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = peanutButter.name
        tasteLabel.text = peanutButter.taste
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
}
