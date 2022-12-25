//
//  WindowTileView.swift
//  Izanagi
//
//  Created by Daniel Hummelstad on 25/12/2022.
//

import SwiftUI
import Accessibility

struct WindowTileView: View {
    // Create a state variable to hold the list of windows
    @State private var windows: [AXUIElement] = []
    @State private var hasAccess: Bool = false

    var body: some View {
        if self.hasAccess {
            VStack {
                // Add a button to trigger the tiling functionality
                Button(action: tileWindows) {
                    Text("Tile Windows")
                }
                
                // Add a list to display the names of the windows
                List(windows, id: \.self) { window in
                    Text(self.getWindowTitle(window: window))
                }
            }.onAppear {
                getWindows()
            }
        } else {
            AccessibilityAlertView()
        }
    }

    // Function to retrieve the list of windows and update the state variable
    func getWindows() {
        // Use the AXUIElementCopyAttributeValues function to get the list of windows for all applications
        if !self.hasAccessibility() {
            print("no accessability")
            return
        }
        var value: CFArray?
        if AXUIElementCopyAttributeValues(AXUIElementCreateSystemWide(), kAXWindowsAttribute as CFString, 0, 100, &value) == .success {
            if let array = value as? [AXUIElement] {
                self.windows = array
            }
        }
    }

    // Function to retrieve the title of a window
    func getWindowTitle(window: AXUIElement) -> String {
        // Use the AXUIElementCopyAttributeValue function to get the title of the window
        var value: CFTypeRef?
        if AXUIElementCopyAttributeValue(window, kAXTitleAttribute as CFString, &value) == .success {
            if let title = value as? String {
                return title
            }
        }
        return "Unknown"
    }

    // Function to tile the windows
    func tileWindows() {
        // Iterate through the windows and set their size and position using the AXUIElementSetAttributeValue function
        for (index, window) in windows.enumerated() {
            var rect = CGRect(x: CGFloat(index) * 50, y: CGFloat(index) * 50, width: 400, height: 300)
            let point = AXValueCreate(.cgPoint, &rect.origin)
            let size = AXValueCreate(.cgSize, &rect.size)
            AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, point!)
            AXUIElementSetAttributeValue(window, kAXSizeAttribute as CFString, size!)
        }
    }
    
    func hasAccessibility() -> Bool {
        self.hasAccess = AXIsProcessTrusted()
        return AXIsProcessTrusted()
    }
}
