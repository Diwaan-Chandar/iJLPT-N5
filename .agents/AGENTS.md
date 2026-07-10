# JLPT-N5 Agent Rules

## Swift Code Style

### File Headers
- Every Swift file must start with the Xcode file header comment block:
  ```swift
  //
  //  FileName.swift
  //  JLPT-N5
  //
  ```
- No other comments unless strictly necessary (the reader knows how to code).

### Blank Lines Inside Type Bodies
- **No blank line immediately after an opening brace** (`{`) of a class, struct, enum, or protocol.
- **No blank line immediately before a closing brace** (`}`) of a class, struct, enum, or protocol.
- Empty lines *between* members (properties, methods) are fine and encouraged for grouping.

  **Correct:**
  ```swift
  class Foo {
      let x: Int

      func bar() { }
  }
  ```

  **Wrong:**
  ```swift
  class Foo {

      let x: Int

      func bar() { }

  }
  ```

### Indentation on Empty Lines (Xcode convention)
- Empty lines inside a type or function body carry the indentation of that scope.
- This matches Xcode's default behavior where the cursor stays indented when pressing Enter on a blank line inside a type body.

  **Correct (4-space indent on blank line between methods inside a class):**
  ```
  class Foo {
      func a() { }
  ····          ← 4 spaces here
      func b() { }
  }
  ```

### General
- No unnecessary inline comments — code should be self-explanatory.
- File header comments must be preserved.
- Use `async/await` exclusively. No completion handlers.

## Architecture (Clean Architecture / VIPER)

This project strictly adheres to Clean Architecture using the VIPER pattern.

### Concurrency & Threading
- **Background Threading**: All heavy lifting happens in the background. The `UseCase` base class explicitly uses `Task.detached { ... }` inside its `execute(request:)` method. This guarantees the subclass's `run()` logic is executed off the main thread.
- **No Module-Wide MainActor**: The project does **not** use `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor`. Standard Swift concurrency applies.
- **No nonisolated keyword**: We completely avoid the `nonisolated` keyword. Thread switching is handled purely via `Task.detached` falling back to the standard Swift cooperative pool.

### Domain Layer
- **Entities**: Structs (e.g. `Character`, `KanaRow`) mapping core data. Must conform to `Codable, Sendable`.
- **UseCases**: A generic `UseCase<Request, Response>` base class handles execution.
  - Subclasses must override `run(request:)` with business logic.
  - The Request struct, Response struct, and UseCase class must be **clubbed into a single file** (e.g., `GetHiraganas.swift`). Do not create separate files for them.

### Data Layer
- **Services**: The backend is divided into focused service classes (`NetworkService`, `DatabaseService`, `FileService`), each adhering to a strict `Contract` protocol.
- **DataManager**: Acts as the centralized wrapper/facade. UseCases only interact with the `DataManager`, which routes calls to the appropriate Services.
- **Mappers & Utils**: Logic for mapping data (like `DataMapper`) or hardcoded constants (like `DirectoriesUtil`) should be cleanly separated into the Data layer.

### UI Layer
- Contains View and Presenter.
- View is responsible only to display UI elements in screen. View has no knowledge.
- Presenter is responsible for the data to be given to the view.
- The UI must interact with the Domain layer solely by triggering UseCases.

- **View Implementation**: The `View` should use a generic `Presenter` type constrained by a specific protocol (e.g., `ViewPresenterContract`). It holds the presenter as an `@ObservedObject`.
- **Presenter Implementation**: The `Presenter` should be a class conforming to the presenter contract and `ObservableObject`. It uses `@Published` properties to expose state and data to the view.
- **Dependencies**: The `Presenter` should accept Domain Layer `UseCase`s via dependency injection in its initializer. It interacts with the Domain layer solely by triggering these use cases asynchronously.
- **Routing & View Contracts**: The `Presenter` may hold weak references to the View and Router protocols if needed for navigation or delegation, though SwiftUI `NavigationLink`s are often driven directly from the view using presenter state.
