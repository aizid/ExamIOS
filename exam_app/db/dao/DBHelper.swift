import Foundation
import SQLite3

class DBHelper {
    let dbPath: String = "core.sqlite"
    var db:OpaquePointer?
    
    
    init(){
        db = openDatabase()
        createTableAccountInfo()
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            return nil
        } else {
            return db
        }
    }
    
    func createTableAccountInfo() {
        let createTableString = "CREATE TABLE IF NOT EXISTS HeroesDetail(id INTEGER PRIMARY KEY, localized_name TEXT, primary_attr TEXT, attack_type TEXT, img TEXT, base_health INTEGER, base_mana INTEGER, base_attack_min INTEGER, base_attack_max INTEGER, base_str INTEGER, base_agi INTEGER, base_int INTEGER, attack_range INTEGER, move_speed INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                
            } else {
                
            }
        } else {
        }
        sqlite3_finalize(createTableStatement)
    }
    
//    func insertAccountInfo(id: Int) {
//        if readAccountInfoByAccNo(id: id) == id {
//            let insertStatementString = "UPDATE HeroesDetail SET accNo = ?, productId = ? WHERE accNo = ?;"
//            var insertStatement: OpaquePointer? = nil
//            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//                sqlite3_bind_text(insertStatement, 1, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 2, (productId as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 3, (accNo as NSString).utf8String, -1, nil)
//
//                if sqlite3_step(insertStatement) == SQLITE_DONE {
//
//                } else {
//
//                }
//            } else {
//
//            }
//            sqlite3_finalize(insertStatement)
//        } else {
//            let insertStatementString = "INSERT INTO HeroesDetail(id, localized_name, primary_attr, attack_type, img, base_health, base_mana, base_attack_min, base_attack_max, base_str, base_agi, base_int, attack_range, move_speed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
//            var insertStatement: OpaquePointer? = nil
//            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
//                sqlite3_bind_text(insertStatement, 1, (accNo as NSString).utf8String, -1, nil)
//                sqlite3_bind_text(insertStatement, 2, (productId as NSString).utf8String, -1, nil)
//
//                if sqlite3_step(insertStatement) == SQLITE_DONE {
//
//                } else {
//
//                }
//            } else {
//
//            }
//            sqlite3_finalize(insertStatement)
//        }
//
//        func readAccountInfo() -> [HeroesRes] {
//            let queryStatementString = "SELECT * FROM AccountInfo ORDER BY accNo ASC;"
//            var queryStatement: OpaquePointer? = nil
//            var psns : [HeroesRes] = []
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                while sqlite3_step(queryStatement) == SQLITE_ROW {
//                    let accNo = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
//                    let producId = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                    psns.append(AccountInfo(accNo: accNo, productId: producId))
//                }
//            } else {
//
//            }
//            sqlite3_finalize(queryStatement)
//            return psns
//        }
//
//        func readAccountInfoByAccNo(id: Int) -> Int {
//            let queryStatementString = "SELECT id FROM HeroesDetail WHERE id = ? LIMIT 1;"
//            var queryStatement: OpaquePointer? = nil
//            var psns : String = ""
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                sqlite3_bind_int64(queryStatement, 1, id, Int64(id))
//                while sqlite3_step(queryStatement) == SQLITE_ROW {
//                    let accNo = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
//                    psns = accNo
//                }
//            } else {
//
//            }
//            sqlite3_finalize(queryStatement)
//            return psns
//        }
//
//        func truncateAccountInfo() {
//            let queryStatementString = "DELETE FROM AccountInfo;"
//            var queryStatement: OpaquePointer? = nil
//            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
//                // Loop through the results and add them to the feeds array
//                while(sqlite3_step(queryStatement) == SQLITE_ROW) {
//                    // Read the data from the result row
//
//                }
//            } else {
//
//            }
//            sqlite3_finalize(queryStatement)
//        }
//
//    }
}
