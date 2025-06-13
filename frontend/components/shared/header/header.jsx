'use client'
import './header.css'
import 'bootstrap-icons/font/bootstrap-icons.css';
// import React from 'react';
import {Nav, NavDropdown } from 'react-bootstrap';
import Link from 'next/link';


function Header(){
    return(
        <div className="rowDirection headerBar">
            <div className="bg">
                
            </div>
            <Link href={'/'}>
                <div className='rowDirection'>
                    <img className="logo" src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToaaeE9Phu2PktQ-x1An8jXVvHhwc1Ov1EsA&s" alt="logo" />
                    <div className='columnDirection logoDetail'>
                        <h3>MetPhim</h3>
                        <p>phim hay cả mẹt</p>
                    </div>
                </div>
            </Link>
            <div className="search-engine rowDirection">
                <i className="bi bi-search search-icon"></i>
                <input className='search-input' type="text" placeholder='Tìm kiếm phim, diễn viên' />
            </div>
            <Nav className="me-auto navbar">
                <Nav.Link href="/topic">Chủ đề</Nav.Link>
                <NavDropdown title="Thể loại" id="nav-dropdown">
                <NavDropdown.Item href="/movies">Hành động</NavDropdown.Item>
                <NavDropdown.Item href="/movies">Hài hước</NavDropdown.Item>
                <NavDropdown.Item href="/movies">Lãng mạn</NavDropdown.Item>
                </NavDropdown>
                <Nav.Link href="/movies">Phim lẻ</Nav.Link>
                <Nav.Link href="/movies">Phim bộ</Nav.Link>
                <NavDropdown title="Quốc gia" id="nav-dropdown">
                <NavDropdown.Item href="/movies">Việt Nam</NavDropdown.Item>
                <NavDropdown.Item href="/movies">Hàn Quốc</NavDropdown.Item>
                <NavDropdown.Item href="/movies">Trung Quốc</NavDropdown.Item>
                </NavDropdown>
                <Nav.Link href="/actor">Diễn viên</Nav.Link>
                <Nav.Link href="/movie-schedule">Lịch chiếu</Nav.Link>
            </Nav>
            <button className='register-button'>Thành viên</button>
        </div>
    )
}

export default Header

