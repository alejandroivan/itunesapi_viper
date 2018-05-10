import Foundation
import Alamofire

class ApiClient {
    static var baseURL: URL {
        return Constants.API.searchURL
    }
    
    static func get(_ path: String, success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        let url: URLConvertible = URL(string: path, relativeTo: baseURL)!
        
        URLCache.shared.removeAllCachedResponses() // Alamofire no debe guardar caché, se hará manualmente con CoreData
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard let data = response.data else {
                failure(response.error)
                return
            }
            
            success(data)
        }
    }
    
    static func post(_ path: String, params: [String:Any], success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        let url: URLConvertible = URL(string: path, relativeTo: baseURL)!
        
        URLCache.shared.removeAllCachedResponses() // Alamofire no debe guardar caché, se hará manualmente con CoreData
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            guard let data = response.data else {
                failure(response.error)
                return
            }
            
            success(data)
        }
    }
}
