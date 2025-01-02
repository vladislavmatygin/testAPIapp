import Foundation

public extension Task {
    // MARK: - Init

    typealias CompletionResult = (Result<Success, Failure>) -> Void

    init(_ operation: @escaping @Sendable (@escaping CompletionResult) async throws -> Void) where Failure == Error {
        self.init {
            let result: Success = try await withCheckedThrowingContinuation { continuation in
                Task<Void, Never> {
                    do {
                        try await operation {
                            continuation.resume(with: $0)
                        }
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
            }

            return result
        }
    }

    typealias CompletionSuccess = (Success) -> Void

    init(_ operation: @escaping @Sendable (@escaping CompletionSuccess) async -> Void) where Failure == Never {
        self.init {
            let result: Success = await withCheckedContinuation { continuation in
                Task<Void, Never> {
                    await operation {
                        continuation.resume(returning: $0)
                    }
                }
            }

            return result
        }
    }

    // MARK: - Mappers

    func then<S>(_ operation: @escaping @Sendable (Success) async throws -> S) -> Task<S, Failure> where Failure == Error {
        Task<S, Failure> {
            try await operation(value)
        }
    }

    func then<S>(_ operation: @escaping @Sendable (Success) async -> S) -> Task<S, Failure> where Failure == Never {
        Task<S, Failure> {
            await operation(value)
        }
    }

    func then<S>(_ operation: @escaping @Sendable (Success) -> Task<S, Failure>) -> Task<S, Failure> where Failure == Never {
        Task<S, Failure> {
            await operation(value).value
        }
    }

    func then<S>(_ operation: @escaping @Sendable (Success) -> Task<S, Failure>) -> Task<S, Failure> where Failure == Error {
        Task<S, Failure> {
            try await operation(value).value
        }
    }

    func recover(_ operation: @escaping @Sendable (Failure) async -> Success) -> Task<Success, Failure> where Failure == Error {
        Task<Success, Failure> {
            do {
                return try await value
            } catch {
                return await operation(error)
            }
        }
    }

    func mapError(
        _ operation: @escaping @Sendable (Failure) async throws -> Success
    ) -> Task<Success, Failure> where Failure == Error {
        Task<Success, Failure> {
            do {
                return try await value
            } catch {
                return try await operation(error)
            }
        }
    }

    static func all(_ tasks: [Task<Success, Failure>]) -> Task<[Success], Failure> where Failure == Error {
        Task<[Success], Failure> {
            try await withThrowingTaskGroup(of: Success.self) { group in
                for task in tasks {
                    group.addTask { try await task.value }
                }

                return try await group.reduce(into: [Success]()) { result, value in
                    result.append(value)
                }
            }
        }
    }

    static func all(_ tasks: [Task<Success, Failure>]) -> Task<[Success], Failure> where Failure == Never {
        Task<[Success], Failure> {
            await withTaskGroup(of: Success.self) { group in
                for task in tasks {
                    group.addTask { await task.value }
                }

                return await group.reduce(into: [Success]()) { result, value in
                    result.append(value)
                }
            }
        }
    }

    // MARK: - Subscribers

    @discardableResult
    func always(_ handler: @escaping @Sendable (Result<Success, Failure>) async -> Void) -> Self where Failure == Error {
        Task<Void, Never> {
            await handler(result)
        }

        return self
    }

    @discardableResult
    func fail(_ handler: @escaping @Sendable (Failure) async -> Void) -> Self where Failure == Error {
        Task<Void, Never> {
            do {
                _ = try await value
            } catch {
                await handler(error)
            }
        }

        return self
    }

    @discardableResult
    func done(_ handler: @escaping @Sendable (Success) async -> Void) -> Self {
        Task<Void, Never> {
            do {
                try await handler(value)
            } catch {
                return
            }
        }

        return self
    }
}

// MARK: - Additional API

public extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Int) async throws {
        try await sleep(nanoseconds: UInt64(seconds) * NSEC_PER_SEC)
    }

    static func sleep(seconds: UInt64) async throws {
        try await sleep(nanoseconds: seconds * NSEC_PER_SEC)
    }

    static func sleep(seconds: Double) async throws {
        try await sleep(nanoseconds: UInt64(seconds) * NSEC_PER_SEC)
    }
}
