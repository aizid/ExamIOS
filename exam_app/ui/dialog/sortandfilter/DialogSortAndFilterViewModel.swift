import Foundation

struct DialogSortAndFilterViewModelClosures {
}

enum DialogSortAndFilterViewModelLoading {
    case fullScreen
}

protocol DialogSortAndFilterViewModelInput {
    
}

protocol DialogSortAndFilterViewModelOutput {
    var sortCondition: Int { get }
    var filterCondition: Int { get }
    var sortBy: Int { get }
    
    var loading: Observable<DialogSortAndFilterViewModelLoading?> { get }
    var screenTitle: String { get }
}

protocol DialogSortAndFilterViewModel: DialogSortAndFilterViewModelInput, DialogSortAndFilterViewModelOutput { }

final class DefaultDialogSortAndFilterViewModel: DialogSortAndFilterViewModel {
    
    private let dialogSortAndFilterUseCase: DialogSortAndFilterUseCase
    private let closures: DialogSortAndFilterViewModelClosures?
    internal let sortCondition: Int
    internal let filterCondition: Int
    internal let sortBy: Int

    private var dialogSortAndFilterLoadTask: Cancellable? { willSet { dialogSortAndFilterLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let loading: Observable<DialogSortAndFilterViewModelLoading?> = Observable(.none)
    let screenTitle = NSLocalizedString("DialogSortAndFilter", comment: "")
    
    init(dialogSortAndFilterUseCase: DialogSortAndFilterUseCase,
         closures: DialogSortAndFilterViewModelClosures? = nil, sortCondition: Int, filterCondition: Int, sortBy: Int) {
        self.dialogSortAndFilterUseCase = dialogSortAndFilterUseCase
        self.closures = closures
        self.sortCondition = sortCondition
        self.filterCondition = filterCondition
        self.sortBy = sortBy
    }
}

// MARK: - INPUT. View event methods
extension DefaultDialogSortAndFilterViewModel {

    func viewDidLoad() { }

    func didCancel() {
        dialogSortAndFilterLoadTask?.cancel()
    }
    
}
