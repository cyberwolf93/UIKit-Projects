//
//  coreUtils.swift
//  NetworkCore
//
//  Created by Ahmed Mohiy on 22/10/2022.
//

import Foundation


public extension String {
    public static func localizedString(with key: String) -> String {
        return NSLocalizedString(key, comment: "Comment")
    }
}

public class PlistManager {
    
    public static let shared = PlistManager()
    
    private init() {
        
    }
    
    public var base_url: String {
        let url = Bundle.main.infoDictionary?["base_url"] as? String ?? ""
        return url
    }
    
    
}

extension DispatchQueue {
    
    // Create syncornized block
    public static func synchronized<T>(_ lock: Any, closure: () -> T) -> T {
        defer {
            objc_sync_exit(lock)
        }
        objc_sync_enter(lock)
        return closure()
        
    }
}
