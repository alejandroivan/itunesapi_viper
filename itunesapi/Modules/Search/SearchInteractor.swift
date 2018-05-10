import Foundation
import CoreData
import Alamofire

final class SearchInteractor {
    weak var presenter: SearchPresenter!
}

// MARK: - Extensions -

extension SearchInteractor: SearchInteractorInterface {
    func fetchMedia(for term: String, page: Int) {
        let queryURL = searchURL(for: term, page: page)
        
        ApiClient.get(queryURL.absoluteString, success: { response in
            do {
                let searchNode = try JSONDecoder().decode(SearchNode.self, from: response)
                self.presenter.successFetching(medias: searchNode.results)
            } catch {
                self.presenter.failureFetching(error: error)
            }
        }) { error in
            self.presenter.failureFetching(error: error)
        }
    }
}




// MARK: - Search URL
extension SearchInteractor {
    func searchURL(for term: String, page: Int = 1) -> URL {
        var urlComponents = URLComponents(url: Constants.API.searchURL, resolvingAgainstBaseURL: true)!

        guard var queryItems = urlComponents.queryItems else {
            let termItem = URLQueryItem(name: "term", value: term)
            let pageItem = URLQueryItem(name: "offset", value: String((page - 1) * Constants.API.resultsPerPage))
            
            urlComponents.queryItems = [termItem, pageItem]
            return urlComponents.url!
        }
        
        let termItem = URLQueryItem(name: "term", value: term)
        let pageItem = URLQueryItem(name: "offset", value: String((page - 1) * Constants.API.resultsPerPage))

        queryItems.append(contentsOf: [termItem, pageItem])
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}




// MARK: - Core data
extension SearchInteractor {
    func saveLocalResults(for query: String, json: String) {
        deleteLocalResults(for: query) // Eliminar resultados anteriores (mantenemos un solo registro con el string JSON para cada query)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Searches", in: context)
        let results = NSManagedObject(entity: entity!, insertInto: context)
        
        results.setValue(query, forKey: "query")
        results.setValue(json, forKey: "json")
        
        try? context.save()
    }
    
    func fetchLocalResults(for query: String) -> [Media] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Searches")
        request.predicate = NSPredicate(format: "query = %@", query)
        request.returnsObjectsAsFaults = false

        var results: [Media] = []

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                guard let json = data.value(forKey: "json") as? String else {
                    continue
                }
                
                do {
                    if let jsonData = json.data(using: .utf8) {
                        results = try JSONDecoder().decode([Media].self, from: jsonData)
                    }
                } catch {
                    continue
                }
            }
        } catch {}
        
        return results
    }
    
    private func deleteLocalResults(for query: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Searches")
        request.predicate = NSPredicate(format: "query = %@", query)
        
        do {
            let result = try context.fetch(request)
            for object in result {
                let obj = object as! NSManagedObject
                context.delete(obj)
            }
            
            try context.save()
        } catch {}
    }
}




// MARK: - Response Models (Encodable)
extension SearchInteractor {
    struct SearchNode: Decodable {
        enum CodingKeys: String, CodingKey { case results }
        let results: [Media]
    }
}
