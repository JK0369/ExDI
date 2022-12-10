//
//  Injected.swift
//  ExDI
//
//  Created by 김종권 on 2022/12/10.
//

import Foundation

// https://medium.com/streamotion-tech-blog/magic-dependency-injection-in-swift-70476c7743ec

@propertyWrapper
public class Injected<T> {
    
    private var storage: T?
    
    private let dependencyStore: DependencyStore
    
    public init() {
        dependencyStore = DependencyStore.shared
    }
    
    public var wrappedValue: T {
        if let storage = storage { return storage }
        let object: T = dependencyStore.resolve()
        storage = object
        return object
    }
    
}
