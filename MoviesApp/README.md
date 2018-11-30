
# API

I am using the [TheMovieDB](https://developers.themoviedb.org/3/getting-started/introduction) API consuming the [Now playing movies](https://developers.themoviedb.org/3/movies/get-now-playing) and the [Search movies](https://developers.themoviedb.org/3/search/search-movies)

# What did I do?

1. I am using MVP architecture because it is basically retrieving data from the server and displaying it.
2. I avoid to use third party libraries and preferred to build everything from scratch just to try things out. But If I had to use third party libraries I would have use cocoapods as a dependency manager.
3. I also avoid the use of storyboards and xibs and build the entire UI programatically with Autolayout. Although I know how to use both (Storyboards and xibs)
4. Infinite scrolling (with prefetch datasource) and Pull to refresh is included for the initial screen (now playing movies)
5. Search controller displaying filtered movies (Infinite scrolling not included)
6. Detail controller retrieves an image for specific size and siplays previously retrieved data from the server

# Testing

1. Unit testing is included for the services request
2. UI testing included just to test the navogation. There is no complex or weird behaviour to test out

# Results

|**Now playing movies**|**Movies detail**|**Pull to refresh**|**Search**|**Search result**|
|-|-|-|-|-|
|<img width="363" alt="beforeImage" src="https://user-images.githubusercontent.com/5926679/49296665-b47b0400-f497-11e8-8b41-fa8fe4b42672.png">|<img width="363" alt="afterImage" src="https://user-images.githubusercontent.com/5926679/49296668-b47b0400-f497-11e8-8f12-3e45abef2c00.png"/>|<img width="363" alt="afterImage" src="https://user-images.githubusercontent.com/5926679/49296670-b5139a80-f497-11e8-99d3-740399fa86e4.png"/>|<img width="363" alt="afterImage" src="https://user-images.githubusercontent.com/5926679/49296671-b5139a80-f497-11e8-9f63-ed39e1310399.png"/>|<img width="363" alt="afterImage" src="https://user-images.githubusercontent.com/5926679/49296672-b5139a80-f497-11e8-8a6c-377e81a06363.png"/>|
