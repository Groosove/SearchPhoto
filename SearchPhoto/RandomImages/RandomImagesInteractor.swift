//
//  RandomImages module
//  Created by Artur Lutfullin on 17/07/2021.
//

protocol RandomImagesBusinessLogic {
    func loadImages(request: RandomImages.Something.Request)
}

/// Класс для описания бизнес-логики модуля RandomImages
class RandomImagesInteractor: RandomImagesBusinessLogic {
    let presenter: RandomImagesPresentationLogic
    let provider: RandomImagesProviderProtocol

    init(presenter: RandomImagesPresentationLogic, provider: RandomImagesProviderProtocol = RandomImagesProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func loadImages(request: RandomImages.Something.Request) {
        provider.getItems { (items, error) in
            let result: RandomImages.RandomImagesRequestResult
            if let items = items {
                result = .success(items)
            } else if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentSomething(response: RandomImages.Something.Response(result: result))
        }
    }
}
