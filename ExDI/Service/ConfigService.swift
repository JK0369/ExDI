//
//  ConfigService.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import Foundation

public protocol ConfigServiceType {
    var secretKey: String { get }
    
    func saveSecretKey(_ key: String)
}

public class ConfigService: ConfigServiceType {
    static let shared = ConfigService()
    private var key = ""
    
    public var secretKey: String {
        key
    }
    
    public func saveSecretKey(_ key: String) {
        self.key = key
    }
}
