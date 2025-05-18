//
//  ViewController.swift
//  testing
//
//  Created by Arjun Shukla on 15/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var connectionMonitor: ConnectionMonitoring?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connectionMonitor = InternetConnectionMonitor.shared

        self.connectionMonitor?.connectionChangeHandler = { [weak self] isConnected in
            if isConnected {
                print("✅ Internet is available")
            } else {
                print("🚫 No Internet connection")
            }
        }
    }
}




