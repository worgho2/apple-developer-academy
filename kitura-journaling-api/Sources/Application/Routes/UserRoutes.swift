//
//  UserRoutes.swift
//  Application
//
//  Created by otavio on 27/04/20.
//

import Foundation
import LoggerAPI
import Kitura

func initializeUserRoutes(app: App) {
    app.router.post("/user",handler: createUser)
    app.router.get("/user", handler: readAllUsers)
    app.router.delete("/user", handler: deleteUser)
}

func createUser(user: UserAuth, respondWith: @escaping(UserAuth?, RequestError?) -> Void) {
    user.save(respondWith)
}

func readAllUsers(respondWith: @escaping([UserAuth]?, RequestError?) -> Void) {
    UserAuth.findAll(respondWith)
}

func deleteUser(user: UserAuth, id: String, respondWith: @escaping(RequestError?) -> Void) {
    if user.id != id {
        respondWith(nil)
    } else {
        UserAuth.delete(id: id, respondWith)
    }
}
