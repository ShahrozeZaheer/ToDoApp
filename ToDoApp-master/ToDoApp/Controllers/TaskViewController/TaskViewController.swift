//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController { // Generalization of task controller

    //MARK: IBOutlet

    @IBOutlet weak var tableView: UITableView!
    //MARK: Properties
    fileprivate var tasksArray = [Task]()
    
    internal var content = [BaseRowModel<Task>]() // Signle array containg data for tableview internal so can be protect while accessable to child class
    let taskManager = TaskManager.sharedManager // manager which manages the task

    //MARK: LifeCycle of controller

    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibCells()
        getTasks()
        
        NotificationCenter.default.addObserver(forName: .taskTypeChange, object: nil, queue: nil) {[weak self] (_) in
            guard let `self` = self else {return}
            self.reloadTableView() // this notification fired when state of task change from completed to pending or pending to completed
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    //MARK: Utility functions

    internal func reloadTableView() {tableView.reloadData()}
    
    func getTasks(){
        let realm = try! Realm()
        
        content.removeAll()
        tasksArray.removeAll()
        
        let results = realm.objects(Task.self)
        for data in results{
            let rowModel = BaseRowModel<Task>()
            rowModel.rowValue = data
            rowModel.rowCellIdentifier = "TaskTableViewCell"
            content.append(rowModel)
        }
        
        taskManager.allTasks = content
        self.reloadTableView()
    }
    
    func registerNibCells() {
        tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell") // signle cell used on multiple controllers so make Nib to reduce multiplication
    }
    
    func changeStatusAndNotify(rowModel: BaseRowModel<Task>) {
        taskManager.allTasks.forEach { (model) in
            if let task = rowModel.rowValue, let taskToCompare = model.rowValue {
                if task.taskIdentifier == taskToCompare.taskIdentifier { // changing the type of task
                    if task.type == .Done {
                        task.type = .Pending
                        UIAlertController.showAlert(title: nil, message: Constants.messageTaskPending)
                    } else {
                        task.type = .Done
                        UIAlertController.showAlert(title: nil, message: Constants.messageTaskCompleted)
                    }
                }
            }
            NotificationCenter.default.post(name: .taskTypeChange, object: nil) // after change notify the controller to update its data  source...
        }
    }
}

//MARK: UITableViewDataSource

extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = content[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: data.rowCellIdentifier) as? BaseTableViewCell<Task> else {return UITableViewCell()}
        
        cell.updateCell(data: data.rowValue) // Applying generalization approch for the tableview cells
        
        return cell
    }
    
}

//MARK: UITableViewDelegate

extension TaskViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            let rowSwiped = content[indexPath.row]
            
            taskManager.allTasks.removeAll { (model) -> Bool in
                if let task = model.rowValue, let taskToRemoved = rowSwiped.rowValue {
                    if (task.name == taskToRemoved.name) && (task.taskIdentifier == taskToRemoved.taskIdentifier) {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            let realm = try! Realm()
                            try! realm.write{
                                let results = realm.objects(Task.self).filter("name = '\(taskToRemoved.name!)'")
                                if results.isInvalidated{
                                    return
                                }
                                else{
                                    realm.delete(results)
                                }
                                
                            }
                        }
                        return true
                    }
                } // remove particular task from the main array and reload that row
                return false
            }
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realm = try! Realm()
        
        try! realm.write{
            let rowModel = content[indexPath.row]
            changeStatusAndNotify(rowModel: rowModel)
        }
    }
    
}
