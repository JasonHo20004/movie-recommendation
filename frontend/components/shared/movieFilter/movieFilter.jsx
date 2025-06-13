'use client'
import './movieFilter.css'
import 'bootstrap/dist/css/bootstrap.min.css';
import FilterOptionsLine from '../filterOptionsLine/filterOptionsLine';
import {useState, useEffect} from 'react'

let filterOptions = [
    {
        title: "Quốc gia",
        options: [
            {option: "Việt Nam", isSelected: false},
            {option: "Trung Quốc", isSelected: false}
        ]
    },
    {
        title: "Loại phim",
        options: [
            {option: "Phim lẻ", isSelected: false},
            {option: "Phim bộ", isSelected: false}
        ]
    },
    {
        title: "Thể loại",
        options: [
            {option: "Anime", isSelected: false},
            {option: "Bí ẩn", isSelected: false},
            {option: "Chiến tranh", isSelected: false}
        ]
    },
    {
        title: "Năm sản xuất",
        options: [
            {option: "2025", isSelected: false},
            {option: "2024", isSelected: false},
            {option: "2023", isSelected: false},
            {option: "2022", isSelected: false},
            {option: "2021", isSelected: false},
            {option: "2020", isSelected: false}
        ]
    },
    {
        title: "Sắp xếp theo",
        options: [
            {option: "Mới nhất", isSelected: false},
            {option: "Điểm đánh giá", isSelected: false},
            {option: "Lượt xem", isSelected: false}
        ]
    }
]

function MovieFilter(){
    const [isFilterHover, setFilterHover] = useState(false)
    const [isFilterShow, setFilterShow] = useState(false)
    const [moviesFilterOptions, setmoviesFilterOptions] = useState(filterOptions)
    
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
                <div className='d-flex flex-column'>
                    {filterOptions.map((optionsLine, index)=>(
                        <FilterOptionsLine key={index} title={optionsLine.title} options={optionsLine.options}/>
                    ))}
                    <button className='filter-button'>Lọc kết quả</button>
                </div>
            </div>
        </div>
    )
}

export default MovieFilter