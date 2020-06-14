//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit

class CompletedTaskViewController: TaskViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: .taskArrayUpdated, object: nil, queue: nil) {[weak self] (notification) in
            self?.updateTableViewData()
        }
        updateTableViewData()
    }
    
    override func reloadTableView() {
        content = taskManager.completedTasks
        super.reloadTableView()
    }
    
    // MARK: - Utility Methods
    
    fileprivate func updateTableViewData() {
        content = taskManager.completedTasks
    }

}


