<!-- template.html -->
<%@page import="kr.or.kpc.dto.NoticeDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kpc.dao.NoticeDao"%>
<%@ page pageEncoding="utf-8" %>
<%@ include file="../inc/header.jsp" %>

  	<!-- breadcrumb start -->
  	<nav aria-label="breadcrumb">
	  <ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="/index.jsp">홈</a></li>
	    <li class="breadcrumb-item">회원가입</li>
	 </ol>
	</nav>
	<!-- breadcrumb end -->
  	
  	<!-- container start -->
	<div class="container">
		<!-- col start -->
		<div class="row">
			<div class="col-md-12">
				<h3>회원가입</h3>
	        	<form method="post" name="f" action="save.jsp">
				  <div class="form-group">
	                <input type="text" class="form-control" id="email" name="email" placeholder="Your Email *" value="" />
	              	<div class="invalid-feedback" id="errorEmail">
				       이메일을 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="password" class="form-control" id="pwd" name="pwd"  placeholder="Your Password *" value="" />
	              	<div class="invalid-feedback" id="errorPwd">
				    	비밀번호를 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="password" class="form-control" id="repwd" name="repwd"  placeholder="Your Re-Password *" value="" />
	              	<div class="invalid-feedback" id="errorRePwd">
				    	비밀번호를 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
	              <div class="form-group">
	                <input type="text" class="form-control" id="name" name="name" placeholder="Your Name *" value="" />
	              	<div class="invalid-feedback" id="errorName">
				       이름을 입력하세요.
				    </div>
				    <div class="valid-feedback">
				        Looks good!
				    </div>
	              </div>
				</form>
				<div class="text-right" style="margin-bottom : 20px;">
					<a href="" id="saveCustomer" class="btn btn-outline-danger">회원가입</a>
					<a href="login.jsp" class="btn btn-outline-success">로그인</a>
					<a href="list.jsp" class="btn btn-outline-info">리스트</a>
				</div>
			</div>
		</div>
		<!-- col end -->
	</div>
	<!-- container end -->
	<script>
	$(function(){
		
		$('#saveCustomer').click(function(e){
			e.preventDefault();
			let email = $('#email').val();
			let pwd = $('#pwd').val();
			let repwd = $('#repwd').val();
			let name = $('#name').val();
			if(email==""){
				$('#email').addClass('is-invalid');
				
			}else{
				$('#email').removeClass('is-invalid');
				
				if(validateEmail(email)){
					$.ajax({
						type: 'get',
						url: 'checkEmailAjax.jsp?email='+email,
						dataType : 'json',
						eoor: function(){
							alert('error');
						},
						success :  function(json){
						//json -> {"result" : "ok"}	, {"result" : "fail"}
						if(json.result == "ok"){
							$('#email').removeClass('is-invalid');
							$('#email').add('is-valid');
							
						}else{
							$('#errorEmail').text('이미 등록된 이메일 입니다.');
							$('#email').addClass('is-invalid');
							
						}
						}
					});
				}else{
					$('#errorEmail').text('정상적인 이메일 주소가 아닙니다.');
					$('#email').addClass('is-invalid');
				}
				
			}
			
		});
		
		function validateEmail(email) {
            var re = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
            return re.test(email);
    	}
		
		
		
	});	
	</script>
<%@ include file="../inc/footer.jsp" %>