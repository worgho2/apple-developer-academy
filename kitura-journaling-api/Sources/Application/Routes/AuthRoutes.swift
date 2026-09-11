//
//  AuthRoutes.swift
//  Application
//
//  Created by otavio on 27/04/20.
//

import Foundation
import LoggerAPI
import Kitura
import Credentials
import CredentialsHTTP


func initializeBasicAuth(app: App) {
    let credentials = Credentials()
    
    let basicCredentials = CredentialsHTTPBasic { username, password, callback in
        
        UserAuth.find(id: username) { userAuth, error in
            if let user = userAuth {
                if password == user.password {
                    callback(UserProfile(id: username, displayName: username, provider: "HTTPBasic"))
                    return
                }
            }
            callback(nil)
        }
    }
    
    credentials.register(plugin: basicCredentials)
    
    app.router.all("/reflexion", middleware: credentials)
    app.router.all("/reflexion/all", middleware: credentials)
}
