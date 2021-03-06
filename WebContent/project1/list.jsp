<!-- template.html -->
<%@ page import="java.util.ArrayList"%>
<%@ page import="kr.or.kpc.dto.NoticeDto"%>
<%@ page import="kr.or.kpc.dao.NoticeDao"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../pinc/header.jsp"%>
<%
String tempPage = request.getParameter("page");
int cPage = 0;
if(tempPage == null || tempPage.length() == 0){
	cPage=1;
}
try{
cPage = Integer.parseInt(tempPage);
}catch(NumberFormatException e){
cPage = 1;
}

/*
cPage = 1 -> 0 , 10;
cPage = 2 -> 10 , 10;
cPage = 3 -> 20 , 10;
start = 0, 10, 20, displayCount : 10
An = a1 + (n-1)*d --> a1 : 0, n->cPaage, dL displayCount
*/
int totalRows = 0;//128개라 가정
int currentBlock = 0;
int totalBlock = 0;
int totalPage = 0;
int startPage = 0;
int endPage = 0;
int pageDisplayCount = 2;


int displayCount = 10;
int start = 0 + (cPage-1)*displayCount;
NoticeDao dao = NoticeDao.getInstance();
ArrayList <NoticeDto> list = dao.select(start,displayCount);
%>
<link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
<!-- breadcrumb start -->
<style>
.breadcrumb-item{
color: white;
font-family:fantasy;
font-size: 20px;
}

h4{
font-family: 'Gaegu', cursive;
position: relative;
top: 10px;
}

</style>


<nav aria-label="breadcrumb" >
  <ol class="breadcrumb" style="background-color: green">
    <li class="breadcrumb-item"><a href="/project/index.jsp" style="color:white">Home ></a></li>
    <li class="breadcrumb-item">Notice</li>
    

  </ol>
</nav>
<!-- breadcrumb end -->

<!-- container start -->
<div class="container">
	<!-- col start -->
	<div class="row">
		<div class="col-md-12">
			<%-- table start --%>
			<h4>공지사항 리스트</h4>
			<div class="table-responsive">
				<table class="table table-hover">
				<colgroup>
				<col width =10%>
				<col width =10%>
				<col width =65%>
				<col width =15%>
				</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">작성자</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
						</tr>
					</thead>
					<tbody>
					<%
					if(list.size() != 0){
					for(NoticeDto dto : list){
						
					%>
						<tr>
							<th scope="row"><%=dto.getNum() %> </th>
							<td><%=dto.getWriter() %></td>
							<td><a href="view.jsp?num=<%=dto.getNum() %>&page=<%=cPage%>"><%=dto.getTitle() %></a></td>
							<td><%=dto.getRegdate() %></td>
						</tr>
						
						<%} 
							}else{
						%>
						<tr>
						<td colspan = '4'>데이터가 존재하지 않습니다.</td>
						</tr>
						<%} %>
					</tbody>
				</table>
				<%--Pagination start --%>
				<%
				/*
				총 rows 128개, displayCount 10개 가정
				Previous 1 2 3 4 5 6 7 8 9 10 Next => currentBlock : 1 block
				Previous 11 12 13  Next            => currentBlock : 2 block
				
				*/
				totalRows = dao.getRows(); //128개
	
				if(totalRows%displayCount == 0){
					totalPage =  totalRows/displayCount;
				}else{
					totalPage =  totalRows/displayCount + 1;
				}
				/*//?이 참이면 왼쪽, 거짓이면 오른쪽
				totalPage = totalRows%displayCount == 0?
						totalRows/displayCount : totalRows/displayCount + 1; 				
				*/
				
				if (totalPage == 0){
					totalPage = 1;
				}
								
				if(cPage%pageDisplayCount == 0){
					currentBlock = cPage/pageDisplayCount;
				}else{
					currentBlock = cPage/pageDisplayCount + 1;
				}
				
				if(totalPage%pageDisplayCount == 0){
					totalBlock = totalPage/pageDisplayCount;
				}else{
					totalBlock = totalPage/pageDisplayCount + 1;
				}
				/*
				cPage : 1-10 -> currentBlock : 1
				cPage : 11-20 -> currentBlock : 2
				....
				startPage: 1, 11, 20
				endPage: 10, 20, 30
				*/
				startPage = 1 + (currentBlock -1) * pageDisplayCount;
				endPage = pageDisplayCount + (currentBlock -1) * pageDisplayCount;
				
				if(currentBlock == totalBlock){
					endPage = totalPage;
				}
				
				%>
				
				
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						
						<li class="page-item <%if(currentBlock == 1){ %>disabled<%}%>">
						<a class="page-link" href="lsit.jsp?page=<%=startPage-1 %>"
							tabindex="-1" aria-disabled="true">Previous</a></li>
						
					
						<%for (int i = startPage; i <= endPage; i++){ %>
						<li class="page-item"><a class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a></li>
						<%}%>
						
						
						<li class="page-item<%if(totalBlock == currentBlock){ %> disabled"<%}%>>
						<a class="page-link" href="lsit.jsp?page=<%=endPage+1%>"tabindex="-1" aria-disabled="true">Next</a>
						</li>
						
					</ul>
				</nav>
				<%--Pagination end --%>
				<div class="text-right">
					<a class="btn btn-success" href="write.jsp?=<%=cPage %>" role="button">글쓰기</a>
				</div>
			</div>
			<%-- table end--%>
		</div>
	</div>
	<!-- col end -->
</div>
<!-- container end -->
<%@ include file="../inc/footer.jsp"%>
