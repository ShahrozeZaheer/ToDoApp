//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import UIKit

class TaskTableViewCell: BaseTableViewCell<Task> {

    @IBOutlet weak var lblTaskTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func updateCell(data: Task?) { // Cell content updated with Task data
        if let task = data {
            lblTaskTitle.text = task.name
        }
    }
    
}
