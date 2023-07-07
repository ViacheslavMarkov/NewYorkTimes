//
//  NetworkRequestManager.swift
//  NYNetworking
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYUtilities

public final class NetworkRequestManager: NSObject {
    public static let shared = NetworkRequestManager()
    
    public let session = URLSession(configuration: .default)
    
    private override init() { super.init() }
    
    private func decodeData<ResponseObject: Decodable>(
        _ data: Data,
        dateFormatter: DateFormatter = .iso8601Full,
        completion: ((Result<ResponseObject, GenericError>) -> Void)?
    ) {
        var genericError: GenericError?
        do {
            let decoded = try JSONDecoder.decode(
                ResponseObject.self,
                data: data,
                dateFormatter: dateFormatter
            )
            DispatchQueue.main.async {
                completion?(.success(decoded))
            }
            return
        } catch let DecodingError.dataCorrupted(context) {
            genericError = .init(message: "Error: \(context.debugDescription)")
        } catch let DecodingError.keyNotFound(key, context) {
            genericError = .init(
                message: "Key '\(key)' not found: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch let DecodingError.valueNotFound(value, context) {
            genericError = .init(
                message: "Value '\(value)' not found: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch let DecodingError.typeMismatch(type, context)  {
            genericError = .init(
                message: "Type '\(type)' mismatch: \(context.debugDescription)",
                detailedDescription: "codingPath: \(context.codingPath)"
            )
        } catch {
            genericError = .init(
                message: "Error: \(error.localizedDescription)"
            )
        }
        
        guard let genericError = genericError else {
            assertionFailure("Generic error is nil when it shouldn't be.")
            return
        }
        DispatchQueue.main.async {
            completion?(.failure(genericError))
        }
    }
    
    public func call<RequestObject: Encodable, ResponseObject: Decodable> (
        _ api: API<RequestObject, ResponseObject>,
        completion: ((Result<ResponseObject, GenericError>) -> Void)?
    ) {
        guard let request = api.makeRequest() else {
            DispatchQueue.main.async {
                completion?(.failure(.init(message: "Could not make request.")))
            }
            return
        }
        
        session.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completion?(.failure(.init(message: error.debugDescription)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(.failure(.init(message: "Data is nil.")))
                }
                return
            }
            let mdata = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            print("RESPONSE - ", request, mdata)
            
            self.decodeData(data, completion: completion)
        }.resume()
    }
}
