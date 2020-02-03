package cn.com.newloading.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.newloading.server.WebSocketServer;

@Controller
public class IndexController {
	
	@Autowired
    WebSocketServer server;

	@RequestMapping("/index")
	public String index(HttpServletRequest request) {
		return "index";
	}
	
	@PostMapping("/login")
	@ResponseBody
    public String login(String username,String password) throws IOException {
        //TODO: 校验密码
//		server.users.put(username, server);
        server.sendInfo(username + "进入了聊天室!");
        return username;
    }
}
