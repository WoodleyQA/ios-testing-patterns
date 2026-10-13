# LessonProgress

LessonProgress is a small SwiftUI app with a single screen that tracks a lesson progress counter. It exists to demonstrate a subtle testing trap in iOS apps: a UI test that only backgrounds and resumes an app can pass even when the app's state is not actually persisted. Backgrounding keeps the process alive in memory, so in-memory state like `@State` survives the round trip and the test reports success. In reality, iOS can and does terminate backgrounded apps to reclaim memory, and a user relaunching the app after that happens would see their progress reset to zero. The only way to catch this is to explicitly terminate and relaunch the app in the test, which forces a fresh process and exposes whether state was actually written to disk.

This repo contains two XCUITests that show the difference. `testBackgroundResume` taps "Complete step" three times, sends the app to the background with `XCUIDevice.shared.press(.home)`, brings it back with `app.activate()`, and asserts the progress label reads "Progress: 3". `testTerminateResume` does the same three taps, then calls `app.terminate()` followed by `app.launch()` to fully kill and restart the process, and asserts the same label. Both tests look alike at a glance, but only the second one proves the data survives process death.

The commit history captures this as a red to green progression. The commit "Add lifecycle tests: background passes, terminate exposes in-memory progress loss" adds both tests while progress is still stored in a plain `@State` variable. At that point `testBackgroundResume` passes and `testTerminateResume` fails, since the counter is only held in memory and resets to zero on a fresh launch. The next commit, "Persist progress to disk; terminate test now passes", switches the counter to `@AppStorage` so it is written to `UserDefaults`, and adds handling for a `-resetProgress` launch argument so each test can control whether progress starts clean. After that change both tests pass.

To run the tests, open a terminal in the project root and run:

```
xcodebuild test \
  -project LessonProgress.xcodeproj \
  -scheme LessonProgress \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:LessonProgressUITests/LessonProgressUITests/testBackgroundResume \
  -only-testing:LessonProgressUITests/LessonProgressUITests/testTerminateResume
```

Swap `iPhone 16` for any simulator you have installed; list the available options with `xcrun simctl list devices available`.
