
import Foundation

protocol DetailUseCase {
}

final class DefaultDetailUseCase: DetailUseCase {
    
    private let examRepository: ExamRepository
    
    init(examRepository: ExamRepository) {
        self.examRepository = examRepository
    }
    
}
