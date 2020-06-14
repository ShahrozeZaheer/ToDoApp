//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit
import RealmSwift

class TaskManager: NSObject { // A Singelton class responsible of filtering and containg task arrays.
    static let sharedManager = TaskManager()
    fileprivate var tasksArray = [Task]()
    
    var allTasks = [BaseRowModel<Task>]() {
        didSet {
            NotificationCenter.default.post(name: .taskArrayUpdated, object: nil) // notify the controllers about the changed in main task array
            self.wirteDatabase()
        }
    }
    var pendingTasks: [BaseRowModel<Task>] {
        return self.filterWithTask(type: .Pending) // filter main array for pending tasks
    }
    
    var completedTasks: [BaseRowModel<Task>] {
        return self.filterWithTask(type: .Done)
    }

    private override init() { // privite init so no new manager class can be created. 
        super.init()
    }
    
    private func filterWithTask(type: TaskType) -> [BaseRowModel<Task>] {
        return allTasks.filter { (item) -> Bool in
            if let _item = item.rowValue {
                 return _item.type == type
            }
            return false
        }
    }
    
    func wirteDatabase()
    {
        for data in allTasks{
            tasksArray.append(data.rowValue!)
        }
        let realm = try! Realm()
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        try! realm.write{
            realm.add(tasksArray)
        }
    }
    
    
}
