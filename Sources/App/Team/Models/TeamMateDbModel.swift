//
//  TeamMateDbModel.swift
//  App
//
//  Created by Norman Sutorius on 02.01.20.
//

import Fluent
import Vapor

final class TeamMateDbModel: Model, Content, Encodable {
    init() { }
    
    static var schema: String = "TeamMateDbModel"
        
    @ID(key: .id)
    var id: Int?
    var name: String = ""
    var surename: String = ""
    var image: Data?
    @Field(key: "isOut")
    var isOut: Bool?
    @Field(key: "assignedTrackId")
    var assignedTrackId: Int?
}
