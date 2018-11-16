package com.wukong.background.backmanager.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/user")
public class BackUserController {
    
    /**
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/login")
    public String login(String username , String password ,HttpServletRequest request , HttpSession session){
        //获取当前登录用户
        Subject subject=SecurityUtils.getSubject();
        //封装表单中提交的用户名和密码
        UsernamePasswordToken token=new UsernamePasswordToken(username, password);
        try{
            //调用login方法，传入封装好的token
            subject.login(token);
            
            //会话保存用户信息
            session.setAttribute("username", username);
            
            //登录成功跳转success.jsp
            return "redirect:/manage";
        }catch(Exception e){
            e.printStackTrace();
            //登录失败就重新登录
            request.setAttribute("errorMsg", "登录失败");
            return "login";
        }
    }
    
    /**
    *
    * @param user
    * @param request
    * @return
    */
   @RequestMapping("/")
   public ModelAndView main(HttpServletRequest request){
	   return new ModelAndView("login");
   }
   
   @RequestMapping("/unauthor")
   public ModelAndView unauthor(HttpServletRequest request){
	   return new ModelAndView("unauthor");
   }
   
   /**
	 * 返回页面，带参数
	 * 
	 * @return
	 */
	@RequestMapping(value = "logout", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView logout(HttpSession httpSession) {
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}
    
}