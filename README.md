# HomeTest

## Application Screenshots

Here are some screenshots of the application:

### Home Screen
<img src="https://github.com/user-attachments/assets/577449d1-eb8e-4f92-b1d6-d47af3308ee3" alt="Home Screen" width="300"/>

### Home Screen With Filter
<img src="https://github.com/user-attachments/assets/6e8ef50c-0ec1-4c97-b795-d396e35f7a34" alt="Home Screen" width="300"/>

### Detail Screen
<img src="https://github.com/user-attachments/assets/1172feb2-0932-4d1d-a482-d2e374cf89f7" alt="Home Screen" width="300"/>


## Building and Running the Application

### Prerequisites
- Swift 5.3+
- iOS 15.0+
  

### Instructions
1. **Clone the Repository**
   ```bash
   git clone https://github.com/DevAmar1996/HomeTest.git

2. **Open the project**
open HomeTest.xcodeproj

3. **Build and Run**
- Select the target device (simulator or real device) and press Cmd + B to build the project.
- Press Cmd + R to run the project on the selected device.

4. **Running Tests**
- Unit Tests: Press Cmd + U to run the unit tests.

### Assumptions and Decisions
* Architecture: The app follows the MVVM (Model-View-ViewModel) architecture pattern.
* Networking: Network requests are managed using NetworkManager with URLSession. A protocol was defined to mock data for testing.
* UI Framework: The app is built using SwiftUI, with some UIKit components integrated using UIViewRepresentable.
* Data Handling: Codable is used for parsing JSON data.
* Generic Model: A generic model is implemented to fetch data, allowing for easy API expansion.
* NibLoadable: Custom views are loaded from nib files using the NibLoadable protocol for easy reuse and initialization.

 ### Challenges and Solutions
  1. Pagination:
  * Challenge: Ensuring smooth and efficient pagination without repeated requests.
  * Solution: Managed with a canPaginate flag to decide if there should be pagination and an isLoading flag (lock pattern) to prevent multiple simultaneous pagination requests.
  3. UI Integration:
 * Challenge: Integrating UIKit views within SwiftUI.
 * Solution: Used UIViewRepresentable to bridge UIKit components with SwiftUI and UIHostingController to present SwiftUI views within UIKit.
 4. Asynchronous Data Loading:
* Challenge: Handling asynchronous data loading and updating the UI accordingly.
 * Solution: Utilized Combine for reactive programming, ensuring all UI updates are performed on the main thread.
 5. Asynchronous Data Loading:
 * Challenge: Handling asynchronous data loading and updating the UI accordingly.
 * Solution: : Defined a NetworkError enum to represent different error states and updated the UI to show appropriate error messages.




