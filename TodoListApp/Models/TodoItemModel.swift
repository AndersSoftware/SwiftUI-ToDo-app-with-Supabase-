
import Foundation

struct TodoItemModel: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case isCompleted = "is_completed"
        }
        
    // For creating new todos locally
    init(title: String, isCompleted: Bool = false) {
        self.id = UUID()
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // For todos coming from Supabase
    init(id: UUID, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}
