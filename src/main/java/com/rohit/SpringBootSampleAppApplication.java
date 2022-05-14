package com.rohit;

import com.rohit.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;


@SpringBootApplication
public class SpringBootSampleAppApplication implements CommandLineRunner {
	Logger logger = LoggerFactory.getLogger(SpringBootSampleAppApplication.class);

	@Autowired
	Environment environment;

	@Autowired
	MessageService messageService;

	public static void main(String[] args) {
		SpringApplication.run(SpringBootSampleAppApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		String[] activeProfiles = environment.getActiveProfiles();
		for(String profile : activeProfiles){
			logger.info("SpringBootSampleAppApplication is up and running using : {} profile",profile);
		}
		messageService.checkMessages();
	}
}
