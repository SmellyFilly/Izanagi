//
//  Window.swift
//  Izanagi
//
//  Created by Daniel Hummelstad on 25/12/2022.
//

import Foundation
import CoreGraphics
import AppKit

struct Window {
    let dictionary: [String: Any]
    
    var windowID: CGWindowID {
        return CGWindowID(dictionary[kCGWindowNumber as String] as! Int)
    }
    
    var windowName: String {
        return String(dictionary[kCGWindowName as String] as! String)
    }
    
    var bounds: CGRect {
        return dictionary[kCGWindowBounds as String] as! CGRect
    }
    
    var thumbnail: NSImage {
        // Create a thumbnail image for the window using the CGWindowListCreateImage function
        let image = CGWindowListCreateImage(bounds, .optionIncludingWindow, windowID, [])
        return NSImage(cgImage: image!, size: NSSize(width: bounds.width, height: bounds.height))
    }
    
    func orderFront() {
        // Bring the window to the front using the CGWindowListSetWindowOrderingFunction function
        // CGWindowListSetWindowOrderingFunction(windowID, .above)
        return
    }
    
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
    }
}
