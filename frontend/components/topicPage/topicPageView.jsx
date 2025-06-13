import './topicPageView.css'
import TopicTag from '../shared/topicTag/topicTag';

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

topics = topics.map(topic => ({
    topic: topic,
    color: getRandomColor()
}));

function TopicPageView(){
    return(
        <div className='topic-page'>
            <div className="list-topics">
                {topics.map((item, index) => (
                    <TopicTag topic={item.topic} key={index} color={item.color} />
                ))}
            </div>
        </div>
    )
}

export default TopicPageView;