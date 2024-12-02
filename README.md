![SwiftUI](https://img.shields.io/badge/SwiftUI-blue.svg?style=flat)
![UIKIT](https://img.shields.io/badge/UIKIT-blue.svg?style=flat)
![Swift5.9](https://img.shields.io/badge/Swift_Version-5.9-green?logo=swift)
![Swift Package Manager](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)

# Characters App 📱

**Characters App** is a Swift-based iOS application built using MVVM architecture. The app displays a list of characters with their details and allows filtering characters by their status: **Alive**, **Dead**, or **Unknown**. The app also includes a detailed view for individual characters.

---

## **Table of Contents**

1. [Features](#features)  
2. [App Screenshots](#app-screenshots)  
3. [How It Works](#how-it-works)  
   - [Main View](#1-main-view)  
   - [Filter Characters](#2-filter-characters)  
   - [Character Details](#3-character-details)  
4. [Setup & Installation](#setup--installation)  
5. [Architecture Overview](#architecture-overview)  
   - [Data Layer](#data-layer)  
   - [Domain Layer](#domain-layer)  
   - [Presentation Layer](#presentation-layer)  
6. [Dependencies](#dependencies)  
7. [API Integration](#api-integration)  
8. [Future Enhancements](#future-enhancements)  
9. [Contributing](#contributing)  
10. [License](#license)  

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
Here’s a glimpse of the app’s UI:

| Feature                | Description                               | Screenshot                                |
|------------------------|-------------------------------------------|------------------------------------------|
| **Characters List**    | Displays a list of all characters.        | <img src="Images/characters-list.png" alt="Characters List" width="300" height="500"> |
| **Filter Options**     | Allows filtering characters by status.    | <img src="Images/filter-options.png" alt="Filter Options" width="300" height="500"> |
| **Character Details**  | Shows detailed information about a character. | <img src="Images/character-details.png" alt="Character Details" width="300" height="500"> |

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
   Resolve SPM.
4. **Run the App**
   - Select a simulator or a connected device.
   - Click the **Run** button or press `⌘R`.

---

## **Architecture Overview**

### **Data Layer**
Handles data fetching and transformation.

### **Domain Layer**
Encapsulates business logic and communicates with the data layer.

### **Presentation Layer**
Manages UI and user interactions.

---

## **Dependencies**

- `UIKit`: For building UI.
- `SwiftUI`: For building UI.
- `URLSession`: For API communication.
- `Kingfisher`: For image downloading and caching.
- `Snapshot-Testing`: For snapshot testing views.
- `Netfox`: For monitoring network requests.

---

## **API Integration**

### **Endpoints**  
1. **Fetch All Characters**  
   - URL: `https://rickandmortyapi.com/api/character`  

2. **Filter Characters by Status**  
   - URL: `https://rickandmortyapi.com/api/character?page=1&status=<status>`  
   - Replace `<status>` with `alive`, `dead`, or `unknown`.  
   - Use `page` query parameter to paginate results.   

---

## **Future Enhancements**

- 🌎 **Connectivity**: Show "No Internet" status automatically if offline.
- 🔥 **Favorites**: Allow users to mark characters as favorites.
- 📊 **Statistics**: Show stats for the number of alive, dead, and unknown characters.
- 🌑 **Dark Mode**: Support for system-wide dark mode.

---

## **Contributing**

Contributions are welcome!  
1. Fork the repository.  
2. Create a feature branch (`git checkout -b feature-branch`).  
3. Commit your changes (`git commit -m "Add new feature"`).  
4. Push to the branch (`git push origin feature-branch`).  
5. Create a pull request.

---

## **License**

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.
```
