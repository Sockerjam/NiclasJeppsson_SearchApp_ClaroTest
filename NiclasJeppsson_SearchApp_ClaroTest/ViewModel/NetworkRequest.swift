//
//  NetworkRequest.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

class NetworkRequest{
    
}

extension NetworkRequest:API{
   
    func getData<T>(url: String, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
        guard let url = URL(string: url) else {
            print("Error initilising URL class")
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                print("ERROR 1")
                completion(.failure(error!))
                return
            }
            
            var decodedData:T?
            do{
                decodedData = try JSONDecoder().decode(resultType, from: data)
            }
            catch {
                print("ERROR 2")
                completion(.failure(error))
                return
            }
            
            guard let decodedResult = decodedData else {
                print("ERROR 3")
                completion(.failure(error!))
                return
            }
            
            completion(.success(decodedResult))
            
        }
        
        dataTask.resume()
        
    }
    
    
    
}
