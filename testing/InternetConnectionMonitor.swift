//
//  InternetConnectionMonitor.swift
//  testing
//
//  Created by Arjun Shukla on 18/05/25.
//

import Foundation
import Network

protocol ConnectionMonitoring {
    var connectionChangeHandler: ((Bool) -> Void)? { get set }
    func stopMonitoring()
}


final class InternetConnectionMonitor : ConnectionMonitoring {
    
    var connectionChangeHandler: ((Bool) -> Void)?
    
    static let shared = InternetConnectionMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetMonitorQueue")
    
    private(set) var isConnected: Bool = false {
        didSet {
            if oldValue != isConnected {
                connectionChangeHandler?(isConnected)
            }
        }
    }
    
    
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
