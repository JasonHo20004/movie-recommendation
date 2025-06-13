import './listTopics.css'
import TopicTag from '../../shared/topicTag/topicTag';

function getRandomColor() {
    // Tạo mã màu hex ngẫu nhiên
    return '#' + Math.floor(Math.random()*16777215).toString(16).padStart(6, '0');
}

let topics=[
    "Marvel",
    "Sitcom",
    "Lồng tiếng cực mạnh",
    "Xuyên không",
    "Đỉnh nóc",
    "Xuyên không",
    "9x",
    "Cổ trang",
    "Tham vọng",
]

let displayTopics
if (topics.length>5){
    displayTopics = topics.slice(0,4)
    displayTopics[5] = `+${topics.length-4} chủ đề`
}
else{
    displayTopics = topics
}

displayTopics = displayTopics.map(topic => ({
    topic: topic,
    color: getRandomColor()
}));

function ListTopics(){
    return(
        <div className="list-topics">
            {displayTopics.map((item, index) => (
                <TopicTag topic={item.topic} key={index} color={item.color} />
            ))}
        </div>
    )
}

export default ListTopics;