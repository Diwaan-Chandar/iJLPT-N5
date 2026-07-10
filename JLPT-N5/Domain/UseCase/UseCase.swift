//
//  UseCase.swift
//  JLPT-N5
//

import Foundation

protocol Request: Sendable {}

protocol Response: Sendable {}

class UseCase<R: Request, S: Response> {
    final func execute(request: R) async throws -> S {
        return try await Task.detached {
            return try await self.run(request: request)
        }.value
    }

    func run(request: R) async throws -> S {
        fatalError("Subclasses must override run(request:)")
    }
}
