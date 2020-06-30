//
//  Picture.swift
//  test.yandex.eda
//
//  Created by Elis on 19.05.2020.
//  Copyright © 2020 MacMini Build. All rights reserved.
//

import Foundation
import Unbox

struct Picture {
    let uri: String?
}

extension Picture: Unboxable{
    init(unboxer: Unboxer) throws {
        uri = try? unboxer.unbox(key: "uri")
    }
}

