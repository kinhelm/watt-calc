# Watt Calc

Watt Calc is a Flutter application that helps users calculate the cost and time required to charge an electric vehicle battery.

## Features

- Input battery size (kWh)
- Input remaining battery percentage (%)
- Input price per kWh (€)
- Input charging power (kW)
- Calculate the kWh needed to reach 80% charge
- Calculate the total cost of charging
- Calculate the estimated charging time

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Android Studio or any preferred IDE

### Installation

1. Clone the repository:
    ```sh
    git clone <repository-url>
    ```
2. Navigate to the project directory:
    ```sh
    cd <project-directory>
    ```
3. Install dependencies:
    ```sh
    flutter pub get
    ```

### Running the App

1. Connect your device or start an emulator.
2. Run the app:
    ```sh
    flutter run
    ```

## Usage

1. Enter the battery size in kWh.
2. Enter the remaining battery percentage.
3. Enter the price per kWh in euros.
4. Enter the charging power in kW.
5. Press the button to calculate the kWh needed, total cost, and estimated charging time.

## Code Overview

### Main Files

- `lib/main.dart`: The main file containing the app logic and UI.

### Key Classes

- `WattCalc`: The main widget of the app.
- `WattCalcScreen`: The stateful widget that handles user input and calculations.

### Shared Preferences

The app uses `shared_preferences` to save and load user input data.

## License

This project is licensed under the MIT License - see the LICENSE file for details.