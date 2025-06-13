import 'bootstrap/dist/css/bootstrap.min.css';

function FilterOptionsLine({title, options}){
    return(
        <div className="options-line d-flex flex-column w-100">
            <div className="title-side">
                {title}
            </div>
            <div className="options-side">

            </div>
        </div>
    ) 
}

export default FilterOptionsLine