package com.example.test1.model;

import lombok.Data;

@Data
public class Bbs {
	
	private int bbsNum;
	private String title;
	private String contents;
	private int hit;
	private String userId;
	private String cdatetime;
	private String udatetime;
	
	private String cdate;
	
	private int fileNo;
	private int boardNo;
	private String filePath;
	private String fileName;
	private String fileOrgName;
	private String fileSize;
	private String fileETC;
}
