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
        sut = PhotosVC()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
        func testRegularUrl(){
            
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let urlRegular = self.sut.photoArray[1].regular
                XCTAssertEqual(urlRegular, "https://images.unsplash.com/photo-1464550580740-b3f73fd373cb?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=899c346de4765f353375b8a5bd6cfc0e")
                
            }
        }
    func testPhotId(){
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let photoId = self.sut.photoArray[1].id
            XCTAssertEqual(photoId, "9KaubGesJ5Q")
            
        }
    }
    func testPhotHight(){
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let photoHeight = self.sut.photoArray[1].height
            XCTAssertEqual(photoHeight, 1532)
            
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
