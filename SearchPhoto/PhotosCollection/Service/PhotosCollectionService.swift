//
//  Created by Artur Lutfullin on 03/07/2021.
//

import Foundation

typealias Handler = (Data?, URLResponse?, Error?) -> Void

protocol PhotosCollectionServiceProtocol {
    func getImages(with name: String, completion: @escaping (PhotosCollectionModel?, Error?) -> Void)
}

enum GetImagesError: Error {
	case network
	case url
	case decodeData
	case decodeJSON
}

/// Получает данные для модуля PhotosCollection
class PhotosCollectionService: PhotosCollectionServiceProtocol {
	private let session: URLSession = .shared
	private let decoder: JSONDecoder = JSONDecoder()

    func getImages(with name: String, completion: @escaping (PhotosCollectionModel?, Error?) -> Void) {
		var components = URLComponents(string: Unsplash.Methods.getImages)
		components?.queryItems = [
			URLQueryItem(name: "quer", value: name),
			URLQueryItem(name: "page", value: "1"),
			URLQueryItem(name: "per_page", value: "50"),
			URLQueryItem(name: "client_id", value: Unsplash.API.clientId)
		]
		guard let url = components?.url else { completion(nil, GetImagesError.url); return }
		var requset = URLRequest(url: url)
		requset.httpMethod = "GET"

		let handler: Handler = { rawData, response, _ in
			do {
				let data = try self.httpResponse(data: rawData, response: response)
				let objects = try self.decoder.decode(PhotosCollectionModel.self, from: data)
				completion(objects, nil)
			} catch let error as GetImagesError { completion(nil, error) } catch { completion(nil, GetImagesError.decodeJSON) }
		}
		session.dataTask(with: requset, completionHandler: handler).resume()
    }

	private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
		   guard let httpResponse = response as? HTTPURLResponse,
			   (200..<300).contains(httpResponse.statusCode),
				 let data = data else {
			   throw GetImagesError.network
		   }
		   return data
	   }
}
