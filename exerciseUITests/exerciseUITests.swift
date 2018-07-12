//
//  exerciseUITests.swift
//  exerciseUITests
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import XCTest

class exerciseUITests: XCTestCase {
    
    var app : XCUIApplication!
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments += ["-NSDoubleLocalizedStrings", "YES"]
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
       XCTAssert(app.textViews["Text"].exists)
       XCTAssert(app.images.count>13)
    }
    
}
