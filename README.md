


# Movies Database Application

## Overview

The Movies Database application is built using the TMDB API to show trending and now playing movies. The app allows users to search for movies, bookmark their favorite ones, and view a saved movies page. It also features offline functionality by saving responses in a local database, ensuring a seamless experience for users. Additionally, the app supports network calls to update search results as users type and includes a fake "deep link" feature to share movies within the app.

## Features

1. **Home Page**: Displays a list of trending and now playing movies fetched from the TMDB API.
2. **Movie Details Page**: Allows users to view detailed information about a selected movie.
3. **Bookmarking**: Users can bookmark movies to a saved movies page.
4. **Offline Functionality**: Saves movie data in a local database and loads it from there for offline use.
5. **Search**: Users can search for movies using the search tab.
6. **Debounced Search**: As users type in the search field, the results are updated after a brief delay, making network calls only when the user stops typing.
7. **Deep Linking (Andoroid only)**: Users can share movies with others, and the deep link will take them directly to the shared movie in the app.

## Technologies Used

* **Flutter**: Framework for building the application.
* **TMDB API**: Used to fetch trending, now playing, and search movie data.
* **Retrofit**: For networking and API calls.
* **MVVM Architecture**: To structure the app for maintainability and testability.
* **Repository Pattern**: For managing data and abstraction of data sources.
* **Local Database (Getstorage)**: For storing movie data offline.

## Architecture

The application follows the **MVVM** architecture pattern, separating the application logic into:

* **Model**: Represents the data, including movies.
* **View**: The UI components (widgets) displaying the data.
* **ViewModel**: Handles the logic and interacts with the model to prepare data for the view.

## Installation

### Prerequisites

1. Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
2. Android Studio or Visual Studio Code (with Flutter plugin) for code editing and debugging.
3. An active TMDB API key: [TMDB API](https://www.themoviedb.org/documentation/api)

### Steps to Set Up

1. Clone this repository:

   ```bash
   git clone <repository-url>
   cd movies-database-app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Add your TMDB API key in the configuration file:

   * Go to `lib/network/api.dart` and replace `<your-api-key>` with your TMDB API key.

4. Run the app:

   ```bash
   flutter run
   ```

## Screenshots

### Row 1:
![Simulator Screenshot 1](https://github.com/user-attachments/assets/99b1849e-87b6-46b5-9ebc-fbe1972c7b40)
![Simulator Screenshot 2](https://github.com/user-attachments/assets/3b5a3556-597c-4c68-b1d4-7ad8e03dc5d4)

### Row 2:
![Simulator Screenshot 3](https://github.com/user-attachments/assets/505dbf10-b20c-417a-b285-908830b46aec)
![Simulator Screenshot 4](https://github.com/user-attachments/assets/7a918389-b834-4bb1-aef8-ec678a8d169d)

### Row 3:
![Simulator Screenshot 5](https://github.com/user-attachments/assets/8fa84e7e-a28e-4432-a125-b28b249e2ce0)
![Screenshot 6](https://github.com/user-attachments/assets/17db5c54-912e-4f46-b68b-ced2ea7e2b35)





## Usage

1. **Home Page**: Displays trending and now playing movies.
2. **Search**: Type a movie name to search. The app will make network calls after a slight delay when the user stops typing.
3. **Bookmarking**: Users can bookmark movies, which will be saved in a local database and shown on the "Saved Movies" page.
4. **Offline Mode**: The app works offline by loading saved movie data from the local database.

## Compatibility

* **Android**: Tested on Android 10 and higher.
* **iOS**: Compatible with iOS 13.0 and above.
