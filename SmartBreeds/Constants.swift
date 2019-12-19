//
//  Constants.swift
//  SmartBreeds
//
//  Created by Roman Osadchuk on 19.12.2019.
//  Copyright © 2019 Roman Osadchuk. All rights reserved.
//

import Foundation

public struct ConstantsURL {
    public static let baseURL = "https://hidden-crag-71735.herokuapp.com"
    public static let breeds = "/api/breeds"
    public static func URLforBreed(breed: String) -> String {
        return "/api/\(breed)/images"
    }
}

