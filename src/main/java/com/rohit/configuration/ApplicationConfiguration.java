package com.rohit.configuration;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ApplicationConfiguration {

    @Bean
     public AmazonSQS createSqsClient() {
        return AmazonSQSClientBuilder.standard()
                .withRegion(Regions.AP_SOUTH_1)
                .build();
    }
}
