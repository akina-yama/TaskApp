//
//  Task.swift
//  taskapp
//
//  Created by Akina Yamanishi on 2020/09/03.
//  Copyright © 2020 Akina.Yamanishi. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var contents = ""
    @objc dynamic var date = Date()
    @objc dynamic var category = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
