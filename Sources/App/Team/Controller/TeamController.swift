//
//  TeamController.swift
//  App
//
//  Created by Norman Sutorius on 13.06.20.
//

import Vapor
import Foundation

class TeamController {
    
    func hello() -> String {
        return "hello"
    }
    
    func fetchAllOutTeamMates(req: Request) -> String {
        return "list"
    }
}
