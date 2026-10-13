//
//  LessonProgressUITests.swift
//  LessonProgressUITests
//
//  Created by Stanley Woodley on 10/12/26.
//

import XCTest

final class LessonProgressUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    @MainActor
    func testBackgroundResume() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-resetProgress"]
        app.launch()

        let completeButton = app.buttons["completeButton"]
        for _ in 0..<3 {
            completeButton.tap()
        }

        XCUIDevice.shared.press(.home)
        app.activate()

        XCTAssertEqual(app.staticTexts["progressLabel"].label, "Progress: 3")
    }

    @MainActor
    func testTerminateResume() throws {
        let app = XCUIApplication()
        app.launchArguments = ["-resetProgress"]
        app.launch()

        let completeButton = app.buttons["completeButton"]
        for _ in 0..<3 {
            completeButton.tap()
        }

        app.terminate()
        app.launchArguments = []
        app.launch()

        XCTAssertEqual(app.staticTexts["progressLabel"].label, "Progress: 3")
    }
}
