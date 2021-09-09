//
//  ApiCallers.swift
//  spotify
//
//  Created by Naman Jain on 12/05/21.
//

import Foundation

class ApiCallers{
    static let shared = ApiCallers()
    
    private init(){}
    
    struct Constants{
        static let topHeadlinesUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=029d9fc6906b4056af623a91d70311e9")
    }
    
    enum ApiError: Error{
        case failedToGetData
        case successToGetData
    }
    
    public func getTopHeadlines(completion: @escaping (Result<ApiResponse,Error>)-> Void){
        guard let url = Constants.topHeadlinesUrl else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _ , err in
            if let error = err{
                completion(.failure(error))
            }else if let data = data{
                do{
                    let result = try JSONDecoder().decode(ApiResponse.self, from: data)
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
        
    }
    


    
    
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    
    
   
    
}
