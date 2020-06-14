//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit

extension Notification.Name {
    // retro active approch for more readable code
    static let taskArrayUpdated = Notification.Name("TaskArrayUpdated")
    static let taskTypeChange = Notification.Name("TaskTypeChange")
    
}
