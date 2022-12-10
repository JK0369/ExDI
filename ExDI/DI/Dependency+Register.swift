//
//  Dependency+Register.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import Foundation

extension DependencyStore {
    func registerAll() {
        register(AccessTokenService.shared, for: AccessTokenServiceType.self)
        register(ConfigService.shared, for: ConfigServiceType.self)
    }
}
