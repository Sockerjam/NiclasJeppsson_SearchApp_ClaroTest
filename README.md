# NiclasJeppsson_SearchApp_ClaroTest

This app is designed using the MVVM design pattern and Dependancy Inversion with the use of Protocols.

For this app I opted to using UICollectionViewCompositionalLayout Lists to display the search results and artist albums with images.
I use this approach over UITableViews because they are said to become deprecated in the future.

Together with the UICollectionViewCompositionalLayout Lists I use a Diffable Data Source and a Snapshot to generete the current state of the data.

The artist bio and info is displayed in UILabels that are subviews of a UIView.

I also took advantage of using a Generic function that is responsible for doing the network requests. Since I do a few network requests this helps
avoiding repetitive code.

Since Last.FM don't provide artist images (due to some policy change), I opted to use a simple placeholder image for the search result.

Future Improvements:

Improve the UI with valuable input from a UX designer.

Could link to artists on Spotify, Apple Music, etc
