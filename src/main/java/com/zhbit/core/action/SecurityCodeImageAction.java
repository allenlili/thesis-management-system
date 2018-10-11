package com.zhbit.core.action;
import com.opensymphony.xwork2.ActionSupport;

import java.io.ByteArrayInputStream;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.zhbit.core.utils.SecurityCode.CheckCode;
import com.zhbit.core.utils.SecurityCode.CheckCode.SecurityCodeLevel;
import com.zhbit.core.utils.SecurityCode.CheckImage;

@SuppressWarnings("serial")
@Controller("securityCodeImageAction")
@Scope("prototype")
public class SecurityCodeImageAction extends ActionSupport implements SessionAware{
    
	//Struts2中Map类型的session
    private Map<String, Object> session;
    
    //图片流
    private ByteArrayInputStream imageStream;

    public ByteArrayInputStream getImageStream() {
        return imageStream;
    }

    public void setImageStream(ByteArrayInputStream imageStream) {
        this.imageStream = imageStream;
    }

    
    public String execute() throws Exception {
        //如果开启Hard模式，可以不区分大小写
        String securityCode = CheckCode.getSecurityCode(4,SecurityCodeLevel.Hard, true).toLowerCase();
        
        //获取默认难度和长度的验证码
        //String securityCode = CheckCode.getSecurityCode();
        imageStream = CheckImage.getImageAsInputStream(securityCode);
        //放入session中
        session.put("SESSION_SECURITY_CODE", securityCode);
        return SUCCESS;
    }

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }
}
