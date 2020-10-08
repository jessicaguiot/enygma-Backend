import Fluent
import Vapor

final class Season: Model, Content {
    
    static let schema = "seasons"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "theme")
    var theme: String
    
    @Field(key: "background")
    var background: String
    
    @Field(key: "soundTrackURL")
    var soundTrackURL: String
    
    @Children(for: \.$season)
    var enigmas: [Enigma]
    
    init() { }

    init(id: UUID? = nil, name: String, theme: String, background: String, soundTrackURL: String) {
        
        self.id = id
        self.name = name
        self.theme = theme
        self.background = background
        self.soundTrackURL = soundTrackURL
    }
}
