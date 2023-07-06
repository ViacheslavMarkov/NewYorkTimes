//
//  GenericError.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 06.07.2023.
//

public protocol ErrorConforming: LocalizedError, CustomStringConvertible {
    var description: String { get }
    var errorDescription: String { get }
}

public struct GenericError: ErrorConforming {
    public let message: String
    public let detailedDescription: String?

    public var description: String {
        message
    }

    public var errorDescription: String {
        if let detailedDescription = detailedDescription {
            let errorMessage = "Error: \(message)"
            let detailedDescription = "Detailed description:\(detailedDescription)"
            return "\(errorMessage)\n\(detailedDescription)"
        } else {
            return "Error: \(message)"
        }
    }

    public init(
        message: String,
        detailedDescription: String? = nil
    ) {
        self.message = message
        self.detailedDescription = detailedDescription
    }
}
