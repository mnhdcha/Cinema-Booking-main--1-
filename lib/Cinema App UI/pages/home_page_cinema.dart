import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ui_design/Cinema%20App%20UI/consts.dart';
import 'package:flutter_ui_design/Cinema%20App%20UI/models/genre_model.dart';
import 'package:flutter_ui_design/Cinema%20App%20UI/models/movie_model.dart';
import 'package:flutter_ui_design/Cinema%20App%20UI/pages/detail_page.dart';

class HomePageCinema extends StatefulWidget {
  const HomePageCinema({super.key});

  @override
  State<HomePageCinema> createState() => _HomePageCinemaState();
}

class _HomePageCinemaState extends State<HomePageCinema> {
  late PageController controller;
  double pageOffset = 1;
  int currentIndex = 1;
  List<Genre> genres = [];
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: 1,
      viewportFraction: 0.6,
    )..addListener(() {
        setState(() {
          pageOffset = controller.page!;
        });
      });
    fetchGenres();
    fetchPopularMovies();
  }

  Future<void> fetchGenres() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=ef7488907498e873775290021f79b107&language=en-US'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> genreJson = data['genres'];
      setState(() {
        genres = genreJson.map((json) => Genre.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load genres');
    }
  }

  Future<void> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=ef7488907498e873775290021f79b107&language=vi-VN'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> movieJson = data['results'];
      setState(() {
        movies = movieJson.map((json) => Movie.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 35),
          _buildSearchField(),
          const SizedBox(height: 30),
          _buildGenreSection(),
          const SizedBox(height: 40),
          _buildMovieCarousel(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: appBackgroundColor,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildWelcomeText(),
            _buildUserProfile(),
          ],
        ),
      ),
    );
  }

  Column _buildWelcomeText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Welcome mduc ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                  color: Colors.white54,
                ),
              ),
              TextSpan(
                text: "👋",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Hãy thư giãn và xem phim!",
          style: TextStyle(
            height: 0.6,
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Container _buildUserProfile() {
    return Container(
      width: 40,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage("https://i.pinimg.com/564x/c7/7f/05/c77f0573dd1f073b37d35d77234f7bb0.jpg"),
        ),
      ),
    );
  }

  Padding _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 19),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          hintText: "Tìm kiếm",
          hintStyle: const TextStyle(
            color: Colors.white54,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 35,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGenreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thể loại",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Tất cả",
                    style: TextStyle(
                      fontSize: 13,
                      color: buttonColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: buttonColor,
                    size: 15,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 17),
          _buildGenreItems(),
        ],
      ),
    );
  }

  Row _buildGenreItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        genres.length,
        (index) => Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.05),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.category,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              genres[index].name,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildMovieCarousel() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Đang chiếu trong tháng này",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 30),
          _buildMoviePageView(),
        ],
      ),
    );
  }

  Expanded _buildMoviePageView() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index % movies.length;
              });
            },
            itemBuilder: (context, index) {
              return _buildMovieCard(index);
            },
          ),
          Positioned(
            top: 330,
            child: _buildPageIndicator(),
          ),
        ],
      ),
    );
  }

  GestureDetector _buildMovieCard(int index) {
    final movie = movies[index % movies.length];
    double scale = max(0.6, (1 - (pageOffset - index).abs() + 0.6));
    double angle = (controller.position.haveDimensions
            ? index.toDouble() - (controller.page ?? 0)
            : index.toDouble() - 1) *
        5;
    angle = angle.clamp(-5, 5);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailPage(movie: movie),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 100 - (scale / 1.6 * 100)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Transform.rotate(
              angle: angle * pi / 90,
              child: Hero(
                tag: movie.posterPath,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: _buildMovieDetails(movie),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildMovieDetails(Movie movie) {
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              movie.releaseDate,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        movies.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 8,
          width: index == currentIndex ? 20 : 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == currentIndex ? buttonColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}
