![SwiftUI](https://img.shields.io/badge/SwiftUI-blue.svg?style=flat)
![UIKIT](https://img.shields.io/badge/UIKIT-blue.svg?style=flat)
![Swift5.9](https://img.shields.io/badge/Swift_Version-5.9-green?logo=swift)
![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)
# Characters App 📱

**Characters App** is a Swift-based iOS application built using MVVM architecture. The app displays a list of characters with their details and allows filtering characters by their status: **Alive**, **Dead**, or **Unknown**. The app also includes a detailed view for individual characters.

---

## **Features**
- 📜 **List of Characters**: Displays a table view of all characters with their name, species, and status.
- 🔍 **Filter Options**: Filter characters by their status (**Alive**, **Dead**, **Unknown**).
- 🧍‍♂️ **Character Details**: View detailed information about a selected character, including:
  - Name
  - Species
  - Gender
  - Status
  - Location
  - Image

---

## **App Screenshots**
| **Characters List**                                                                                  | **Filter Options**                                                                                 | **Character Details**                                                                                  |
|------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| <img src="Images/characters-list.png" alt="Characters List" width="300" height="500">               | <img src="Images/filter-options.png" alt="Filter Options" width="300" height="500">              | <img src="Images/character-details.png" alt="Character Details" width="300" height="500">            |
| Displays a list of all characters, including their name, species, and status.                       | Allows filtering the list by character status (**All**, **Alive**, **Dead**, **Unknown**).         | Shows detailed information about a selected character, such as name, species, status, and location. |

---
## **How It Works**

### **1. Main View**
The main screen is a table view displaying all characters fetched from the API.

- Each row displays:
  - Character's name.
  - Character's species.
  - Character's status (color-coded badges for **Alive**, **Dead**, and **Unknown**).

### **2. Filter Characters**
Users can filter the list by selecting a status filter. The options include:
- **All**
- **Alive**
- **Dead**
- **Unknown**

### **3. Character Details**
On selecting a character from the list, a detail view is shown with the character's:
- Profile image.
- Name.
- Species.
- Status.
- Gender.
- Location.

---

## **Setup & Installation**

1. **Clone the Repository**
   ```bash
   git clone https://github.com/username/characters-app.git
   ```
2. **Open in Xcode**
   - Open the `.xcodeproj` or `.xcworkspace` file.
3. **Install Dependencies** (if applicable)
   resolve SPM
4. **Run the App**
   - Select a simulator or a connected device.
   - Click the **Run** button or press `⌘R`.

---
### **Architecture Overview**

#### **Data Layer**
This layer is responsible for fetching data from external sources (e.g., APIs, databases). It includes:
- **`CharactersApi`**: Handles API calls.
- **`CharactersRepository`**: Provides an interface between the API and the domain layer by handling data fetching and transforming raw API responses into domain models.

#### **Domain Layer**
This layer focuses on the business logic and ensures that the app adheres to clean architecture principles. It includes:
- **`CharactersDataSource`**: Defines the contract for data fetching.
- **`CharactersUseCase`**: Encapsulates the business logic and uses the repository to fetch or modify data as required.

#### **Presentation Layer**
This layer is concerned with the user interface and user interaction. It includes:
- **ViewModel**: Processes data provided by the domain layer into a format suitable for the view.
- **Views/Controllers**: Displays data and captures user interactions.

---

### **Refined Structure**

#### **Data Layer**
```swift
// CharactersApi.swift
protocol CharactersApiType {
    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersResponse
}

class CharactersApi: CharactersApiType {
    func fetchCharacters(parameters: CharacterParameters) async throws -> CharactersResponse {
        // API request implementation
    }
}

// CharactersRepository.swift
protocol CharactersRepositoryType {
    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersResponse
}

class CharactersRepository: CharactersRepositoryType {
    private let api: CharactersApiType

    init(api: CharactersApiType) {
        self.api = api
    }

    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersResponse {
        return try await api.fetchCharacters(parameters: parameters)
    }
}
```

#### **Domain Layer**
```swift
// CharactersDataSource.swift
protocol CharactersDataSourceType {
    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersResponse
}

class CharactersDataSource: CharactersDataSourceType {
    private let repository: CharactersRepositoryType

    init(repository: CharactersRepositoryType) {
        self.repository = repository
    }

    func getAllCharacters(parameters: CharacterParameters) async throws -> CharactersResponse {
        return try await repository.getAllCharacters(parameters: parameters)
    }
}

// MapCharactersUseCase.swift
struct MapCharactersUseCase {
    private let dataSource: CharactersDataSourceType

    init(dataSource: CharactersDataSourceType) {
        self.dataSource = dataSource
    }

    func execute(parameters: CharacterParameters) async throws -> [MainCharacter] {
        let response = try await dataSource.getAllCharacters(parameters: parameters)
        return response.characters
    }
}
```

#### **Presentation Layer**
The `CharactersViewModel` remains the same but interacts with `CharactersDataSource` through the `MapCharactersUseCase`.

---

### **Dependency Injection Graph**
```plaintext
Presentation Layer
   └── CharactersViewModel
         └── MapCharactersUseCase
               └── Domain Layer
                     └── CharactersDataSource
                           └── Data Layer
                                 ├── CharactersRepository
                                 │     └── CharactersApi
                                 └── CharactersService
```

---

### **Key Improvements**
1. **Factory Pattern for Initialization**: Create a `DependencyContainer` to manage dependencies and build the graph.
2. **Coordinator Pattern**: Use a BaseCoordinator to manage child coordinators and modularize navigation logic, ensuring scalability, reusability, and cleaner separation of concerns across app flows.
3. **swift-sourcery-templates**: Use Sourcery for advanced protocol mocking, type erasure, and code-generation to reduce boilerplate and speed up development.
.
---

## **Dependencies**

- `UIKit`: Used for building the UI.
- `SwiftUI`: Used for building the UI.
- `URLSession`: For API communication (depending on implementation).
- `Kingfisher`: For image downloading and caching.
- `Snapshot-Testing`: For snapshot views.
- `Netfox`: quick look on all executed network requests performed.
---

## **API Integration**
The app fetches data from the **Rick and Morty API**.
You will receive up to 20 documents per page

### **Endpoints**  
1. **Fetch All Characters**  
   - URL: `https://rickandmortyapi.com/api/character`  

2. **Filter Characters by Status**  
   - URL: `https://rickandmortyapi.com/api/character?page=1&status=<status>`  
   - Replace `<status>` with `alive`, `dead`, or `unknown`.  
   - Use `page` query parameter to paginate results.   
---

## **Future Enhancements**
- 🌎 **Connactivity** Show no internet Automatic if not internet.
- 🔥 **Favorites**: Allow users to mark characters as favorites.
- 📊 **Statistics**: Show stats for the number of alive, dead, and unknown characters.
- 🌑 **Dark Mode**: Support for system-wide dark mode.

---

## **Contributing**
Contributions are welcome! Feel free to:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a pull request.

---

## **License**
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.
