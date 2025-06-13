import './topicTag.css'

function TopicTag({topic, color}){
    return(
        <div className="topic-tag" style={{backgroundColor: color}}>
            <h3>{topic}</h3>
            <p>Xem toàn bộ ᐳ</p>
        </div>
    )
}

export default TopicTag;