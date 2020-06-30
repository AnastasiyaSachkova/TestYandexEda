//
//  NetworkApi.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import Foundation

let serverURL = "https://eda.yandex/api/v2/catalog?latitude=55.762885&longitude=37.597360"
let imgURL = "https://eda.yandex"

class NetworkApi {
    
    static let shared = NetworkApi()

    class func urlRequest() -> URLRequest {
        let urlString = String(format:"%@", serverURL)
        let requestURL = URL(string:urlString)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        return request
    }
    
    class func performRequestWithCallBack(request: URLRequest, completion: @escaping([String: Any]) -> Void) {
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            if let _ = error {
                Snippets.rootToast(message: "Ошибка получения данных")
                completion([:])
                return
            }
            
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let dict = json as? [String: Any] {
                completion(dict)
            }
        }.resume()
    }
}
