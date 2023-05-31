package com.example.demo.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;

import com.example.demo.domain.Registration;

@Mapper
public interface RegistrationMapper {

	@Insert("""
			INSERT INTO Pet (petName, type, weight, birth, together, gender, neutered, registrationNum, photo)
			VALUES (#{petName}, #{type}, #{weight}, #{birth}, #{together}, #{gender}, #{neutered}, #{registrationNum}, #{photo})
			""")
	@Options(useGeneratedKeys = true, keyProperty = "id")
	Integer insertAll(Registration registration);


	
	

}
