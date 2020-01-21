//
//  StoreManager.swift
//  PeanutButter
//
//  Created by Apple User on 20.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StoreManager {
    
    static func saveObject(_ peanutButter: PeanutButter) {
        try! realm.write{
            realm.add(peanutButter)
        }
    }
    static func deleteObject(_ peanutButter: PeanutButter) {
        try! realm.write {
            realm.delete(peanutButter)
        }
    }
}
