import Foundation
import Supabase

class SupabaseService: ObservableObject {
    static let shared = SupabaseService()
    let client: SupabaseClient
    
    private init() {
        let supabaseURL = URL(string: "https://saarqrycgjxqlmmefbsr.supabase.co")!
        let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhYXJxcnljZ2p4cWxtbWVmYnNyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg2MDc3NjQsImV4cCI6MjA2NDE4Mzc2NH0.BNBvtwmgGW6at1_WnFhnZ6FLu8KPFEzr1UQ2C8Y27OM"
        
        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey
        )
    }
        
    func fetchTodos() async throws -> [TodoItemModel] {
        let response: [TodoItemModel] = try await client
            .from("todos")
            .select()
            .execute()
            .value
        return response
    }
    
    func createTodo(_ todo: TodoItemModel) async throws -> TodoItemModel {
        let todoData = [
            "title": AnyJSON.string(todo.title),
            "is_completed": AnyJSON.bool(todo.isCompleted)
        ]
        
        let response: TodoItemModel = try await client
            .from("todos")
            .insert(todoData)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    func toggleTodo(_ todo: TodoItemModel) async throws -> TodoItemModel {
        let updateData = [
            "is_completed": AnyJSON.bool(todo.isCompleted)
        ]
        
        let response: TodoItemModel = try await client
            .from("todos")
            .update(updateData)
            .eq("id", value: todo.id)
            .select()
            .single()
            .execute()
            .value
        return response
    }
    
    func deleteTodo(id: UUID) async throws {
        try await client
            .from("todos")
            .delete()
            .eq("id", value: id)
            .execute()
    }
}
