package com.example.demo.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

@Service
public class BookService {

	@Autowired
	private BookMapper mapper;
	
	@Autowired
	private AlarmMapper alarmMapper;
	
	
	//예약목록
	public List<Book> bookList() {
		List<Book> list = mapper.selectAll();
		return list;
		}
	
	
	//예약신청서
	public void addRegi(Book book) {
		 int cnt = mapper.insert(book);
		 if(cnt == 1) {
			 alarmMapper.bookRegiAdd(book);
		 }
	}

	
	// 눌렀을때 페이지 뜨게
	public Book getBook(Integer id) {
			return mapper.selectById(id);
		}


	// 수정 잘 되었으면 1
	public boolean modify(Book book) {
		int cnt = mapper.update(book);
		return cnt ==1;
	}

	//페이지네이션, 예약 요청목록(호스트)
	public Map<String, Object> bookList(Integer page,String userId) {
		Integer rowPerPage = 6;
		
		Integer startIndex = (page-1) * rowPerPage;
		
		Integer numOfRecords =mapper.countAll(userId);
		// 마지막 페이지 번호
		Integer lastPageNumber = (numOfRecords-1) / rowPerPage +1;
		
		// 페이지네이션 왼쪽 번호
		Integer leftPageNum = page - 5;
		// 1보다 작을 수 없음
		leftPageNum = Math.max(leftPageNum, 1);
		
		// 페이지네이션 오른쪽 번호
		Integer rightPageNum = leftPageNum +9;  
		// 마지막 페이지보다 클 수 없음
		rightPageNum = Math.min(rightPageNum, lastPageNumber);
		
		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("currentPageNum", page);
		pageInfo.put("lastPageNum", lastPageNumber);
		
		// 게시물 목록 넘겨주고
		List<Book> list = mapper.selectAllPaging(startIndex, rowPerPage, userId);
				return Map.of("pageInfo", pageInfo,
							  "bookList", list);
		
	}

	// 예약승인
	public void bookAccept(int num) {
		Integer cnt = mapper.bookAcceptUpdate(num);
		if(cnt == 1) {
			alarmMapper.bookAcceptAdd(num);
		}
	}


	// 펫 정보 가져오기
	public Registration getPet(String userId, Integer petId) {
		return mapper.getPet(userId,petId);
	}

	//예약 취소
	public boolean remove(Integer id) {
		int cnt = mapper.deleteById(id);
		return cnt==1;
	}

	// 예약수정
	public Registration getPet(String userId) {
		return mapper.getPetModify(userId);
	}


	// 예약신청목록(사용자)
	public Map<String, Object> bookListUser(Integer page, String userId) {
		Integer rowPerPage = 6;
		
		Integer startIndex = (page-1) * rowPerPage;
		
		Integer numOfRecords =mapper.countAllUser(userId);
		// 마지막 페이지 번호
		Integer lastPageNumber = (numOfRecords-1) / rowPerPage +1;
		
		// 페이지네이션 왼쪽 번호
		Integer leftPageNum = page - 5;
		// 1보다 작을 수 없음
		leftPageNum = Math.max(leftPageNum, 1);
		
		// 페이지네이션 오른쪽 번호
		Integer rightPageNum = leftPageNum +9;  
		// 마지막 페이지보다 클 수 없음
		rightPageNum = Math.min(rightPageNum, lastPageNumber);
		
		Map<String, Object> pageInfo = new HashMap<>();
		pageInfo.put("rightPageNum", rightPageNum);
		pageInfo.put("leftPageNum", leftPageNum);
		pageInfo.put("currentPageNum", page);
		pageInfo.put("lastPageNum", lastPageNumber);
		
		// 게시물 목록 넘겨주고
		List<Book> list = mapper.selectAllPagingUser(startIndex, rowPerPage, userId);
				return Map.of("pageInfo", pageInfo,
							  "bookList", list);


		}


	// 예약거절
	public void bookReject(Book book) {
		Integer cnt = mapper.bookRejectUpdate(book);
		
		if(cnt == 1) {
			alarmMapper.bookRejectAdd(book);
		}
	}
}

	

