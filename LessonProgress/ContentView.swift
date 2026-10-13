//
//  ContentView.swift
//  LessonProgress
//
//  Created by Stanley Woodley on 10/12/26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("progress") private var progress: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Progress: \(progress)")
                .accessibilityIdentifier("progressLabel")

            Button("Complete step") {
                progress += 1
            }
            .accessibilityIdentifier("completeButton")
        }
        .padding()
        .onAppear {
            if ProcessInfo.processInfo.arguments.contains("-resetProgress") {
                progress = 0
            }
        }
    }
}

#Preview {
    ContentView()
}
