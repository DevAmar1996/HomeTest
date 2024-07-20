//
//  UIView+Extension.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 18/07/2024.
//

import UIKit
import SwiftUI

extension UIView {
    static func from<Content: View>(swiftUIView: Content) -> UIView {
        let hostingController = UIHostingController(rootView: swiftUIView)
        return hostingController.view
    }
}
