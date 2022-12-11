//
//  ViewController.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import UIKit
import RxSwift

public class ViewController: UIViewController {
    public var viewModel = ViewModel()
}

public class ViewModel {
    @Injected private var accessTokenService: AccessTokenServiceType
    @Injected private var configService: ConfigServiceType
    
    public let plusPublish = PublishSubject<Int>()
    public let cntBehavior = BehaviorSubject<Int>(value: 0)
    
    public var currentSecretKey = ""
    private let disposeBag = DisposeBag()
    
    init() {
        plusPublish
            .subscribe(onNext: { [weak self] plus in
                guard let ss = self else { return }
                let previous = try! ss.cntBehavior.value()
                ss.cntBehavior.onNext(previous + plus)
            })
            .disposed(by: disposeBag)
    }
    
    public func textInput(_ str: String) {
        configService.saveSecretKey(str)
    }
    
    public func tapStoreButton() {
        currentSecretKey = configService.secretKey
    }
}
