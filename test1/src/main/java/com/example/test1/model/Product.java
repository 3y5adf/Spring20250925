package com.example.test1.model;

import lombok.Data;

@Data
public class Product {
	private int foodNo;
	private String foodName;
	private int price;
	private String foodKind;
	private String foodInfo;
	private String sellYN;
	
	private int menuNo;
	private int menuPart;
	
	private int foodFileNo;
	private String filePath;
	private String fileName;
	private String fileOrgName;
	private String fileSize;
	private String fileTc;
	private String thumbnailYN;
	
	private String orderId;
	private String userId;
	private int amount;
	private String productNo;
	private String paymentDate;
	

}
