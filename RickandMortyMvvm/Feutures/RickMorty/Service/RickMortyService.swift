//
//  RickMortyService.swift
//  RickandMortyMvvm
//
//  Created by Pınar Macit on 30.05.2022.
//

import Alamofire

enum RickMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    static func charecterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickMortyService {
    
    func fetchAllDatas(response:@escaping ([Result]?) -> Void)
    
}

struct RickMortyService: IRickMortyService {
    func fetchAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndPoint.charecterPath()).responseDecodable(of: PostModel.self) { (model) in
            
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
    
    
}
