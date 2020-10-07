import Fluent

struct CreateMidia: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema("midias")
            .id()
            .field("main", .string, .required)
            .field("secondary", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("midias").delete()
    }
}
