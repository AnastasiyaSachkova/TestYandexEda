//
//  PlaceModel.swift
//  test.yandex.eda
//
//  Created by MacMini Elis on 07/09/2018.
//  Copyright © 2018 MacMini Build. All rights reserved.
//

import Unbox

struct PlaceModel {
    let payload: PayloadModel?
}

extension PlaceModel: Unboxable {
    init(unboxer: Unboxer) throws {
        payload = try? unboxer.unbox(key: "payload")
    }
    var foundPlaces: [FoundPlaceModel] {
        return payload?.foundPlaces ?? []
    }
}
