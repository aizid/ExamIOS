import Foundation
import Alamofire

struct DataServices {
    
    // headerParamaters: ["Content-Type": "application/json"])
    
    //        let url: String = "http://103.9.124.54:6100api​/banks"
    //        if let encoded = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let urls = URL(string: encoded) {
    //            AF.request(urls)
    //                .validate()
    //                .response { (responseData) in
    //                    debugPrint(responseData)
    //                    guard let data = responseData.data else {return}
    //                    do {
    //                        let banks = try JSONDecoder().decode([BankResponse].self, from: data)
    //                        print(banks)
    //                        print("Berhasi while fetching remote rooms: ")
    //
    //                    } catch {
    //                        print("Error while fetching remote rooms: ")
    //
    //
    //                    }
    //            }
    //        }
    //    }
    
    
    // MARK: - GET
    static func getHeroesList() -> Endpoint<[HeroesRes]> {
        return Endpoint(path: "api/heroStats",
                        method: .get,
                        headerParamaters: ["Content-Type": "application/json"])
    }
    
    
    // static func getMoviePoster(path: String, width: Int) -> Endpoint<Data> {
    
    //     let sizes = [92, 154, 185, 342, 500, 780]
    //     let closestWidth = sizes.enumerated().min { abs($0.1 - width) < abs($1.1 - width) }?.element ?? sizes.first!
    
    //     return Endpoint(path: "t/p/w\(closestWidth)\(path)",
    //         method: .get,
    //         responseDecoder: RawDataResponseDecoder())
    // }
}
