package com.rohit.service;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;
import com.rohit.configuration.ApplicationConfiguration;
import com.rohit.dto.Student;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.aws.messaging.core.QueueMessagingTemplate;
import org.springframework.cloud.aws.messaging.listener.SqsMessageDeletionPolicy;
import org.springframework.cloud.aws.messaging.listener.annotation.SqsListener;
import org.springframework.stereotype.Service;

@Service
public class MessageService {
    Logger logger = LoggerFactory.getLogger(MessageService.class);

    @Autowired
    QueueMessagingTemplate queueMessagingTemplate;

    @SqsListener(deletionPolicy = SqsMessageDeletionPolicy.ON_SUCCESS)
    public void checkMessages(){
        Student student = queueMessagingTemplate.receiveAndConvert("dev-rohit-test-111", Student.class);
        logger.info("Name : {} and Grade : {} ", student.getName(),student.getGrade());
    }

    /*public void checkMessages(){
        AmazonSQS sqsClient = applicationConfiguration.createSqsClient();
        ReceiveMessageRequest receiveMessageRequest = new ReceiveMessageRequest();
        receiveMessageRequest.setQueueUrl("dev-rohit-test-111");
        List<Message> messages = sqsClient.receiveMessage(receiveMessageRequest).getMessages();
        for(Message message : messages){
            logger.info("Message :  {}",message);
            sqsClient.deleteMessage("dev-rohit-test-111",message.getReceiptHandle());
        }
    }*/
}
