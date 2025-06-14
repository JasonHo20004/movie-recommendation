'use client'
import 'bootstrap/dist/css/bootstrap.min.css';
import './filterSortByOptions.css'
import { useEffect, useState } from 'react';

function FilterOption({option, isSelected}){
    return(
        <button className={`option${isSelected?"-selected":""}`}>{option}</button>
    )
}

export default function FilterSortByOptions({title, options}){
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
                        isSelected={option.isSelected}/>
                ))}
            </div>
        </div>
    )
}