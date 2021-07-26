# ImageGallery

Simple image gallery application created with swift 5 & iOS 14.5


## How to run the project

- Go to folder ImageGallery
- Open or double click ImageGallery.xcodeproj

## Project structre

- Utils : Contains classes & structs of alert, constants, use defined parameters

- Service : 
	-	APIService class
	- function getImagesWithUrl needs the url parameter customized with user inputs
	- Url is stored to the userdefined settings that under project butild settings with key IMAGE_URL
	
- ViewModel : Contains class with parameters & also function to get the image url

- Model : Contains Decodable class to get the API data 

- View : Contains collection view cell & controller to display actual output

## Implementation 
- By defult search is already set 'kittens'
- Pagination also implemented when user scrolls to the bottom
- Failure conditions managed by showing alert
- Needs required search parameter to get the images data


