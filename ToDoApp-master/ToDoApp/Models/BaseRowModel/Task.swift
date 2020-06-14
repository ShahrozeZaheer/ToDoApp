//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit
import RealmSwift

class Task: Object {
    
    @objc dynamic var name: String?
    var type: TaskType{
        get {
            return TaskType(rawValue: typeEnum) ?? TaskType.Pending
        }
        set{
            typeEnum = newValue.rawValue
        }
    }
    @objc dynamic fileprivate var typeEnum: String = TaskType.Pending.rawValue
    @objc dynamic var taskIdentifier: Date!
    
    init(name: String, type: TaskType) {
        super.init()
        self.name = name
        self.type = type
        taskIdentifier = Date.init()
    }
    
    required init() {
        
    }
    
}

enum TaskType: String {
    case Done
    case Pending
}
