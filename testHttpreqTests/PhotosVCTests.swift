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
    var  photoArrayTest = [Photo]()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // sut : system under test 
        sut = (storyboard.instantiateViewController(withIdentifier: "PhotosVC") as? PhotosVC)
        
        sut = PhotosVC()
        sut.loadViewIfNeeded()
        
    }

    
    override func tearDown() {
       sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImageDownload() {
         /*in all the networking operation we expected  some delay in case internet connection slow or somthing so i add DispatchQueue.main.asyncAfter(deadline: .now() + 1) to ensure that all data was downloaded and make smooth user experience */
        
     
            perform(#selector(dowloadImage), with: nil, afterDelay: 1)
        
        
        
        
            /* i download image with the element 0 and now we just test if the Orientation of the two images is the same
             dowloaded image from the web vs downloaded image via the app at the same element 0*/
        
        
            
        
            }
    func dowloadImage(){
        let expectedImageOriontation = UIImage(named: "photo[0]")?.imageOrientation
        guard let url = URL(string: self.sut.photoArray[0].regular) else {XCTFail();  return}
        let sessionAnswersExpectation = self.expectation(description: "session")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error =  error {
                XCTFail(error.localizedDescription)
            }
            if let data = data {
                guard let image = UIImage(data: data) else {XCTFail(); return}
                sessionAnswersExpectation.fulfill()
                // ou test pass with Succeeded but can fail when we change any thing
                XCTAssertEqual(image.imageOrientation, expectedImageOriontation)
                self.waitForExpectations(timeout: 5, handler: nil)
            }
            
            }.resume()
        
        
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
