package com.rohit.service;

import com.amazonaws.services.sqs.AmazonSQS;
import com.amazonaws.services.sqs.model.Message;
import com.amazonaws.services.sqs.model.ReceiveMessageRequest;
import com.rohit.configuration.ApplicationConfiguration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class MessageService {
    Logger logger = LoggerFactory.getLogger(MessageService.class);

    @Autowired
    ApplicationConfiguration applicationConfiguration;

    public void checkMessages(){
        AmazonSQS sqsClient = applicationConfiguration.createSqsClient();
        ReceiveMessageRequest receiveMessageRequest = new ReceiveMessageRequest();
        receiveMessageRequest.setQueueUrl("dev-rohit-test-111");
        List<Message> messages = sqsClient.receiveMessage(receiveMessageRequest).getMessages();
        for(Message message : messages){
            logger.info("Message :  {}",message);
            sqsClient.deleteMessage("dev-rohit-test-111",message.getReceiptHandle());
        }
    }
}
