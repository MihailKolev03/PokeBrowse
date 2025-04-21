//
//  CommunicationManager.swift
//  PokeBrowse
//
//  Created by Mihail Kolev on 21/04/2025.
//

import Alamofire
import Foundation

class CommunicationManager {
    let defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept-Language": "en"
    ]

    let sessionManager: Alamofire.Session

    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary

        sessionManager = Alamofire.Session(configuration: configuration)
    }

    func execute<A>(_ resource: Request<A>) async throws -> A {
        let response: DataResponse<A, AFError>

        if A.self is EmptyResponse.Type {
            let dataResponse = await sessionManager.request(resource.url,
                                                            method: resource.httpMethod,
                                                            parameters: resource.parameters,
                                                            encoding: resource.encoding,
                                                            headers: resource.headers)
                .validate()
                .serializingResponse(using: EmptyResponseSerializer())
                .response

            guard let typedResponse = dataResponse as? DataResponse<A, AFError> else {
                throw CustomError.unrecognized("Failed to cast DataResponse to expected type")
            }

            response = typedResponse
        } else {
            response = await sessionManager.request(resource.url,
                                                    method: resource.httpMethod,
                                                    parameters: resource.parameters,
                                                    encoding: resource.encoding,
                                                    headers: resource.headers)
                .validate()
                .serializingDecodable(A.self)
                .response
        }

        switch response.result {
        case let .success(data):
            return data
        case let .failure(error):
            throw error
        }
    }

    private struct EmptyResponseSerializer: ResponseSerializer {
        func serialize(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) throws -> EmptyResponse {
            if let error = error { throw error }
            return EmptyResponse()
        }
    }
}


extension CommunicationManager {
    struct Request<A: Decodable> {
        let url: String
        let httpMethod: HTTPMethod
        let headers: HTTPHeaders?
        let parameters: Parameters?
        let parse: (Data) throws -> A
        let encoding: ParameterEncoding

        init(_ url: String,
             httpMethod: HTTPMethod = .get,
             headers: HTTPHeaders? = nil,
             parameters: Parameters? = nil,
             encoding: ParameterEncoding = URLEncoding.default,
             parse: @escaping (Data) throws -> A) {
            self.url = url
            self.httpMethod = httpMethod
            self.headers = headers
            self.parameters = parameters
            self.parse = parse
            self.encoding = encoding
        }
    }
}

extension CommunicationManager.Request where A: Decodable {
    init(_ url: URLConvertible & HTTPMethodConvertible,
         headers: HTTPHeaders? = nil,
         encoding: ParameterEncoding = URLEncoding.default,
         parameters: Parameters? = nil) {
        self.init(url.url,
                  httpMethod: url.method,
                  headers: headers,
                  parameters: parameters,
                  encoding: encoding) { data in
            if data.isEmpty && A.self is EmptyResponse.Type,
               let emptyResponse = EmptyResponse() as? A {
                return emptyResponse.self
            }

            return try JSONDecoder().decode(A.self, from: data)
        }
    }
}

struct EmptyResponse: Decodable { }



extension CommunicationManager: GetPokemonListCommunication {
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        let endpoint = Constants.RequestEndpoint.getPokemonList(limit: limit, offset: offset)
        return try await execute(Request(endpoint,
                                         headers: nil))
    }
}

extension CommunicationManager: GetPokemonDetailCommunication {
    func getPokemonDetails(id: Int) async throws -> PokemonDetails {
        let endpoint = Constants.RequestEndpoint.getPokemonDetails(id: id)
        return try await execute(Request(endpoint,
                                         headers: nil))
    }
}

extension CommunicationManager: GetAllTypesCommunication {
    func getAllTypes() async throws -> TypeListResponse {
        let endpoint = Constants.RequestEndpoint.getAllTypes
        return try await execute(Request(endpoint,
                                         headers: nil))
    }
}

extension CommunicationManager: GetPokemonByTypeCommunication {
    func getPokemonByType(url: String) async throws -> TypeDetailResponse {
        let endpoint = Constants.RequestEndpoint.getPokemonByType(url: url)
        return try await execute(Request(endpoint,
                                         headers: nil))
    }
}
