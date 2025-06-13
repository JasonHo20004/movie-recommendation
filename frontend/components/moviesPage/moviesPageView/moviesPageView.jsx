'use client'
import MovieTag from "../../shared/movieTag/movieTag"
import MovieFilter from "../../shared/movieFilter/movieFilter";
import 'bootstrap/dist/css/bootstrap.min.css';
import { useState, useEffect } from "react";
import './moviesPageView.css'

const movies = [
    { title: 'Phim 1', image: "https://picsum.photos/200/300", rating: 9.0, year: 2023 },
    { title: 'Phim 2', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 3', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 4', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 5', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 6', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 7', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
    { title: 'Phim 8', image: "https://picsum.photos/200/300", rating: 5.5, year: 2016 },
    { title: 'Phim 9', image: "https://picsum.photos/200/300", rating: 5.0, year: 2015 },
    { title: 'Phim 10', image: "https://picsum.photos/200/300", rating: 4.5, year: 2014 },
    { title: 'Phim 11', image: "https://picsum.photos/200/300", rating: 9.0, year: 2023 },
    { title: 'Phim 12', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 13', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 14', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 15', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 16', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 17', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
    { title: 'Phim 18', image: "https://picsum.photos/200/300", rating: 5.5, year: 2016 },
    { title: 'Phim 19', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 20', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 21', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 22', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 23', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 24', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
    { title: 'Phim 25', image: "https://picsum.photos/200/300", rating: 9.0, year: 2023 },
    { title: 'Phim 26', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 27', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 28', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 29', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 30', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 31', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
    { title: 'Phim 32', image: "https://picsum.photos/200/300", rating: 5.5, year: 2016 },
    { title: 'Phim 33', image: "https://picsum.photos/200/300", rating: 5.0, year: 2015 },
    { title: 'Phim 34', image: "https://picsum.photos/200/300", rating: 4.5, year: 2014 },
    { title: 'Phim 35', image: "https://picsum.photos/200/300", rating: 9.0, year: 2023 },
    { title: 'Phim 36', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 37', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 38', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 39', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 40', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 41', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
    { title: 'Phim 42', image: "https://picsum.photos/200/300", rating: 5.5, year: 2016 },
    { title: 'Phim 43', image: "https://picsum.photos/200/300", rating: 8.5, year: 2022 },
    { title: 'Phim 44', image: "https://picsum.photos/200/300", rating: 8.0, year: 2021 },
    { title: 'Phim 45', image: "https://picsum.photos/200/300", rating: 7.5, year: 2020 },
    { title: 'Phim 46', image: "https://picsum.photos/200/300", rating: 7.0, year: 2019 },
    { title: 'Phim 47', image: "https://picsum.photos/200/300", rating: 6.5, year: 2018 },
    { title: 'Phim 48', image: "https://picsum.photos/200/300", rating: 6.0, year: 2017 },
];

let displayMovies = movies.slice(0,18);

const pageNumber = Math.ceil(movies.length/18)

function FilmPageView(){
    const [pageIndex, setPageIndex] = useState(1);
    
    if(pageIndex === pageNumber){
        displayMovies = movies.slice((pageIndex-1)*18,movies.length)
    }
    else{
        displayMovies = movies.slice(((pageIndex-1)*18),(pageIndex)*18)
    }

    function ViewPreviousPage(){
        if(pageIndex>1){
            setPageIndex(pageIndex-1)
        }
    }

    function ViewNextPage(){
        if(pageIndex<pageNumber){
            setPageIndex(pageIndex+1)
        }
    }
    return(
        <div className="film-page-view column-direct">
            <MovieFilter />
            <div className="film-list-view column-direct">
            <div className="film-grid">
                {displayMovies.map((displayMovies, index) => (
                <MovieTag key={index} movie={displayMovies} />
                ))}
            </div>
            <div className="page-change row-direct">
                <div className="arrow page-element" onClick={ViewPreviousPage}>⇦</div>
                <div className="page-number page-element row-direct">
                    <div className="page-index">
                        <input id='page-index-number' type="text" value={pageIndex} readOnly="true"/>
                    </div>
                    <p id="page-total-number">/{pageNumber}</p>
                </div>
                <div className="arrow page-element" onClick={ViewNextPage}>⇨</div>
            </div>
        </div>
        </div>
    )
}

export default FilmPageView