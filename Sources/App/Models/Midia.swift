import Fluent
import Vapor

final class Midia: Model, Content {
    
    static let schema = "midias"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "main")
    var main: String
    
    @Field(key: "secondary")
    var secondary: String
    
    @Children(for: \.$midia)
    var enigmas: [Enigma]
    
    init() { }

    init(id: UUID? = nil, main: String, secondary: String) {
        
        self.id = id
        self.main = main
        self.secondary = secondary
    }
}
