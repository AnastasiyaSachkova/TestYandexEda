//
//  PlacesDataProvider.swift
//  test.yandex.eda
//
//  Created by Elis on 19.05.2020.
//  Copyright © 2020 MacMini Build. All rights reserved.
//

import UIKit

class PlacesDataProvider: NSObject {
    var placesData = PlacesDataManager()
//    var places = []
//    placesData.getPlaces { [weak self] result in
//    places = result
//    }
}

//MARK: - TableView DataSource Delegate
extension PlacesDataProvider: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesData.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesTVC.identifier) as? PlacesTVC else {
            return UITableViewCell()
        }
        cell.setData(with: placesData.places, index: indexPath.row)
        return cell
    }
}

