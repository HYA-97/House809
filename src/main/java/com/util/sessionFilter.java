package com.util;

import com.pojo.Users;
import org.springframework.http.HttpStatus;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class sessionFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
//不过滤的uri
        String[] notFilter = new String[]{"login","fabu","guanli"};

        //请求的uri
        String uri = request.getRequestURI();
        System.out.println("filter>>>uri>>>"+uri);

        //是否过滤
        boolean doFilter = true;
        for(String s : notFilter){
            if(uri.indexOf(s) != -1){
                //uri中包含不过滤uri，则不进行过滤
                doFilter = false;
                break;
            }
        }

        if(doFilter){
            System.out.println("doFilter>>>");
            //过滤操作
            //从session中获取登陆者实体
            Object obj = request.getSession().getAttribute("users");
            if(obj==null){
                System.out.println("doFilter>>>obj is null");
                boolean isAjaxRequest = isAsyncDispatch(request);
                if(isAjaxRequest){
                    response.setCharacterEncoding("UTF-8");
                    response.sendError(HttpStatus.UNAUTHORIZED.value(),"您已经太长时间没有操作,请刷新页面");

                    System.out.println("doFilter>>>ajax request");

                    return ;
                }else{
                    System.out.println("doFilter>>>http request");
                    response.sendRedirect("login");
                    //跳转到登录页面
                    return ;
                }
            }else{
                Users user = (Users) obj;
                System.out.println("doFilter>>>username>>"+user.getName());
                // 如果session中存在登录者实体，则继续
                filterChain.doFilter(request, response);
            }
        }else{
            System.out.println("no Filter>>>");
            //不执行过滤操作
            filterChain.doFilter(request, response);
        }
    }
}
