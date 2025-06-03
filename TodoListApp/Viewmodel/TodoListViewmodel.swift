

import Foundation

class TodoListViewmodel: ObservableObject {
    @Published var todos: [TodoItemModel] = []
    private let supabaseService = SupabaseService.shared

    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        
        Task {
            do {
                todos = try await supabaseService.fetchTodos()
            } catch {
                print("Error loading todos: \(error)")
            }
        }
    }
    
    func toggleCompletion(for todo: TodoItemModel) {
        var updatedTodo = todo
        updatedTodo.isCompleted.toggle()
        
        Task {
            do {
                let serverTodo = try await supabaseService.toggleTodo(updatedTodo)
                
                if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                    todos[index] = serverTodo
                }
            } catch {
                print("Failed to update todo: \(error.localizedDescription)")
            }
        }
    }
    
    func addTodo(title: String) {
          let newTodo = TodoItemModel(title: title)
          
          Task {
              do {
                  let createdTodo = try await supabaseService.createTodo(newTodo)
                  todos.insert(createdTodo, at: 0)
              } catch {
                  print("Failed to add todo: \(error.localizedDescription)")
              }
          }
      }
    
    func deleteTodo(id: UUID) {
        Task {
            do {
                try await supabaseService.deleteTodo(id: id)
                
                todos.removeAll { $0.id == id }
            } catch {
                print("Failed to delete todo: \(error.localizedDescription)")
            }
        }
    }
}


/*
 
 
 import Foundation

 @MainActor
 class TodoListViewmodel: ObservableObject {
     @Published var todos: [TodoItemModel] = []
     @Published var isLoading = false
     @Published var errorMessage: String?
     
     private let supabaseService = SupabaseService.shared
     
     init() {
         loadTodos()
     }
     
     func loadTodos() {
         isLoading = true
         errorMessage = nil
         
         Task {
             do {
                 todos = try await supabaseService.fetchTodos()
             } catch {
                 errorMessage = "Failed to load todos: \(error.localizedDescription)"
                 print("Error loading todos: \(error)")
             }
             isLoading = false
         }
     }
     
     func addTodo(title: String) {
         let newTodo = TodoItemModel(title: title)
         
         // Optimistically add to local list
         todos.insert(newTodo, at: 0)
         
         Task {
             do {
                 let createdTodo = try await supabaseService.createTodo(newTodo)
                 // Replace the temporary todo with the real one from server
                 if let index = todos.firstIndex(where: { $0.id == newTodo.id }) {
                     todos[index] = createdTodo
                 }
             } catch {
                 // Remove the optimistic todo if creation failed
                 todos.removeAll { $0.id == newTodo.id }
                 errorMessage = "Failed to add todo: \(error.localizedDescription)"
             }
         }
     }
     
     func toggleCompletion(for todo: TodoItemModel) {
         var updatedTodo = todo
         updatedTodo.isCompleted.toggle()
         
         // Optimistically update local list
         if let index = todos.firstIndex(where: { $0.id == todo.id }) {
             todos[index] = updatedTodo
         }
         
         Task {
             do {
                 let serverTodo = try await supabaseService.updateTodo(updatedTodo)
                 // Update with server response
                 if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                     todos[index] = serverTodo
                 }
             } catch {
                 // Revert optimistic update if failed
                 if let index = todos.firstIndex(where: { $0.id == todo.id }) {
                     todos[index] = todo
                 }
                 errorMessage = "Failed to update todo: \(error.localizedDescription)"
             }
         }
     }
     
     func deleteTodo(id: UUID) {
         // Store the todo in case we need to restore it
         guard let todoToDelete = todos.first(where: { $0.id == id }) else { return }
         
         // Optimistically remove from local list
         todos.removeAll { $0.id == id }
         
         Task {
             do {
                 try await supabaseService.deleteTodo(id: id)
             } catch {
                 // Restore the todo if deletion failed
                 todos.append(todoToDelete)
                 errorMessage = "Failed to delete todo: \(error.localizedDescription)"
             }
         }
     }
 }
 
 
 */
