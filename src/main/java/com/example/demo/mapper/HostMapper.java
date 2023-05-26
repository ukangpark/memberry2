package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.domain.Host;

@Mapper
public interface HostMapper {

	@Select("""
			SELECT
				hostName,
				address,
				phone,
				photo,
				inserted
			FROM host
			ORDER BY inserted DESC
			""")
	List<Host> selectAll();

}
