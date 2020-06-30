//
//  Place.swift
//  test.yandex.eda
//
//  Created by Elis on 19.05.2020.
//  Copyright © 2020 MacMini Build. All rights reserved.
//

import Unbox

struct Place {
    let id: Int?
    let name: String?
    let description: String?
    let picture: Picture?
}

extension Place: Unboxable {
    init(unboxer: Unboxer) throws {
        id = try? unboxer.unbox(key: "id")
        name = try? unboxer.unbox(key: "name")
        description = try? unboxer.unbox(key: "footerDescription")//description
        picture = try? unboxer.unbox(key: "picture")
    }
}
