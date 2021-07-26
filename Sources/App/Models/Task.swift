//
//  File.swift
//  
//
//  Created by 김찬우 on 2021/07/23.
//

import Vapor
import Fluent

final class Task: Model, Content {
    static let schema = "tasks"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "description")
    var description: String
    
    @Field(key: "dueDate")
    var dueDate: Double
    
    @Enum(key: "status")
    var status: Status
    
    init() { }
    
    init(id: UUID? = nil,
         title: String,
         description: String,
         dueDate: Double,
         status: Status) {
        self.id = id
        self.title = title
        self.description = description
        self.dueDate = dueDate
        self.status = status
    }
}

extension Task {
    enum Status: String, Codable {
        case TODO
        case DOING
        case DONE
    }
}

extension Task: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
        validations.add("content", as: String.self, is: !.empty)
        validations.add("dueDate", as: Date.self, is: .valid)
        validations.add("Status", as: String.self, is: .in("TODO", "DOING", "DONE"))
    }
}
