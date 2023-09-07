//
//  URLSession+.swift
//  HackerNews
//
//  Created by changlin on 2023/9/6.
//

import Foundation


extension URLSession {
    enum APIError: Error {
        case invalidURL
        case invalidCode(Int)
        case invalidData
    }
    func data(for urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await self.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else { throw APIError.invalidURL }
        guard 200...299 ~= response.statusCode else { throw APIError.invalidCode(response.statusCode) }
        return data
    }
}
