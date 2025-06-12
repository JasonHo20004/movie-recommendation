'use client';
import TopNewMoviesTag from '../topNewMovieTag/topNewMovieTag.jsx';
import { Splide, SplideSlide } from '@splidejs/react-splide';
import '@splidejs/react-splide/css'; // Import CSS cho Splide

import './topNewMovies.css';

const movies = [
  { id: 1, title: 'Phim 1', image: "https://picsum.photos/200/300", rating: 9.0, year: 2023 },
  { id: 2, title: 'Phim 2', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
  { id: 3, title: 'Phim 3', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
  { id: 4, title: 'Phim 4', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
  { id: 5, title: 'Phim 5', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 }
];

function TopNewMovies() {
  return (
    <div>
        <div className="top-new-movies">
            <div>
                <h1 className='top-new-movies-topic firstPlace'>Phim Hàn Quốc mới</h1>
                <p>Xem toàn bộ ᐳ</p>
            </div>
            <div className="container">
                <Splide
                    options={{
                        perPage: 3,         // Số item hiển thị mỗi lần
                        //gap: '10px',        // Khoảng cách giữa các slide
                        autoplay: true,     // Tự động chạy
                        rewind: true,       // Lặp lại từ đầu
                    }}
                    >
                    {movies.map(movie => (
                        <SplideSlide key={movie.id}>
                            <TopNewMoviesTag movie={movie} />
                        </SplideSlide>
                    ))}
                </Splide>
            </div>
        </div>
        <div className="top-new-movies">
            <div>
                <h1 className='top-new-movies-topic seccondPlace'>Phim Trung Quốc mới</h1>
                <p>Xem toàn bộ ᐳ</p>
            </div>
            <div className="container">
                <Splide
                    options={{
                        perPage: 3,
                        autoplay: true,
                        rewind: true,
                    }}
                    >
                    {movies.map(movie => (
                        <SplideSlide key={movie.id}>
                            <TopNewMoviesTag movie={movie} />
                        </SplideSlide>
                    ))}
                </Splide>
            </div>
        </div>
        <div className="top-new-movies">
            <div>
                <h1 className='top-new-movies-topic thirdPlace'>Phim US-UK mới</h1>
                <p>Xem toàn bộ ᐳ</p>
            </div>
            <div className="container">
                <Splide
                    options={{
                        perPage: 3,
                        autoplay: true,
                        rewind: true,
                    }}
                    >
                    {movies.map(movie => (
                        <SplideSlide key={movie.id}>
                            <TopNewMoviesTag movie={movie} />
                        </SplideSlide>
                    ))}
                </Splide>
            </div>
        </div>
    </div>
  );
}

export default TopNewMovies;