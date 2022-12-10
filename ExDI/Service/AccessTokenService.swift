//
//  AccessTokenService.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import Foundation

public protocol AccessTokenServiceType {
    func getAccessToken() -> String?
}

public class AccessTokenService: AccessTokenServiceType {
    static let shared = AccessTokenService()
    
    public func getAccessToken() -> String? {
        "access-token"
    }
}
