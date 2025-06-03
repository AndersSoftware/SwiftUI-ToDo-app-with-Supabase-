
import SwiftUI

struct TodoListItemView: View {
    let todo: TodoItemModel
    let toggleCompletion: (TodoItemModel) -> Void
    
    var body: some View {
        HStack {
            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isCompleted ? .green : .gray)
                .onTapGesture {
                    toggleCompletion(todo)
                }
            
            Text(todo.title)
                .strikethrough(todo.isCompleted)
                .foregroundColor(todo.isCompleted ? .gray : .primary)
        }
        .padding(.vertical, 4)
    }
    
}
