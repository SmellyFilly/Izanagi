//
//  AccessabilityAlertView.swift
//  Izanagi
//
//  Created by Daniel Hummelstad on 25/12/2022.
//

import SwiftUI
import AppKit

struct AccessibilityAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Accessibility Access Required")
            Text("Please grant access to the Accessibility API in the Security & Privacy preferences pane in the System Preferences.")
            Button("OK") {
                self.presentationMode.wrappedValue.dismiss()
            }
            Button("Open Preferences") {
                NSWorkspace.shared.openFile("/System/Library/PreferencePanes/Security.prefPane", withApplication: "System Preferences")
                NSWorkspace.shared.open(URL(string: "com.apple.preference.security")!)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .padding()
    }
}

struct AccessabilityAlertView_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityAlertView()
    }
}
