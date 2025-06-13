'use client';
import ScrollContainer from 'react-indiana-drag-scroll';
import './listMovies.css'
import MovieTag from '../../shared/movieTag/movieTag'

function ListMovies({category}){
    return(
        <div>
            <h1>{category}</h1>
            <ScrollContainer 
            className="scroll-container"
            horizontal={true}
            vertical={false}
            hideScrollbars={true}
            >
                <div className="list-movies">
                    <MovieTag movie={{ title: 'Phim 1', image:"https://picsum.photos/200/300", rating: 9.0, year: 2023 }} />
                    <MovieTag movie={{ title: 'Phim 2', image:"https://picsum.photos/200/300", rating: 8.5, year: 2022 }} />    
                    <MovieTag movie={{ title: 'Phim 3', image:"https://picsum.photos/200/300", rating: 8.0, year: 2021 }} />
                    <MovieTag movie={{ title: 'Phim 4', image:"https://picsum.photos/200/300", rating: 7.5, year: 2020 }} />
                    <MovieTag movie={{ title: 'Phim 5', image:"https://picsum.photos/200/300", rating: 7.0, year: 2019 }} />
                    <MovieTag movie={{ title: 'Phim 6', image:"https://picsum.photos/200/300", rating: 6.5, year: 2018 }} />
                    <MovieTag movie={{ title: 'Phim 7', image:"https://picsum.photos/200/300", rating: 6.0, year: 2017 }} />
                    <MovieTag movie={{ title: 'Phim 8', image:"https://picsum.photos/200/300", rating: 5.5, year: 2016 }} />
                    <MovieTag movie={{ title: 'Phim 9', image:"https://picsum.photos/200/300", rating: 5.0, year: 2015 }} />
                    <MovieTag movie={{ title: 'Phim 10', image:"https://picsum.photos/200/300", rating: 4.5, year: 2014 }} />
                </div>
            </ScrollContainer>
        </div>
    )
}

export default ListMovies