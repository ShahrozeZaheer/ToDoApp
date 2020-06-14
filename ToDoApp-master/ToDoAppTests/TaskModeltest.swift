//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Shahroze Zaheer on 14/06/2020.
//  Copyright © 2020 ShahrozeZaheer. All rights reserved.
//

import XCTest
@testable import ToDoApp

class TaskModeltest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelInitilization() { // Test to check init of model.. if result are differ than something wring with init
        let name = "Afroz task"
        guard let type = TaskType(rawValue: "Pending") else {
            XCTFail()
            return
        }
        
        let newTaskObj = Task(name: name, type: type)
        
        XCTAssertEqual(newTaskObj.name, "Afroz task")
        XCTAssertEqual(newTaskObj.type, TaskType.Pending)
    }

}
