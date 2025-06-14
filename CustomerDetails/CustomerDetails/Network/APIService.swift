//
//  APIService.swift
//  CustomerDetails
//
//  Created by Mahesh TN on 14/06/25.
//

import Foundation

class APIService {
    private let baseURL = Constants.BASE_URL
    private let token = Constants.GOREST_API_TOKEN
    static let shared = APIService()
    private init() { }

    
    func makeRequest<T: Decodable>(to path: String,
                                           method: String = "GET",
                                           body: Data? = nil) async throws -> T {
        guard let url = URL(string: baseURL + path) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = body
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }

    func createCustomer(_ customer: APICustomer) async throws -> APICustomer {
        let encoded = try JSONEncoder().encode(customer)
        return try await makeRequest(to: "/users", method: "POST", body: encoded)
    }

    func updateCustomer(_ customer: APICustomer) async throws -> APICustomer {
        let encoded = try JSONEncoder().encode(customer)
        return try await makeRequest(to: "/users/\(customer.id)", method: "PUT", body: encoded)
    }

    func deleteCustomer(id: Int) async throws {
        _ = try await makeRequest(to: "/users/\(id)", method: "DELETE") as EmptyResponse
    }
}

struct EmptyResponse: Decodable {}
