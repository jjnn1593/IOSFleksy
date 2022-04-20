# Fleksy - IOS
## Description
Application developed entirely in IOS, using Swift 5, SwiftUI and Combine. The app shows a list of the most popular movies from Themoviedb: https://developers.themoviedb.org/

## VIP - CLEAN ARCHITECTURE
The app contains a VIP architecture, this favors the low coupling between the different layers and increases the robustness of the tests of each layer. Their communication is unidirectional as shown in the graph: 

![alt text](https://github.com/jjnn1593/IOSFleksy/blob/main/VIP.png)

### Functionalities
- Shows the popular movies
- Shows the rating of each film
- Infinite load of films
- Pagination in calls to the server
- Detail view of each selected movie
- Viewing a carousel with similar films


