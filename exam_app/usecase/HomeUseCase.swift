import Foundation

protocol HomeUseCase {
    func getHeroesAll(completion: @escaping (Result<[HeroesRes], Error>) -> Void) -> Cancellable?
}

final class DefaultHomeUseCase: HomeUseCase {
    
    private let examRepository: ExamRepository
    
    init(examRepository: ExamRepository) {
        self.examRepository = examRepository
    }
    
    func getHeroesAll(completion: @escaping (Result<[HeroesRes], Error>) -> Void) -> Cancellable? {
        return examRepository.getHeroesAll(completion: { result in
            if case .success = result {
                completion(result)
            }
        })
    }
}

