//
//  PayloadModel.swift
//  test.yandex.eda
//
//  Created by Elis on 19.05.2020.
//  Copyright © 2020 MacMini Build. All rights reserved.
//

import Foundation
import Unbox

struct PayloadModel {
    let foundPlaces: [FoundPlaceModel]?
}
extension PayloadModel: Unboxable {
    init(unboxer: Unboxer) throws {
        foundPlaces = try? unboxer.unbox(key: "foundPlaces")
    }
}
