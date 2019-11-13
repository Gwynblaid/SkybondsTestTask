// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import XCTest
@testable import SkybondsTestTask

class SharePlotInteractorTests: XCTestCase {
	
	let dataSource = ShareDataSourceMock()
	let delegate = SharePlotInteractorDelegateMock()
	
	lazy var testableInteractor = SharePlotInteractor(dataSource: dataSource, isin: "")

    override func setUp() {
		testableInteractor.delegate = delegate
		dataSource.shouldReturnError = false
		delegate.error = nil
		delegate.dataView = nil
		testableInteractor.period = .week
		testableInteractor.dataType = .price
		testableInteractor.isin = "Init"
		dataSource.requestCalled = false
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEmptyISIN() {
		testableInteractor.isin = ""
		XCTAssert(testableInteractor.isin == "", "Interactor should store isin")
		XCTAssertFalse(dataSource.requestCalled, "Shouldn't request data")
		XCTAssert(delegate.error != nil && delegate.dataView == nil, "Should return error for empty isin and nil data")
    }
	
	func testSomeISIN() {
		testableInteractor.isin = "Some"
		XCTAssert(testableInteractor.isin == "Some", "Interactor should store isin")
		XCTAssert(dataSource.requestCalled, "Should request data when  change isin")
	}
	
	func testPeriod() {
		testableInteractor.period = .halfYear
		XCTAssert(testableInteractor.period == .halfYear, "Interactor should store period")
		XCTAssert(dataSource.requestCalled, "Should request data when changed period")
	}
	
	func testDataType() {
		testableInteractor.dataType = .yeild
		XCTAssert(testableInteractor.dataType == .yeild, "Interactor should store dataType")
		XCTAssert(dataSource.requestCalled, "Should request data when changed dataType")
	}
	
	func testUpdateData() {
		testableInteractor.updateData()
		XCTAssert(dataSource.requestCalled, "Should request data when call updateData()")
	}
	
	func testSuccessData() {
		dataSource.shouldReturnError = false
		testableInteractor.updateData()
		XCTAssert(delegate.error == nil && delegate.dataView != nil, "Should return dataView to delegate")
		let dataView = delegate.dataView!
		XCTAssert(dataView.data == dataSource.data, "Should return data from server")
	}
	
	func testFailureData() {
		dataSource.shouldReturnError = true
		testableInteractor.updateData()
		XCTAssert(delegate.error! as NSError == dataSource.error && delegate.dataView == nil, "Should return error from server")
	}
}
