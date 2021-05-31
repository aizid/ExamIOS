
import Foundation

protocol DialogSortAndFilterUseCase {
}

final class DefaultDialogSortAndFilterUseCase: DialogSortAndFilterUseCase {
    
    private let examRepository: ExamRepository
    
    init(examRepository: ExamRepository) {
        self.examRepository = examRepository
    }
    
}
