//
//  exerciseTests.swift
//  exerciseTests
//
//  Created by Dong Wang on 2018/7/11.
//  Copyright © 2018年 Dong Wang. All rights reserved.
//

import XCTest
@testable import exercise

class exerciseTests: XCTestCase {
    var vc: CollectionViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nav = storyboard.instantiateInitialViewController() as! UINavigationController
        vc = nav.topViewController as! CollectionViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let arrayLength = 14
        vc.apiconnection.GetConnect(UrlStr: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        XCTAssert(vc.apiconnection.ParsedData.count == arrayLength)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
