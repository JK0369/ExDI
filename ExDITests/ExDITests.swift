//
//  ExDITests.swift
//  ExDITests
//
//  Created by 김종권 on 2022/12/10.
//

@testable import ExDI
import XCTest
import Nimble
import Quick
import RxExpect
import RxSwift
import RxCocoa

final class StubConfigService: ConfigServiceType {
    private var key = ""
    
    var secretKey: String {
        key
    }
    
    func saveSecretKey(_ key: String) {
        self.key = key + "@"
    }
}

final class ExDITests: QuickSpec {
    override func spec() {
        describe("The user is logged in") {
            var sut: ViewModel!
            
            beforeSuite {
                let ds = DependencyStore()
                let stubConfigService = StubConfigService()
                
                ds.register(stubConfigService, for: ConfigServiceType.self)
                sut = ds.execute {
                    ViewModel()
                }
            }

            context("The user tap button") {
                beforeEach {
                    sut.textInput("jake-ios")
                    sut.tapStoreButton()
                }

                it("Get access token") {
                    expect(sut.currentSecretKey)
                        .to(equal("jake-ios@"))
                }
            }
        }
    }
}

/*
 describe
 context
 Test Suite 'ExDITests' started at 2022-12-11 01:54:53.518
 Test Case '-[ExDITests.ExDITests The_user_is_logged_in__The_user_tap_button__Get_access_token:]' started.
 beforeSuite
 Test Case '-[ExDITests.ExDITests The_user_is_logged_in__The_user_tap_button__Get_access_token:]' passed (0.004 seconds).
 Test Suite 'ExDITests' passed at 2022-12-11 01:54:53.523.
      Executed 1 test, with 0 failures (0 unexpected) in 0.004 (0.005) seconds
 */

struct Calculator {
    func plus(_ a: Int, _ b: Int) -> Int {
        a + b
    }
}

final class SomeExampleTests: QuickSpec {
    override func spec() {
        describe("조건") {
            var someMock: Int!
            var sut: Calculator!
            
            beforeSuite {
                someMock = 3
                sut = Calculator()
            }
            
            afterSuite {
                someMock = nil
                sut = nil
            }
            
            context("액션") {
                var value: Int!
                
                beforeEach {
                    value = sut.plus(0, 3)
                }
                
                afterEach {
                    value = nil
                }
                
                it("결과") {
                    expect(value)
                        .to(equal(someMock))
                }
            }
        }
    }
}

// describe - context - beforeSuite - beforeEach - it - afterEach 순서로 실행
final class SomeExample2Tests: QuickSpec {
    
    override func spec() {
        describe("조건") {
            print("describe")
            var someStub: Int!
            var sut: Calculator!

            beforeSuite {
                print("beforeSuite")
                someStub = 3
                sut = Calculator()
            }
            
            afterSuite {
                print("afterSuite")
                someStub = nil
                sut = nil
            }

            context("액션") {
                print("context")
                var value: Int!

                beforeEach {
                    print("beforeEach")
                    value = sut.plus(0, 3)
                }

                afterEach {
                    print("afterEach")
                    value = nil
                }

                it("결과") {
                    print("it")
                    expect(value)
                        .to(equal(someStub))
                }
            }
        }
    }
}

final class RxExpectTests: XCTestCase {
    func testSome() {
        var sut: ViewModel!
        var rxExpect: RxExpect!
        
        sut = ViewModel()
        rxExpect = RxExpect()
        rxExpect.retain(sut) // 테스트 도중 메모리 해제 방지
        
        rxExpect.input(sut.plusPublish, [
            .next(10, 1),
            .next(20, 2),
            .next(30, 100)
        ])
        
        rxExpect.assert(sut.cntBehavior) { events in
            expect(events.elements).to(equal([0, 1, 3, 103]))
        }
    }
}

final class RxExpect2Tests: QuickSpec {
    override func spec() {
        describe("The user is logged in") {
            print("describe")
            var sut: ViewModel!
            var rxExpect: RxExpect!
            
            beforeSuite {
                print("beforeSuite")
                sut = ViewModel()
                rxExpect = RxExpect()
                rxExpect.retain(sut) // 테스트 도중 메모리 해제 방지
            }
            
            context("The user tap button") {
                print("context")
                beforeEach {
                    rxExpect.input(sut.plusPublish, [
                        .next(10, 1),
                        .next(20, 2),
                        .next(30, 100)
                    ])
                }
                
                it("result of count") {
                    print("it")
                    rxExpect.assert(sut.cntBehavior) { events in
                        print("testing...")
                        expect(events.elements).to(equal([-1, 1, 3, 103]))
                    }
                }
            }
        }
    }
}
