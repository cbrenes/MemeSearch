# MemeSearch

## Requeriments
Xcode 10.1
iOS 12.1
Cocoa pods version 1.6.0.beta.1


## Setup
This project was developed using cocoa pods
The information of how to install it can be found here: https://guides.cocoapods.org/using/getting-started.html

Once cocoa pods is installed, open the terminal and go the root directory of the project. This address has a file called Podfile. Execute the command 'pod install' and wait until all the process is completed

When the process finished the directory should have a new file called MemeGenerator.xcworkspace, this will be the file used to open the project

If you want to run the app in a real device is necessary to set a provisional profile for this, the easy way is to select the check Automatically manage signing option in the target screen and then select the team wished.


## Third libraries used
##### Kingfisher
https://github.com/onevcat/Kingfisher
Kingfisher is a lightweight, pure-Swift library for downloading and caching images from the web.

##### Alamofire
https://github.com/Alamofire/Alamofire
Alamofire is an HTTP networking library written in Swift.

##### R.swift
https://github.com/mac-cain13/R.swift
Get strong typed, autocompleted resources like images, fonts and segues in Swift projects

##### JGProgressHUD
https://github.com/JonasGessner/JGProgressHUD
An elegant and simple progress HUD for iOS and tvOS.

##### Obfuscator
This library is used to encrypt the key of the API
You can find more information about this logic here: https://medium.com/swift2go/increase-the-security-of-your-ios-app-by-obfuscating-sensitive-strings-swift-c915896711e6

##### SwiftLint
https://github.com/realm/SwiftLint
A tool to enforce Swift style and conventions, loosely based on GitHub's Swift Style Guide.

## Architecture
The project was created using the clean swift architecture, you can find more information about this here:https://clean-swift.com

## Error Handle
The app has a scene to control all the errors that could happen.

## How it works
This is a meme search app, the user can search for any meme in the API and then the app will show the results

## Unit Testing
The project has covered the two scenes ErrorHandle and MemesSearch

## Other Information
The app has the repository model extructure for this reason the folder Services has two files.
The file called MemesMemory.swift was created for testing






