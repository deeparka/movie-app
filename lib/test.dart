import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:movie_app/movie.dart';
import 'package:movie_app/movie_ui.dart';

class MovieApp extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();
  /* final List movies = [
    "Titanic",
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "Avatar",
    "I Am Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings",
    "Vikings",
    "Vikings"
  ]; */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              movieCard(movieList[index], context),
              Positioned(
                top: 10.0,
                child: movieImage(movieList[index].images[0]),
              ),
            ],
          );
          /* return Card(
            elevation: 4.5,
            color: Colors.white,
            child: ListTile(
              leading: CircleAvatar(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        movieList[index].images[1],
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  child: null,
                ),
              ),
              trailing: Text("..."),
              //onTap: () => debugPrint("Movie name: ${movieL[index]}"),
              //Going to next route(page)
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                      movieName: movieList.elementAt(index).title,
                      movie: movieList.elementAt(index),
                    ),
                  ),
                );
              },
              title: Text(movieList[index].title),
              subtitle: Text("${movieList[index].title}"),
            ),
          ); */
        },
      ),
    );
  }

  Widget movieCard(Movie movie, BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60.0),
        width: MediaQuery.of(context).size.width,
        height: 120.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 54.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "Rating: ${movie.imdbRatin} / 10",
                        style: mainTextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Released: ${movie.released}",
                        style: mainTextStyle(),
                      ),
                      Text(
                        movie.runtime,
                        style: mainTextStyle(),
                      ),
                      Text(
                        movie.rated,
                        style: mainTextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              movieName: movie.title,
              movie: movie,
            ),
          ),
        ),
      },
    );
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 15.0, color: Colors.grey);
  }

  Widget movieImage(String imageurl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageurl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//New Route(Page or screen)
class MovieDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;

  const MovieDetails({Key? key, required this.movieName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      /*  body: Center(
        child: Container(
          // ignore: deprecated_member_use
          child: RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Back ${this.movie.director}"),
          ),
        ),
      ), */
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnails(thumbnail: movie.images[0]),
          MovieDetailsHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetsilsCast(movie: movie),
          HorizontalLine(),
          MovieExtraPosters(posters: movie.images),
        ],
      ),
    );
  }
}
