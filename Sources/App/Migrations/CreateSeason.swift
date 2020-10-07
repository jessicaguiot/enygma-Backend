import Fluent

struct CreateSeason: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("seasons")
            .id()
            .field("name", .string, .required)
            .field("theme", .string, .required)
            .field("background", .string)
            .field("soundTrackURL", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("seasons").delete()
    }
}
