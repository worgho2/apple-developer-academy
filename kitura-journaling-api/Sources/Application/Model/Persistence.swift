//
//  Persistence.swift
//  Application
//
//  Created by otavio on 23/04/20.
//

import Foundation
import SwiftKueryORM
import SwiftKueryPostgreSQL
import LoggerAPI

class Persistence {
    
    static func setup() {
        Log.info("PostgreSQL_connection setup started")
        
        let pool = PostgreSQLConnection.createPool (
            host: ProcessInfo.processInfo.environment["DBHOST"] ?? "localhost",
            port: 5432,
            options: [
                .databaseName("kituraServer"),
                .userName(ProcessInfo.processInfo.environment["DBUSER"] ?? "postgres"),
                .password(ProcessInfo.processInfo.environment["DBPASSWORD"] ?? "nil"),
            ],
            poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50, timeout: 10000)
        )
        
        Database.default = Database(pool)
        
        do {
            try Reflexion.createTableSync()
            Log.info("\(Reflexion.tableName) created")
        } catch let error {
            if let requestError = error as? RequestError, requestError.rawValue == RequestError.ormQueryError.rawValue {
                Log.info("\(Reflexion.tableName) already created")
            } else {
                Log.error(error.localizedDescription)
            }
        }
        
        do {
            try UserAuth.createTableSync()
            Log.info("\(UserAuth.tableName) created")
        } catch let error {
            if let requestError = error as? RequestError, requestError.rawValue == RequestError.ormQueryError.rawValue {
                Log.info("\(UserAuth.tableName) already created")
            } else {
                Log.error(error.localizedDescription)
            }
        }
        
        Log.info("PostgreSQL_connection setup ended")
    }
    
}
