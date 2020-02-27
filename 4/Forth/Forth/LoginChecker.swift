//
//  TestedCode.swift
//  Forth
//
//  Created by user167101 on 2/25/20.
//  Copyright © 2020 user167101. All rights reserved.
//

import Foundation

public class LoginChecker {
    
    private var loginLengthRange = 3...32
    
    private lazy var userNameRegEx = {
            return try! NSRegularExpression(pattern: "^[a-z]([0-9a-z-.]){2,31}$",
                options: .caseInsensitive)
        }()
    
    private lazy var emailRegEx = {
          return try! NSRegularExpression(pattern: "^[a-z]([a-z0-9-.])*@([a-z0-9])+\\.([a-z])+$",
                                          options: .caseInsensitive)
      }()
    
    public static let shared = LoginChecker()

    private init() { }
    
    public func checkLogin(login: String) -> Bool {
       return isEmailValid(email: login) || isUserNameValid(username: login)
    }
    
    public func isUserNameValid(username: String) -> Bool {
        return userNameRegEx.isStringValid(username)
    }
    
    public func isEmailValid(email: String) -> Bool{
        return emailRegEx.isStringValid(email) && loginLengthRange.contains(email.count)
       }
}

extension NSRegularExpression {
      func isStringValid(_ string: String) -> Bool {
          let matches = self.matches(in: string,
                                     options: [],
                                     range: NSRange(location: 0, length: string.count))
        
        return matches.count > 0
      }
}
