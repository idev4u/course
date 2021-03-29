//
//  Track.swift
//  App
//
//  Created by Norman Sutorius on 20.07.19.
//

import Fluent
import Vapor

final class Track: Model, Content {
    init() { }
    
    static var schema: String = "Track"
        
    @ID(key: .id)
    var id: Int?
    var ContextOwner:TeamMateDbModel?
    var RotateInPerson:TeamMateDbModel?
    var name: String = ""
}
