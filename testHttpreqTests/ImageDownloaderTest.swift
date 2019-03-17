//
//  ImageDownloaderTest.swift
//  testHttpreqTests
//
//  Created by ABD on 17/03/2019.
//  Copyright © 2019 ABD. All rights reserved.
//

import XCTest
@testable import testHttpreq

class ImageDownloaderTest: XCTestCase {
    var sut : PhotosVC!

    override func setUp() {
        super.setUp()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // your code here
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.sut = (storyboard.instantiateViewController(withIdentifier: "PhotosVC") as! PhotosVC)
            self.sut.loadViewIfNeeded()
        }
        
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testPhotoDownload(){
        let expectedImageOrientation = UIImage(named: "photo[0]")?.imageOrientation
        
        guard let url = URL(string: "https://images.unsplash.com/photo-1464550883968-cec281c19761?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&w=1080&fit=max&s=1881cd689e10e5dca28839e68678f432") else { XCTFail(); return}
        let sessionAnswersExpectation = expectation(description: "session")
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            if let data = data {
                guard let image = UIImage(data: data) else {XCTFail(); return}
                sessionAnswersExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()
        
        waitForExpectations(timeout: 8, handler: nil)
        
        
    }
   

}
