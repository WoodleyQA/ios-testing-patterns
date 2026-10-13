//
//  LessonProgressUITests.swift
//  LessonProgressUITests
//
//  Created by Stanley Woodley on 10/12/26.
//

import XCTest

final class LessonProgressUITests: XCTestCase {

    override func setUpWithError() throws {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
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

        let progressLabel = app.staticTexts["progressLabel"]
        XCTAssertTrue(progressLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(progressLabel.label, "Progress: 3")
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

        let progressLabel = app.staticTexts["progressLabel"]
        XCTAssertTrue(progressLabel.waitForExistence(timeout: 5))
        XCTAssertEqual(progressLabel.label, "Progress: 3")
    }
}
