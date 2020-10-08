import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    print( Environment.get("DATABASE_HOST") )
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "rodrigo",
        password: Environment.get("DATABASE_PASSWORD") ?? "postgres",
        database: Environment.get("DATABASE_NAME") ?? "eNygma"
    ), as: .psql)

    app.migrations.add(CreateSeason())
    app.migrations.add(CreateMidia())
    app.migrations.add(CreateEnigma())
    
    try app.autoMigrate().wait()
    //try app.autoRevert().wait()
    
    // register routes
    try routes(app)
}
