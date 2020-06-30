//
//  PlacesDataManager.swift
//  test.yandex.eda
//
//  Created by Elis on 19.05.2020.
//  Copyright © 2020 MacMini Build. All rights reserved.
//

import Unbox
protocol PlacesProtocol: class {
    func setupPlaces(manager: PlacesDataManager)
}
class PlacesDataManager {
    
  //  weak var delegate: PlacesProtocol?
    

    func getPlaces(completion: @escaping (([FoundPlaceModel]) -> Void)) {
        NetworkApi.performRequestWithCallBack(request: NetworkApi.urlRequest()) { [weak self] dict in
            guard let _ = self else { return }
            do {
                let data: PlaceModel = try unbox(dictionary: dict as UnboxableDictionary)
                completion(data.foundPlaces)
            } catch {
                completion([])
                print("Error: \(error.localizedDescription)")
            }
        }
      //  self.delegate?.setupPlaces(manager: self)
    }
}
