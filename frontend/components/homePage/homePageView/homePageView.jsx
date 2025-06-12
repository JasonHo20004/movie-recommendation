'use client'
import TopTenMovies from '../topTenMovies/topTenMovies';
import TopNewMovies from '../topNewMovies/topNewMovies';
import Header from '../header/header'
import ListMovies from '../listMovies/listMovies';
import ListTopics from '../listTopics/listTopics';
import 'bootstrap/dist/css/bootstrap.min.css';
import './homePageView.css';

function HomePageView() {
  return (
    <div>
      <Header className='headerBar'/>
      <div className='content'>
        <ListTopics />
        <TopNewMovies />
        <TopTenMovies />
        <ListMovies category="Phim hành động"/>
        <ListMovies category="Phim hài hước"/>
      </div>
    </div>
  );
}

export default HomePageView;
