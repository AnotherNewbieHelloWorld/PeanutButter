//
//  peanutButter.swift
//  PeanutButter
//
//  Created by Apple User on 18.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//
/*
import Foundation
import SQLite3

struct PeanutButter{
    let id: Int
    var name: String
    var taste: String
    var imageName: String
    var description: String
}

class PeanutManager {
    var database: OpaquePointer!
    static let main = PeanutManager()
    private init() {}
    
    func connect() {
        if database != nil {
            return
        }
        do {
            let databaseURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("peanuts.sqlite3")
            
            if sqlite3_open(databaseURL.path, &database) == SQLITE_OK{
                if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS peanuts (name TEXT, taste TEXT, imageName TEXT, description TEXT)", nil, nil, nil) == SQLITE_OK {
                }
                else { print("Could not create table") }
            }
            else { print("Could not connect") }
        }
        catch { print("Could not create database") }
    }
    
    
    func create(newName: String, newTaste: String, newImageName: String, newDescription: String) -> Int{
        connect()
        
        var statement: OpaquePointer!
        if sqlite3_prepare_v2(database, "INSERT INTO peanuts (name, taste, imageName, description) VALUES ('\(newName)', '\(newTaste)', '\(newImageName)', '\(newDescription)')", -1, &statement, nil) != SQLITE_OK {
            print("Could not create query")
            return -1
        }
        //execute the query
        if sqlite3_step(statement) != SQLITE_DONE{
            print("Could not insert peanutButter")
            return -1
        }
        // finalize it (can't use this pointer again)
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
    }
    
    // Get all of the contents from the database
    func getAllNotes() -> [PeanutButter] {
        connect()
        var statement: OpaquePointer!
        var result: [PeanutButter] = []
        // prepate the query
        if sqlite3_prepare_v2(database, "SELECT rowid, name, taste, imageName, description FROM peanuts", -1, &statement, nil) != SQLITE_OK{
            print("Error creating select")
            return []
        }
        // execute the query (this time need to read all available rows)
        while sqlite3_step(statement) == SQLITE_ROW {
            result.append(PeanutButter(id: Int(sqlite3_column_int(statement, 0)), name: String(cString: sqlite3_column_text(statement, 1)), taste: String(cString: sqlite3_column_text(statement, 2)), imageName: String(cString: sqlite3_column_text(statement, 3)), description: String(cString: sqlite3_column_text(statement, 4))))
        }
        // cleanup behind the scenens
        sqlite3_finalize(statement)
        return result
    }
    
    func save(peanutButter: PeanutButter){
        connect()
        var statement: OpaquePointer!
        
        if sqlite3_prepare_v2(database, "UPDATE peanuts SET name = ?, taste = ?, imageName = ?, description = ? WHERE rowid = ?", -1, &statement, nil) != SQLITE_OK{
            print("Error creating update statement")
            return
        }
        // to bind data to this query
        sqlite3_bind_text(statement, 1, NSString(string: peanutButter.name).utf8String, -1, nil)
        sqlite3_bind_text(statement, 2, NSString(string: peanutButter.taste).utf8String, -1, nil)
        sqlite3_bind_text(statement, 3, NSString(string: peanutButter.imageName).utf8String, -1, nil)
        sqlite3_bind_text(statement, 4, NSString(string: peanutButter.description).utf8String, -1, nil)
        sqlite3_bind_int(statement, 5, Int32(peanutButter.id))
        
        // execute
        if sqlite3_step(statement) != SQLITE_DONE{
            print("Error running update")
        }
        
        // finalize
        sqlite3_finalize(statement)
    }
    
    func delete() {
        connect()
        var statement: OpaquePointer!
        // DROP TABLE, DELETE FROM
        if sqlite3_prepare_v2(database, "DROP TABLE peanuts", -1, &statement, nil) != SQLITE_OK{
            print("Error creating delete statement")
            return
        }
        //execute the query
        if sqlite3_step(statement) != SQLITE_DONE{
            print("Could not delete peanutButter")
            return
        }
        // finalize it (can't use this pointer again)
        sqlite3_finalize(statement)
    }
}
*/
