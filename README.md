# Gallery-app

## Description

The Image Searching App is an iOS application built with UIKit using `Unsplash API` and MVVM-archirecture to search images due to user's query. After entering a search query, on View displays a grid of images. Also there is implemented pagination to load more images as the user scrolls to the bottom of the screen. Each image might be noted as a favourite by tapping heart-shaped button. After that all favourites images stay in second tab. 
Each thumbnail image is tappable and lead to the Image Detail Screen. It shows the selected image in a larger view with additional details, such as the image title and description. It also allows the user to mark the image as a favourite by tapping a heart-shaped button. Implemented basic swipe gestures to navigate between images in the detail view.

## Key features
- **Search Images**: Users can search for images using keywords and view real-time results.
- **Pagination**: More images load dynamically as users scroll down.
- **Favorites Management**: Users can mark images as favorites using a heart-shaped button, and all favorite images are stored in a separate tab.
- **Image Detail View**: Tapping on an image opens a detailed view with additional information.
- **Swipe Gestures**: Users can swipe to navigate between images in the detail view.
- **Error Handling**: Displays appropriate alertController messages for empty searches or network issues.

## Architecture & Technologies Used
- **MVVM Architecture**: For clean code separation and better maintainability.
- **URLSession**: For fetching images asynchronously from the Unsplash API.
- **CoreData**: To store and manage favorite images and display them.
- **NotificationCenter**: Used for synchronizing favorites images across all views.

## Installation
1. To get started with this project, clone the repository to your local machine using the following command: `git clone https://github.com/victoriaSamsonovaaa/Gallery-app`
2. Open the project in Xcode.
3. Create a `APIKeys.xcconfig` file in the project root folder
4. Open APIKeys.xcconfig and add your Unsplash API key: `APIKey = your_API_key`.
   Note: Do not use quotes around the API key.

   ### How to get your access key:
   - [Unsplash](https://unsplash.com)
   - Create an Account
   - Click on "New Application"
   - Fill in Application Details
   - Once your application is created, you'll be taken to your app's page
   - Here you'll find your "Access Key" (which is your API key)
   - Copy it in paste in previous step
  
5. Under the **Info** tab, locate the **Configurations** section. For both *Debug* and *Release* set the configuration file to `APIKeys.xcconfig` file that contains the API key.
6. Build and run the project on your iOS simulator or physical device.





