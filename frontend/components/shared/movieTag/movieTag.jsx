import './movieTag.css'

function MovieTag({movie}){
    return(
        <div>
            <div className="movie-tag">
                <img className='movie-image' src={movie.image} alt=""/>
                <div className="movie-rating"></div>
                <div className="movie-title">{movie.title}</div>
            </div>
        </div>
    )
}

export default MovieTag;