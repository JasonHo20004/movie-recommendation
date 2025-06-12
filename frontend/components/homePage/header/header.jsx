import './header.css'
import 'bootstrap-icons/font/bootstrap-icons.css';
// import React from 'react';
import {Nav, NavDropdown } from 'react-bootstrap';


function Header(){
    return(
        <div className="rowDirection headerBar">
            <div className="bg">
                
            </div>
            <div className='rowDirection'>
                <img className="logo" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToaaeE9Phu2PktQ-x1An8jXVvHhwc1Ov1EsA&s" alt="logo" />
                <div className='columnDirection logoDetail'>
                    <h3>MetPhim</h3>
                    <p>phim hay cả mẹt</p>
                </div>
            </div>
            <div className="search-engine rowDirection">
                <i className="bi bi-search search-icon"></i>
                <input className='search-input' type="text" placeholder='Tìm kiếm phim, diễn viên' />
            </div>
            <Nav className="me-auto navbar">
                <Nav.Link href="/">Chủ đề</Nav.Link>
                <NavDropdown title="Thể loại" id="nav-dropdown">
                <NavDropdown.Item href="/">Hành động</NavDropdown.Item>
                <NavDropdown.Item href="/">Hài hước</NavDropdown.Item>
                <NavDropdown.Item href="/">Lãng mạn</NavDropdown.Item>
                </NavDropdown>
                <Nav.Link href="/">Phim lẻ</Nav.Link>
                <Nav.Link href="/">Phim bộ</Nav.Link>
                <NavDropdown title="Quốc gia" id="nav-dropdown">
                <NavDropdown.Item href="/">Việt Nam</NavDropdown.Item>
                <NavDropdown.Item href="/">Hàn Quốc</NavDropdown.Item>
                <NavDropdown.Item href="/">Trung Quốc</NavDropdown.Item>
                </NavDropdown>
                <Nav.Link href="/">Diễn vien</Nav.Link>
                <Nav.Link href="/">Lịch chiếu</Nav.Link>
            </Nav>
            <button className='register-button'>Thành viên</button>
        </div>
    )
}

export default Header

