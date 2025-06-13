'use client'
import './movieFilter.css'
import 'bootstrap/dist/css/bootstrap.min.css';
import FilterOptionsLine from '../filterOptionsLine/filterOptionsLine';
import {useState, useEffect} from 'react'

function MovieFilter(){
    const [isFilterHover, setFilterHover] = useState(false)
    const [isFilterShow, setFilterShow] = useState(false)
    
    function changeFilterState(){
        if(!isFilterShow){
            setFilterShow(true)
        }
        else{
            setFilterShow(false)
        }
    }

    return(
        <div className="movie-filter" 
            onMouseEnter={()=>setFilterHover(true)} 
            onMouseLeave={()=>setFilterHover(false)}
            >
            <div className="filter-active d-flex flex-row align-items-center justify-content-start"
                onClick={changeFilterState}>
                <img className="filter-icon" src={isFilterShow? "https://cdn-icons-png.flaticon.com/128/566/566737.png" : "https://cdn-icons-png.flaticon.com/128/1159/1159884.png"} alt="filter" />
                <h4 className="filter-text" style={{color: isFilterHover ? 'orange' : 'black'}}>filter</h4>
            </div>
            <div className="filter-options p-4" style={{display: isFilterShow ? 'flex':'none'}}>
                <FilterOptionsLine title={"Quốc gia:"}/>
            </div>
        </div>
    )
}

export default MovieFilter