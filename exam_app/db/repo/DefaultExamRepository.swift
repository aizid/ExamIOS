import Foundation

final class DefaultExamRepository {
    
    private let dataTransferService: DataTransferService
    //    private let cache: ExamResponseStorage
    
    //    init(dataTransferService: DataTransferService, cache: ExamResponseStorage) {
    //        self.dataTransferService = dataTransferService
    //        self.cache = cache
    //    }
    
    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultExamRepository: ExamRepository {
    func getHeroesAll(completion: @escaping (Result<[HeroesRes], Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()
        
        let endpoint = DataServices.getHeroesList()
        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
            switch result{
            case .success(let responseDTO):
                completion(.success(responseDTO))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    //    func fetchImage(with imagePath: String, width: Int, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable? {
    //
    //        let endpoint = DataServices.getMoviePoster(path: imagePath, width: width)
    
}
