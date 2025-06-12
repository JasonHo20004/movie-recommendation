import './topNewMovieTag.css'

function TopNewMoviesTag({movie}){
    return(
    <div>
        <div className="top-new-movie-tag">
            <img className='top-new-movie-image' src={movie.image} alt=""/>
            <div className="top-new-movie-rating"></div>
            <div className="top-new-movie-title">{movie.title}</div>
        </div>
    </div>
)}

export default TopNewMoviesTag