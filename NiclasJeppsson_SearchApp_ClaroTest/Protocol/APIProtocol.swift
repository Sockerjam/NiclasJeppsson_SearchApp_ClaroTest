//
//  APIProtocol.swift
//  NiclasJeppsson_SearchApp_ClaroTest
//
//  Created by Niclas Jeppsson on 14/05/2021.
//

import Foundation

protocol API {
    func getData<T: Decodable>(url:String, resultType:T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
