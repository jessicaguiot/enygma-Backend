import Fluent
import Vapor

struct SeasonController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let seasons = routes.grouped("seasons")
        seasons.get(use: index)
        seasons.post(use: create)
        seasons.get(":id", use: read)
        seasons.group(":seasonID") { season in
            season.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Season]> {
        return Season.query(on: req.db).all()
    }
    
    func read(req: Request) throws -> EventLoopFuture<Season> {
        
        guard let id = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest)
        }
        
        return Season.find(id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { Season(id: $0.id, name: $0.name , theme: $0.theme, background: $0.background, soundTrackURL: $0.soundTrackURL) }
    }
 
    func create(req: Request) throws -> EventLoopFuture<Season> {
        let season = try req.content.decode(Season.self)
        return season.save(on: req.db).map { season }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Season.find(req.parameters.get("seasonID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
