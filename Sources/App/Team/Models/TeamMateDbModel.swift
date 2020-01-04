//
//  TeamMateDbModel.swift
//  App
//
//  Created by Norman Sutorius on 02.01.20.
//

import FluentPostgreSQL
import Vapor

//final class TeamMateDbModel: PostgreSQLModel {
//    /// The unique identifier for this user.
//    var id: Int?
//    /// The user's full name.
//    var name: String
//    var surename: String
//    var image: File?
//    var isOut: Bool?
//    var assingedTrackId: Int?
//
//    /// Creates a new teammate.
//    init(id: Int? = nil, name: String, surename: String, image: File, isOut: Bool, assingedTrackId: Int) {
//        self.id = id
//        self.name = name
//        self.surename = surename
//        self.image = image
//        self.isOut = isOut
//        self.assingedTrackId = assingedTrackId
//    }
//}
//
//extension TeamMateDbModel: Content { }

struct TeamMateDbModel: PostgreSQLModel, Content, Migration, Parameter {
    var id: Int?
    var name: String
    var surename: String
    var image: Data?
    var isOut: Bool?
    var assignedTrackId: Int?
}

