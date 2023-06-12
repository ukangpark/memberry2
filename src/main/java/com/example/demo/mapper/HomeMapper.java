package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.*;

import com.example.demo.domain.*;

@Mapper
public interface HomeMapper {
	

	@Select("""
			SELECT 
				fd.id,
				fd.title,
				fd.content,
				fd.writer,
				fd.inserted,
				fi.fileName,
				(SELECT COUNT(*) 
				 FROM FeedLike 
				 WHERE feedId = fd.id) likeCount,
				 (SELECT COUNT(*) FROM Comment WHERE feedId = fd.id) commentCount
			FROM Feed fd LEFT JOIN File fi ON fd.id = fi.feedId
			ORDER BY fd.id DESC
			""")
	@ResultMap("homeFeedResultMap")
	List<Feed> selectAll();

	@Select("""
			SELECT *
			FROM FeedLike
			WHERE memberId = #{memberId}
			""")
	List<Like> select(String memberId);

	

	

}
