package com.example.demo.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;
import org.springframework.beans.factory.annotation.*;

import com.example.demo.domain.*;

@Mapper
public interface HomeMapper {
	

	@Select("""
			SELECT 
				fe.id,
				fe.title,
				fe.content,
				fe.writer,
				fe.inserted,
				fi.fileName
			FROM Feed fe LEFT JOIN File fi ON fe.id = fi.feedId
			ORDER BY fe.id DESC
			""")
	@ResultMap("homeFeedResultMap")
	List<Feed> selectAll();

	

	

}
