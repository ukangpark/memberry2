package com.example.demo.service;

import java.awt.print.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.domain.Book;
import com.example.demo.mapper.*;

@Service
public class BookService {

	@Autowired
	private BookMapper mapper;
	
	
	//예약목록
	public List<Book> bookList() {
		List<Book> list = mapper.selectAll();
		return list;
		}

	
	// 눌렀을때 페이지 뜨게
	public Book getBook(Integer id) {
			return mapper.selectById(id);
		}


		

		}

	

