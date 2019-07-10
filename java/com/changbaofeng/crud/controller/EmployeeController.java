package com.changbaofeng.crud.controller;

import com.changbaofeng.crud.bean.Employee;
import com.changbaofeng.crud.bean.Msg;
import com.changbaofeng.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//处理员工crud请求
@Controller
public class EmployeeController {
    @Autowired//自动装配service层的业务逻辑组件
            EmployeeService employeeService;

    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpByIds(@PathVariable("ids") String ids){
        if(ids.contains("-")){
            String [] empIds = ids.split("-");
            //组装id集合
            List<Integer> idList = new ArrayList<Integer>();
            for (String str:
                 empIds) {
                idList.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(idList);
        }else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
//        System.out.println(ids);

        return Msg.success();
    }

    /**
     * 员工更新方法
     * 如果直接发送ajax=put形式的请求，会产生问题，请求头中有数据，但是封装的时候没有数据。
     * 原因：tomcat将请求体中的数据，封装成一个map，然后request.getParameter("")从map中取值，而springMVC数据的时候，会把POJO中每个属性的值，调用request.getParameter("")拿到
     * 所以：Ajax put请求不能直接发，请求体中的数据拿不到
     * 因为tomcat一看是put就不会封装请求体中的数据。
     *
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
//        System.out.println("将要更新的员工数据");
//        System.out.println(employee.toString());
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    /**
     * 根据id查询员工
     */
    @RequestMapping(value ="/emps/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);

        return Msg.success().add("emp",employee);
    }
    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名可以使2-5位中文或者6-16位英文和数字的组合");
        }
        //数据库用户名
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","重复，用户名不可用");
        }
//        return null;
    }

    /**
     * 运功保存
     * 1 支持JSR303校验
     * 2 导入Hibernate-Validator
     * @param employee
     * @return
     */
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){//校验失败，返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap();
            List<FieldError> errors = result.getFieldErrors();
            for(FieldError fieldError:errors){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
                System.out.println("错误字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            if(employee==null){
                return Msg.fail();
            }
            employeeService.saveEmp(employee);
            return Msg.success();
        }
//        System.out.println(employee.toString());
//        System.out.println(employee.getEmpName());

    }

    //返回json数据
    /**
     * 需要导入jackson包
     * */
    @RequestMapping("/emps")
    @ResponseBody
//    public PageInfo getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);//
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
        //它封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
//        return page;
        return Msg.success().add("pageInfo",page);
    }


    //查询员工数据（分页数据）
//    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //没有传分页的时候，默认值为1
        // 这里不是一个分页查询，能够查出多有的
        //引入pageHelper这个分页插件，为了使开发简单，通用分页查询
        //在查询之前，只需要调用下面方法，pn-传入页码，pageSize-每页多少条数据
        PageHelper.startPage(pn, 5);//
        //startPage紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面
        //它封装了详细的分页信息，包括我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps, 5);
//        将查询的结果交给前段页面，使用model
        model.addAttribute("pageInfo", page);
//        page.getNavigatepageNums(); 得到连续显示的页码
        return "list";
    }
}
