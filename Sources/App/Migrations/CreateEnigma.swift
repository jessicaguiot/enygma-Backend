//
//  File.swift
//  
//
//  Created by Jéssica Araujo on 08/10/20.
//

import Fluent

struct CreateEnigma: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("enigma")
            .id()
            .field("season_id", .uuid, .required)
            .field("midia_id", .uuid, .required)
            .foreignKey("midia_id", references: Midia.schema, .id)
            .foreignKey("season_id", references: Season.schema, .id)
            .field("code", .string, .required)
            .field("midiaType", .int8, .required)
            .field("tip", .string)
            .field("labelPTBR", .string, .required)
            .field("labelUSAEN", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("enigma").delete()
    }
}
