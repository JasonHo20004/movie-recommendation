'use client';
import './topTenMovieTag.css'
import React, { useState, useRef } from 'react';

function TopTenMovieTag({ movie }) {
    const [showTooltip, setShowTooltip] = useState(false);
    const timeoutRef = useRef(null);

    const handleMouseEnter = () => {
        // Clear any existing timeout
        if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
        }
        // Set new timeout for 3 seconds
        timeoutRef.current = setTimeout(() => {
        setShowTooltip(true);
        }, 300);
    };

    const handleMouseLeave = () => {
        // Clear timeout if mouse leaves before 3 seconds
        if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
        }
        setShowTooltip(false);
    };

    // Cleanup timeout on component unmount
    React.useEffect(() => {
        return () => {
        if (timeoutRef.current) {
            clearTimeout(timeoutRef.current);
        }
        };
    }, []);

    //thêm class để hiển thị thứ tự chẵn lẻ
    let rankType;
    if (movie.rank%2 === 0) {
        rankType = 'even';
    } else {
        rankType = 'odd';
    }
    
    return (
        <div className="top-ten-movie-tag">
        <div className={`top-ten-movie-image-bg ${rankType}`}></div>
        <img className={`top-ten-movie-image ${rankType}`} src={movie.image} alt="" 
            // onMouseEnter={handleMouseEnter}
        />
        {showTooltip && (
        <div 
          className="tooltip-div"
          //onMouseLeave={handleMouseLeave}
        >
          {
            <h1>hi</h1>
          }
        </div>
      )}
        <div className="top-ten-movie-info">
            <h2>{movie.rank}</h2>
            <div className="top-ten-movie-details">
                <h4 className="top-ten-movie-title">{movie.title}</h4>
                <p className="top-ten-movie-rating">Rating: {movie.rating}</p>
                <p className="top-ten-movie-year">Year: {movie.year}</p>
            </div>
        </div>
        </div>
    );
}
export default TopTenMovieTag;