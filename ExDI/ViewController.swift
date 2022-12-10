//
//  ViewController.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import UIKit

public class ViewController: UIViewController {
    public var viewModel = ViewModel()
}

public class ViewModel {
    @Injected private var accessTokenService: AccessTokenServiceType
    @Injected private var configService: ConfigServiceType
    
    public var currentSecretKey = ""
    
    public func textInput(_ str: String) {
        configService.saveSecretKey(str)
    }
    
    public func tapStoreButton() {
        currentSecretKey = configService.secretKey
    }
}
