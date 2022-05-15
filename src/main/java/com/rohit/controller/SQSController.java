package com.rohit.controller;

import com.rohit.dto.Student;
import io.awspring.cloud.messaging.core.QueueMessagingTemplate;
import io.awspring.cloud.messaging.listener.SqsMessageDeletionPolicy;
import io.awspring.cloud.messaging.listener.annotation.SqsListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class SQSController {
    Logger logger = LoggerFactory.getLogger(SQSController.class);
    private static final String TEST_QUEUE = "dev-rohit-test-111";

    @Autowired
    QueueMessagingTemplate queueMessagingTemplate;

    @SqsListener(value = TEST_QUEUE,deletionPolicy = SqsMessageDeletionPolicy.ON_SUCCESS)
    public void receiveMessage(Student student){
        logger.info("Name : {} and Grade : {} ",student.getName(),student.getGrade() );
    }
}
