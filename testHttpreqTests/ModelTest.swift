//
//  ModelTest.swift
//  testHttpreqTests
//
//  Created by ABD on 16/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import XCTest
@testable import testHttpreq

class ModelTest: XCTestCase {
    var sut : PhotosVC!

    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        sut = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
        func testRegularUrl(){
            
            //perform(#selector(urlPhotocheck), with: nil, afterDelay: 1)
            let urlRegular = self.sut.photoArray[1].regular
            let urlExpectation = self.expectation(description: "urlexpectation")
            
            urlExpectation.fulfill()
            XCTAssertEqual(urlRegular, "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=899c346de4765f353375b8a5bd6cfc0e")
            self.waitForExpectations(timeout: 5, handler: nil)
            
            
        }
    func testPhotId(){
        
        
        
       
             /*  we compare beteween two ids  string an expected id string  get from the web and the othes get it from our photoArray at the same element ,our test can pass or fail if we change the expected id  */
            //let photoId = self.sut.photoArray[1].id
            let idExpectation = self.expectation(description: "idexpectation")
            idExpectation.fulfill()
            XCTAssertEqual("p", "9KaubGesJ")
            print("te", self.sut.photoArray.count)
            self.waitForExpectations(timeout: 1, handler: nil)
        
        
        
        
        
        
    }
    
    func testPhotHight(){
        
        /*  we compare beteween two heights  Int an expected  height  Int  get from the web  broswer and the othes get it from our photoArray at the same element ,our test can pass or fail if we change the expected hight this test we make it fail because we change the expected value to 1531 instad of 1532  */
        
      
            let photoHeight = self.sut.photoArray[1].height
            print(self.sut.photoArray[1].height)
            
            XCTAssertEqual(photoHeight, 1532)
         //   self.waitForExpectations(timeout: 1, handler: nil)
        
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
