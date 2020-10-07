import Fluent
import Vapor

struct MidiaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let midias = routes.grouped("midias")
        midias.get(use: index)
        midias.post(use: create)
        midias.group(":midiaID") { midia in
            midia.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Midia]> {
        return Midia.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Midia> {
        let midia = try req.content.decode(Midia.self)
        return midia.save(on: req.db).map { midia }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Midia.find(req.parameters.get("midiaID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
