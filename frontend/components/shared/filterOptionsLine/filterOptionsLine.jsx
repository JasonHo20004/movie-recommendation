'use client'
import 'bootstrap/dist/css/bootstrap.min.css';
import './filterOptionsLine.css'
import { useEffect, useState } from 'react';

function FilterOption({option, isSelected, onClick, isAll}){
    
    // const[selectedClass, setSelectedClass] = useState('')
    // // const[isSelectedOption, setSelectedOption] = useState(isSelected)
    // const[isSelectedOption, setSelectedOption] = useState(isSelected)
    
    // useEffect(()=>{
    //     setSelectedClass(isSelectedOption ? '-selected' : '')
    // }, [isSelectedOption]);

    // function changeSelectedOption(){    
    //     setSelectedOption(!isSelectedOption);
    // }
    return(
        <button className={`option${isSelected?"-selected":""}`} onClick={()=>onClick(option, isAll)}>{option}</button>
    )
}

function FilterOptionsLine({title, options}){
    const [selectedOptions, setSelectedOptions] = useState([]);
    const [isAllSelected, setAllSelected] = useState(true)

    useEffect(()=>{
        if(selectedOptions.length===0){setAllSelected(true)}
    },[selectedOptions])

    function handleChangeSelectedClick(option, isAll){
        if(isAll){
            setAllSelected(true);
            setSelectedOptions([])
        }
        else{
            setAllSelected(false);
            if(selectedOptions.includes(option)){
                setSelectedOptions(selectedOptions.filter(item => item!== option));
            }else{
                setSelectedOptions([...selectedOptions,option])
            }
        }
    }

    return(
        <div className="options-line d-flex flex-row w-100">
            <div className="title-side pe-2">
                {title}:
            </div>
            <div className="options-side d-flex flex-row">
                <FilterOption 
                    option={'tất cả'} 
                    isSelected={isAllSelected}
                    onClick={handleChangeSelectedClick}
                    isAll={true}/>
                {(Array.isArray(options) ? options : []).map((option, index)=>(
                    <FilterOption 
                        key={index} 
                        option={option.option}
                        isSelected={selectedOptions.includes(option.option)}
                        onClick={handleChangeSelectedClick}
                        isAll={false}/>
                ))}
            </div>
        </div>
    ) 
}

export default FilterOptionsLine