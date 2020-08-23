//
//  DAActivityIndicator.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import UIKit
import Foundation
import NVActivityIndicatorView

final class DAActivityIndicator {
    // Singleton
    static let shared = DAActivityIndicator()
    
    // Private Properties
    private var activityIndicator: NVActivityIndicatorView?
    
    // Initializers
    private init() {
        
    }
    
    // Helpers
    private func cleanUpActivityIndicator() {
        if self.activityIndicator != nil {
            self.activityIndicator!.stopAnimating()
            self.activityIndicator!.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
    
    func startLoading() {
        self.cleanUpActivityIndicator()
        
        // get reference to window for specifying frame
        var window: UIWindow?
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? DASceneDelegate {
            window = sceneDelegate.window
        }
        
        let xAxis = window?.center.x ?? 0
        let yAxis = window?.center.y ?? 0
        let frame = CGRect(x: (xAxis - 50), y: (yAxis - 50), width: 45, height: 45)
        
        self.activityIndicator = NVActivityIndicatorView(frame: frame, type: .ballRotateChase, color: .darkGray, padding: nil)
        window?.addSubview(self.activityIndicator!)
        window?.bringSubviewToFront(self.activityIndicator!)
        self.activityIndicator!.startAnimating()
    }
    
    func stopLoading() {
        self.cleanUpActivityIndicator()
    }
    
}
