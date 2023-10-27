//
//  ScrollViewCoordinator.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/17/23.
//

import Foundation
import SwiftUI

struct ScrollViewDetector: UIViewRepresentable {
    var scrollFunction: (CGFloat) -> Void
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollViewDetector
        var delegateIsSet = false
        
        init(parent: ScrollViewDetector) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.scrollFunction(scrollView.contentOffset.y)
        }
    }
    
    func makeUIView(context: Context) -> some UIView {
        // Return an empty view because we don't actually care about this
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            // Only set the delegate once instead of every time updateUIView is called
            if let scrollView = uiView.superview?.superview?.subviews[1] as? UIScrollView, !context.coordinator.delegateIsSet {
                scrollView.delegate = context.coordinator
                context.coordinator.delegateIsSet = true
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
