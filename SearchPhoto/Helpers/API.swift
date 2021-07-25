//
//  API.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 03.07.2021.
//

import Foundation

enum NetworkError: Error {
    case network
    case url
    case networkError(underlyingError: Error)
}

enum HttpMethod: String {
    case get = "GET"
}

enum Unsplash {
    static let baseURL = "https://api.unsplash.com"

	enum API {
		static let clientId = "4SdaT4avzkW98M_0IJfpBZkctWHFsDvytusV10nP-k0"
	}
	enum Methods {
		static let getImages = "/search/photos"
        static let getRandomImage = "/photos/random"
	}

}
