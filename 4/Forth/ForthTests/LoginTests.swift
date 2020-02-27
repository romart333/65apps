//
//  ForthTests.swift
//  ForthTests
//
//  Created by user167101 on 2/27/20.
//  Copyright © 2020 user167101. All rights reserved.
//

import XCTest
@testable import Forth

class LoginTests: XCTestCase {
    
    func testValidLoginWithLongEmail() {
        // 32 characters
        let login = "f123456789-.tyuioPASD@yandex.ru"
        print(login.count)
        XCTAssertTrue(LoginChecker.shared.checkLogin(login: login), "Login was failed")
    }

    func testValidLoginWithShortUsername() {
        let login = "sw."
        XCTAssertTrue(LoginChecker.shared.checkLogin(login: login), "Login was failed")
    }

    func testInvalidEmptyLogin() {
        let login = ""
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
    }

    func testInvalidLoginWithTooShortUsername() {
        let login = "lo"
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
    }

    func testInvalidLoginWithTooLongUsername() {
        //33 characters
        let login = "f0123456789QWERTYuiopas@yandex.ru"
        for s in login {
            if String(s).count == 2 { print(String(s))}
        }
        print(login.count)
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
    }

    func testInvalidLoginWithIncorrectSymbols() {
        let login = "йцукенгшЧСМИТЬ!#$%^&*()_+="
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
    }
    
    func testInvalidFirstSymbolInLogin() {
        var login = "1email@mail.com"
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
        login = ".username"
               XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
        login = "-username2"
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
    }
    
    func testInvalidEmail() {
         var login = "email@"
         XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
        
         login = "email@mail."
                XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
        
         login = "mail@.com"
         XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
        
        login = "@gmail.com"
        XCTAssertFalse(LoginChecker.shared.checkLogin(login: login), "Login was succesfull, but shouldn't")
     }
}
