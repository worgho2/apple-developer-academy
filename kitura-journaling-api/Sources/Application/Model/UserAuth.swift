//
//  UserAuth.swift
//  Application
//
//  Created by otavio on 27/04/20.
//

import Foundation
import SwiftKueryORM
import CredentialsHTTP

struct UserAuth: Model {
    public var id: String
    public let password: String
}

extension UserAuth: TypeSafeHTTPBasic {
    static func verifyPassword(username: String, password: String, callback: @escaping (UserAuth?) -> Void) {
        UserAuth.find(id: username) { (userAuth, error) in
            if let user = userAuth {
                if password == user.password {
                    callback(userAuth)
                    return
                }
            }
            callback(nil)
        }
    }
    
    
}
