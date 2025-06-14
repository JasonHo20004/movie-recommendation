'use client'
import 'bootstrap/dist/css/bootstrap.min.css';
import './filterSortByOptions.css'
import { useEffect, useState } from 'react';
import { Prev } from 'react-bootstrap/esm/PageItem';

function FilterOption({option, selectedOption, onClick}){
    return(
        <button className={`option${(selectedOption===option)?"-selected":""}`} onClick={()=>onClick(option.option)}>{option}</button>
    )
}

export default function FilterSortByOptions({title, options, selectedOption, onClick}){
    return(
        <div className="options-line d-flex flex-row w-100">
            <div className="title-side pe-2">
                {title}:
            </div>
            <div className="options-side d-flex flex-row">
                {(Array.isArray(options) ? options : []).map((option, index)=>(
                    <FilterOption 
                        key={index} 
                        option={option.option}
                        selectedOption={selectedOption}
                        onClick={()=>onClick(option)}
                        />
                ))}
            </div>
        </div>
    )
}