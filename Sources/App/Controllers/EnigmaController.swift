//
//  File.swift
//  
//
//  Created by Jéssica Araujo on 08/10/20.
//

import Fluent
import Vapor

struct EnigmaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let enigmas = routes.grouped("enigmas")
        enigmas.get(use: index)
        enigmas.post(use: create)
        enigmas.group(":enigmaID") { enigma in
            enigma.delete(use: delete)
        }
    }

    func index(req: Request) throws -> EventLoopFuture<[Enigma]> {
        return Enigma.query(on: req.db).all()
    }

    func create(req: Request) throws -> EventLoopFuture<Enigma> {
        let enigma = try req.content.decode(Enigma.self)
        return enigma.save(on: req.db).map { enigma }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Enigma.find(req.parameters.get("enigmaID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
