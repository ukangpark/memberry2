package com.example.demo.controller;

import java.math.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.http.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

import com.siot.IamportRestClient.*;
import com.siot.IamportRestClient.response.*;

import net.minidev.json.*;

@Controller
public class PaymentController {
	
	@Value("${iamport.apiKey}")
	private String apiKey;
	
	@Value("${iamport.apiSecret}")
	private String apiSecret;
	
	// 콜백 수신 처리
	@RequestMapping("/payment/callback_receive")
	public ResponseEntity<?> callback_recieve(@RequestBody Map<String, Object> model){
		
		String process_result="결제 성공!";
		// 응답헤더 생성
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/json; charset=UTF-8");
		JSONObject responseObj = new JSONObject();
		
		try {
			String imp_uid =(String)model.get("imp_uid");
			String merchant_uid = (String)model.get("merchant_uid");
			boolean success = (Boolean)model.get("success");
			String error_msg = (String)model.get("error_msg");
			
			System.out.println("---callback receive---");
			System.out.println("-----------------");
			System.out.println("imp_uid : " + imp_uid);
			System.out.println("merchant_uid : " + merchant_uid);
			System.out.println("success : " + success);
			
			if(success == true) {
				//step 5
				String api_key = apiKey;
				String api_secret = apiSecret;
				
				IamportClient ic = new IamportClient(api_key, api_secret);
				IamportResponse<Payment> response = ic.paymentByImpUid(imp_uid);
				
				BigDecimal iamport_amount = response.getResponse().getAmount(); 
				
				responseObj.put("process_result", "결제성공");
				
			}else {
				System.out.println("error_msg : " + error_msg);
				responseObj.put("process_result","결제실패 : " + error_msg);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			responseObj.put("process_result","결제실패 : 관리자에게 문의해 주세요.");
		}
		
		return new ResponseEntity<String>(responseObj.toString(), responseHeaders, HttpStatus.OK);
	}
	
	
		

}
