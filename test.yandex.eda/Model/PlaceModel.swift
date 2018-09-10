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
extension PlaceModel: Unboxable{
    init(unboxer: Unboxer) throws {
        payload = try? unboxer.unbox(key: "payload")
    }
    var foundPlaces: [FoundPlaceModel] {
        return payload?.foundPlaces ?? []
    }
}

struct PayloadModel{
    let foundPlaces: [FoundPlaceModel]?
}
extension PayloadModel: Unboxable{
    init(unboxer: Unboxer) throws {
        foundPlaces = try? unboxer.unbox(key: "foundPlaces")
    }
}

struct FoundPlaceModel{
    let place:Place?
    
}
extension FoundPlaceModel: Unboxable{
    init(unboxer: Unboxer) throws {
        place = try? unboxer.unbox(key: "place")
    }
}

struct Place{
    let id:Int?
    let name:String?
    let description:String?
    let picture:Picture?
}
extension Place: Unboxable{
    init(unboxer: Unboxer) throws {
        id = try? unboxer.unbox(key: "id")
        name = try? unboxer.unbox(key: "name")
        description = try? unboxer.unbox(key: "footerDescription")//description
        picture = try? unboxer.unbox(key: "picture")
    }
}

struct Picture{
    let uri:String?
}
extension Picture: Unboxable{
    init(unboxer: Unboxer) throws {
        uri = try? unboxer.unbox(key: "uri")
    }
}
