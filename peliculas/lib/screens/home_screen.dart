import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
  
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Peliculas en cines'),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () => showSearch(context: context, delegate: MovieSeachDelegate()), 
                icon: const Icon(Icons.search_outlined))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            //Principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider
            MovieSlider(
                movies: moviesProvider.popularMovies, 
                onNextPage: () => moviesProvider.getPopularMovies(),
                title: 'Populares!')
          ],
        )));
  }
}
