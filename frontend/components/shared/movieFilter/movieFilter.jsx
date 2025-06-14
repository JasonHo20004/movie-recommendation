'use client'
import './movieFilter.css'
import 'bootstrap/dist/css/bootstrap.min.css';
import FilterSelectOptions from '../filterSelectOptions/filterSelectOptions';
import FilterSortByOptions from '../filterSortByOptions/filterSortByOptions';
import {useState, useEffect} from 'react'
import { Prev } from 'react-bootstrap/esm/PageItem';

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
    }
]

let filterSortByOptions =[
    {
        title: "Sắp xếp theo",
        options: [
            {option: "Mới nhất", isSelected: true},
            {option: "Điểm đánh giá", isSelected: false},
            {option: "Lượt xem", isSelected: false}
        ]
    }
]

function MovieFilter(){
    const [isFilterHover, setFilterHover] = useState(false)
    const [isFilterShow, setFilterShow] = useState(false)
    const [moviesFilterOptions, setmoviesFilterOptions] = useState(filterOptions)
    const [movieSortByOption, setMovieSortByOption] = useState(filterSortByOptions[0].options.find(opt => opt.isSelected))
    
    function changeFilterState(){
        if(!isFilterShow){
            setFilterShow(true)
        }
        else{
            setFilterShow(false)
        }
    }

    // useEffect(()=>{
    //     console.log(moviesFilterOptions)
    // },[moviesFilterOptions])

    function changeFilterOption(title, selectedOptions) {
        setmoviesFilterOptions(prevOptions => 
            prevOptions.map(group => {
                if (group.title === title) {
                    return {
                        ...group,
                        options: group.options.map(opt => ({
                            ...opt,
                            isSelected: selectedOptions.includes(opt.option)
                        }))
                    };
                }
                return group;
            })
        );
    }

    function changeSortByOption(option){
        setMovieSortByOption(option)
        console.log(option)
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
                        <FilterSelectOptions key={index} title={optionsLine.title} options={optionsLine.options} onClick={(changeFilterOption)}/>
                    ))}
                    {filterSortByOptions.map((optineLine, index)=>(
                        <FilterSortByOptions key={index} title={optineLine.title} options={optineLine.options} onClick={changeSortByOption} selectedOption={movieSortByOption.option}/>
                    ))}
                    <button className='filter-button'>Lọc kết quả</button>
                </div>
            </div>
        </div>
    )
}

export default MovieFilter