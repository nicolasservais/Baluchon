//
//  KeyProtocol.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 11/10/2021.
//

import Foundation
// The key necessary to work with API is not include to the github Repository.
// You need to create a Key.swift file conform with this protocol.

protocol KeyProtocol {
    static var meteo: String { get } // Get this key on : https://openweathermap.org
    static var translate: String { get } // Get this key on : https://yandex.com/dev/translate/
    static var convert: String { get } // Get this key on : https://fixer.io
}
