package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.example.demo.domain.*;

@Mapper
public interface BookMapper {
	
	@Select("""
			SELECT
			petName,
			checkIn,
			checkOut,
			hostName,
			accepted,
			Host.id,
			num
			
		FROM Book, Host, Pet
		ORDER BY num DESC
			""")
	List<Book> selectAll();

	@Select("""
			SELECT *
			FROM Book,Pet
			WHERE num = #{num}
			AND Book.memberId = Pet.memberId
			""")
	Book selectById(Integer id);

	@Update("""
			UPDATE Book
			SET
				checkIn = #{checkIn},
				checkOut = #{checkOut},
				hospital = #{hospital},
				message = #{message}
			WHERE 
				num =#{num}
				
			""")
	int update(Book book);

	// 시큐리티 적용후 쿼리 변경 예정
	@Select("""
			SELECT
				petName,
				checkIn,
				checkOut,
				hostName,
				accepted,
				detailId,
				num
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			-- AND Pet.memberId = '시큐리티에 있는 아이디값'
			ORDER BY Book.num DESC
			LIMIT #{startIndex}, #{rowPerPage}
			""")
	List<Book> selectAllPaging(Integer startIndex, Integer rowPerPage);

	// 시큐리티 적용후 쿼리 변경 예정
	@Select("""
			SELECT COUNT(*)
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			-- AND Pet.memberId = '시큐리티에 있는 아이디값'
			""")
	Integer countAll();


	
	
}



