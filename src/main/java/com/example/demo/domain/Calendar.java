package com.example.demo.domain;

import java.time.LocalDate;
import java.util.*;

import lombok.*;
@Data
public class Calendar {
	private Integer id;
	private String title;
	private LocalDate start;
	private LocalDate end;
	private Boolean allDay;
	
}
