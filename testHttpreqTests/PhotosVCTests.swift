//
//  PhotosVCTest.swift
//  testHttpreqTests
//
//  Created by ABD on 16/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import XCTest
@testable import testHttpreq

class PhotosVCTests: XCTestCase {
    var sut : PhotosVC!
    var mystoryboard : MYStoryboard!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
      sut = storyboard.instantiateViewController(withIdentifier: "PhotosVC") as! PhotosVC
      //  sut = PhotosVC()
        sut.loadViewIfNeeded()
        
    }

    
    override func tearDown() {
        sut = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageDownload() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let expectedImageOriontation = UIImage(named: "photo[1]")?.imageOrientation
            guard let url = URL(string: self.sut.photoArray[0].regular) else {XCTFail();  return}
            let sessionAnswersExpectation = self.expectation(description: "session")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error =  error {
                    XCTFail(error.localizedDescription)
                }
                if let data = data {
                    guard let image = UIImage(data: data) else {XCTFail(); return}
                    sessionAnswersExpectation.fulfill()
                    XCTAssertEqual(image.imageOrientation, expectedImageOriontation)
                }
                }.resume()
       

            
        }
            }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
