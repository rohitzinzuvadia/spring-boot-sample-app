package com.rohit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;



@SpringBootApplication
public class SpringBootSampleAppApplication  {
	Logger logger = LoggerFactory.getLogger(SpringBootSampleAppApplication.class);
	public static void main(String[] args) {
		SpringApplication.run(SpringBootSampleAppApplication.class, args);
	}
}
