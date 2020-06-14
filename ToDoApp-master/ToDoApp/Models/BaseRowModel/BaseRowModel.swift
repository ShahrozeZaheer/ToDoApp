//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit
import RealmSwift

class BaseRowModel<T>: NSObject {
    // Row Item
    var rowCellIdentifier = ""
    var rowValue: T?
}
