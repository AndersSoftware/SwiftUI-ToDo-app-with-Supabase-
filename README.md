# SwiftUI Todo App with Supabase Backend
A complete, production-ready todo application built with SwiftUI and Supabase, demonstrating modern iOS development patterns and cloud backend integration.
## 📱 Features

Complete CRUD Operations - Create, read, update, and delete todos

Real-time Synchronization - Instant updates across all devices

Cloud Storage - Todos saved to PostgreSQL database via Supabase

MVVM Architecture - Clean, scalable code organization

Modern SwiftUI Design - Following Apple's Human Interface Guidelines


## 🏗️ Architecture
This project implements the MVVM (Model-View-ViewModel) pattern for clean separation of concerns

### Key Components

TodoItemModel: Data model with Codable support for Supabase integration

TodoListViewModel: Business logic and state management with @Published properties

SupabaseService: Dedicated service layer for all backend communication

ContentView: SwiftUI interface with reactive UI updates


## 🚀 Getting Started
Prerequisites

Xcode 14.0+

iOS 15.0+

Swift 5.5+

Supabase account (free at supabase.com)
