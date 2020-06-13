//
//  TeamControllerTest.swift
//  AppTests
//
//  Created by Norman Sutorius on 13.06.20.
//

import XCTest
@testable import App
@testable import Vapor

class TeamControllerTest: XCTestCase
{

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let tc = TeamController()
        XCTAssertEqual(tc.hello(), "hello")
    }
    
    func testAllOutTeamMates() throws {
//        https://www.raywenderlich.com/1002044-testing-in-vapor#toc-anchor-002
//        let tc = TeamController()
//        var req: Request
//        req = Request.init(using: <#T##Container#>)
//        let ListAllOutMates = tc.fetchAllOutTeamMates(req: req)
//        XCTAssertEqual(ListAllOutMates, "list")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
