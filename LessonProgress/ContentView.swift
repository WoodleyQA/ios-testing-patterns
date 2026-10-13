//
//  ContentView.swift
//  LessonProgress
//
//  Created by Stanley Woodley on 10/12/26.
//

import SwiftUI

struct ContentView: View {
    @State private var progress: Int = 0

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
    }
}

#Preview {
    ContentView()
}
