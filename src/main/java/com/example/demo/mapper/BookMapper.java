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
			AND Book.petId = Pet.Id
			""")
	Book selectById(Integer id);

	@Update("""
			UPDATE Book
			SET
				checkIn = #{checkIn},
				checkOut = #{checkOut},
				hospital = #{hospital},
				message = #{message},
				pottyTraining = #{pottyTraining}
				
			WHERE 
				num =#{num}
				
			""")
	int update(Book book);

	// 예약요청목록 (호스트)
	@Select("""
			SELECT
				petName,
				checkIn,
				checkOut,
				hostName,
				accepted,
				detailId,
				num,
				Book.memberId
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			AND Host.memberId = #{userId}
			ORDER BY Book.num DESC
			LIMIT #{startIndex}, #{rowPerPage}
			""")
	List<Book> selectAllPaging(Integer startIndex, Integer rowPerPage, String userId);

	// 예약요청목록 (호스트)
	@Select("""
			SELECT COUNT(*)
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			AND Host.memberId = #{userId}
			""")
	Integer countAll(String userId);

	@Update("""
			UPDATE Book 
			SET
			accepted =1
			WHERE 
			num = #{num}
			""")
	void bookAcceptUpdate(int num);

	
	@Insert("""
			INSERT INTO Book (hospital, message, checkIn, checkOut, pottyTraining, detailId, petId, memberId,accepted)
			VALUES (#{hospital}, #{message}, #{checkIn}, #{checkOut}, #{pottyTraining}, #{detailId}, #{petId}, #{memberId}, #{accepted})
			""")
	@Options(useGeneratedKeys = true, keyProperty="id")
	int insert(Book book);

	@Select("""
			SELECT 
				id,
				petName,
				type,
				birth,
				gender,
				neutered,
				weight
			FROM Pet
			WHERE Pet.memberId = #{userId}
			AND	  id = #{petId}
			""")
	Registration getPet(String userId, Integer petId);

	
	@Delete("""
			DELETE FROM Book
			WHERE num = #{num}
		
			""")
	int deleteById(Integer id);

	@Select("""
			SELECT 
				id,
				petName,
				type,
				birth,
				gender,
				neutered,
				weight
			FROM Pet
			WHERE Pet.memberId = #{userId}
			""")
	Registration getPetModify(String userId);

	//예약요청목록(사용자)
	@Select("""
			SELECT
				petName,
				checkIn,
				checkOut,
				hostName,
				accepted,
				detailId,
				num,
				rejectMessage,
				Book.memberId,
				Detail.hostId
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			AND Pet.memberId = #{userId}
			AND Pet.id = Book.petId
			ORDER BY Book.num DESC
			LIMIT #{startIndex}, #{rowPerPage}
			""")
	List<Book> selectAllPagingUser(Integer startIndex, Integer rowPerPage, String userId);

	// 예약신청내역(사용자)
	@Select("""
			SELECT COUNT(*)
			FROM Book,Pet,Host,Detail
			WHERE Book.memberId = Pet.memberId
			AND Detail.id = Book.detailId
			AND Host.id = Detail.hostId
			AND Pet.memberId = #{userId}
			AND Pet.id = Book.petId
			""")
	Integer countAllUser(String userId);

	
	//예약거절
	@Update("""
			UPDATE Book 
			SET
			accepted =3,
			rejectMessage = #{rejectMessage}
			WHERE 
			num = #{num}
			""")
	void bookRejectUpdate(Book book);
	
	@Select("""
			SELECT * FROM Book WHERE detailId = #{detailId}
			""")
	List<Book> selectByDetailId(Integer detailId);

	
}



