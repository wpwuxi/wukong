package backcommon.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.wukong.background.backcommon.service.SomeService;

@RunWith(SpringJUnit4ClassRunner.class) // 此处调用Spring单元测试类
@WebAppConfiguration // 调用javaWEB的组件，比如自动注入ServletContext Bean等等
@ContextConfiguration(locations = { "classpath:applicationContext.xml" }) // 加载Spring配置文件
public class SomeTest {
	
	@Autowired
	private SomeService service;
	
	@Test
	public void test(){
	}
}
