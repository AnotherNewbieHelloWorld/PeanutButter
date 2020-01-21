//
//  PeanutModel.swift
//  PeanutButter
//
//  Created by Apple User on 20.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import RealmSwift

class PeanutButter: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var taste: String?
    @objc dynamic var productInfo: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var rating = 0.0
    @objc dynamic var like = false
    
    convenience init(name: String,
                     taste: String?,
                     productInfo: String?,
                     imageData: Data?,
                     rating: Double,
                     like: Bool) {
        self.init()
        self.name = name
        self.taste = taste
        self.productInfo = productInfo
        self.imageData = imageData
        self.rating = rating
        self.like = like
    }
}
