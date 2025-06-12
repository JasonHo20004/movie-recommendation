'use client';
import TopTenMoviesTag from '../topTenMovieTag/topTenMovieTag.jsx';
import './topTenMovies.css';
import ScrollContainer from 'react-indiana-drag-scroll';

function TopTenMovies() {
  return (
    <div className="top-ten-movies">
        <h1>Top 10 phim bộ hôm nay</h1>
        <ScrollContainer 
        className="scroll-container"
        horizontal={true}
        vertical={false}
        hideScrollbars={true}
        >
            <div className="top-ten-movies-list">
                <TopTenMoviesTag movie={{ title: 'Phim 1', image:"https://picsum.photos/200/300", rank:1, rating: 9.0, year: 2023 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 2', image:"https://picsum.photos/200/300", rank:2, rating: 8.5, year: 2022 }} />    
                <TopTenMoviesTag movie={{ title: 'Phim 3', image:"https://picsum.photos/200/300", rank:3, rating: 8.0, year: 2021 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 4', image:"https://picsum.photos/200/300", rank:4, rating: 7.5, year: 2020 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 5', image:"https://picsum.photos/200/300", rank:5, rating: 7.0, year: 2019 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 6', image:"https://picsum.photos/200/300", rank:6, rating: 6.5, year: 2018 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 7', image:"https://picsum.photos/200/300", rank:7, rating: 6.0, year: 2017 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 8', image:"https://picsum.photos/200/300", rank:8, rating: 5.5, year: 2016 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 9', image:"https://picsum.photos/200/300", rank:9, rating: 5.0, year: 2015 }} />
                <TopTenMoviesTag movie={{ title: 'Phim 10', image:"https://picsum.photos/200/300", rank:10, rating: 4.5, year: 2014 }} />
            </div>
        </ScrollContainer>
    </div>
  );
}

export default TopTenMovies;