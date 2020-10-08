//
//  File.swift
//  
//
//  Created by Jéssica Araujo on 08/10/20.
//

import Fluent
import Vapor

final class Enigma: Model, Content {
    
    static let schema = "enigma"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "season_id")
    var season: Season
    
    @Parent(key: "midia_id")
    var midia: Midia
    
    @Field(key: "code")
    var code: String
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "midiaType")
    var midiaType: Int
    
    @Field(key: "tip")
    var tip: String
    
    @Field(key: "labelPTBR")
    var labelPTBR: String
    
    @Field(key: "labelUSAEN")
    var labelUSAEN: String
    
    init() { }

    init(id: UUID? = nil, seasonID: UUID, midiaID: UUID, code: String, title: String, midiaType: Int, tip: String, labelPTBR: String, labelUSAEN: String) {
        
        self.id = id
        self.$season.id = seasonID
        self.$midia.id = midiaID
        self.code = code
        self.title = title
        self.midiaType = midiaType
        self.tip = tip
        self.labelPTBR = labelPTBR
        self.labelUSAEN = labelUSAEN
    }
}
