

import SwiftUI

struct ContentView: View {
    @StateObject private var todoStore = TodoListViewmodel()
    @State private var newTodoTitle = ""
    
    var body: some View {
            VStack {
                Text("TODO LIST")
                    .font(Font.title)
                    .bold()
                
                List {
                    ForEach(todoStore.todos) { todo in
                        TodoListItemView(todo: todo, toggleCompletion: { todo in
                            todoStore.toggleCompletion(for: todo)
                        })
                    }
                    .onDelete(perform: deleteTodos)

                }
                
                HStack {
                    TextField("Add new todo", text: $newTodoTitle)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        if !newTodoTitle.isEmpty {
                            todoStore.addTodo(title: newTodoTitle)
                            newTodoTitle = ""
                        }
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                    }
                }
                .padding()
            }

    }
    
    private func deleteTodos(offsets: IndexSet) {
        for index in offsets {
            todoStore.deleteTodo(id: todoStore.todos[index].id)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
