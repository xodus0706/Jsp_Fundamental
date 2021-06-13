<%@page import="kr.or.kpc.dao.ParkDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.kpc.dto.ParkDto"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../pinc/header.jsp"%>
<%
	ParkDto dto = new ParkDto();
	ParkDao dao = ParkDao.getInstance();
	
	ArrayList<ParkDto> list = dao.resall();
	int size = list.size();
%>

<nav aria-label="breadcrumb" >
  <ol class="breadcrumb" style="background-color: green">
    <li class="breadcrumb-item"><a href="/project/index.jsp" style="color:white">Home ></a></li>
    <li class="breadcrumb-item">Program</li>
  <link href="https://fonts.googleapis.com/css2?family=Gaegu&display=swap" rel="stylesheet">
 </ol>
</nav>

<style>
.breadcrumb-item{
color: white;
font-family:fantasy;
font-size: 20px;
}


.text{
position: relative;
text-align:left;
font-family: 'Gaegu', cursive;
top: 3%;
font-size : 53px;
}

#btn1 {
  margin: 0;
  position: absolute;
  border-radius: 12px;
  top: 16%;
  left: 50%;
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
font-family: 'Gaegu', cursive;
  background-color: white;
color:green;
  font-size:20px;
  href="#";
  width:70px;
}

#address{
position:relative;

}

h5{
font-family: 'Gaegu', cursive;
}
</style>


<!-- container start -->
<div class="container">
	<div class="row">
		<div class="col-md-12">
			<!-- table start -->
			<p class="text">당신은 현재 어디에 있나요?</p>
			<div class="table-responsive">

			
            <div style="width:450px; margin : 20px;">
	   
	            <input type="text" class="form-control" id="address" placeholder="도로명 주소를 입력하세요">
	            <button id="btn1" class="btn btn-outline-success" >START</button>
          	</div>
          	
            
			
			<br><br>
			<!-- 지도를 표시할 div 입니다 -->
			<p style="margin-top:-12px;">
			    <em class="link">
			        <h5>혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
			        <button id="btn" class="btn btn-outline-danger" href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">여기!</button></h5>
			    </em>
			</p>
			<div id="map" style="width: 100%; height: 550px;"></div>

			<script type="text/javascript"
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14f150998f9d2432105a8538735eee0f&libraries=services">
			</script>
			<script>
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(37.56778694776533,
							126.98229712096322), // 지도의 중심좌표
					level : 3
				// 지도의 확대 레벨
				};
				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				// 마커를 표시할 위치와 title 객체 배열입니다 
				var positions = [
				<%
					int index=0;
					for(ParkDto dto1 : list){ 
					index++;
				%>
					    {
					        title: '<%=dto1.getPname()%>', 
					        latlng: new kakao.maps.LatLng(<%=dto1.getLan()%>, <%=dto1.getLen()%>)
					    }<%if(size != index) out.print(",");%>
			    	<%}%>
				];
				positions.add
				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
				
				
				
				for (var i = 0; i < positions.length; i ++) {
				    
				    // 마커 이미지의 이미지 크기 입니다
				    var imageSize = new kakao.maps.Size(24, 35); 
				    
				    // 마커 이미지를 생성합니다    
				    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
				    
				    // 마커를 생성합니다
				   var marker = new kakao.maps.Marker({
				        map: map, // 마커를 표시할 지도
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				        image : markerImage // 마커 이미지
				    });
				    
				   var infowindow = new kakao.maps.InfoWindow({
				        content: positions[i].title // 인포윈도우에 표시할 내용
				    });
				    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저 생성
				    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록
				    (function(marker, infowindow) {
				        //인포윈도우를 표시
				        kakao.maps.event.addListener(marker, 'mouseover', function() {
				            infowindow.open(map, marker);
				        });
				        //인포윈도우를 닫음
				        kakao.maps.event.addListener(marker, 'mouseout', function() {
				            infowindow.close();
				        });
				    })(marker, infowindow);
				}
				
				marker.setMap(map);
				
				var geocoder = new kakao.maps.services.Geocoder();
				// 클릭 이벤트로 주소 받고 좌표를 검색합니다	
				$('#btn').click(function(){
						geocoder.addressSearch($('#address').val(), function(result, status){
					
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					        // 결과값으로 받은 위치를 마커로 표시
					        var mark = new kakao.maps.Marker({
					            map: map,
					            position: coords
					        });
					        // 인포윈도우로 장소에 대한 설명을 표시
					        var infowindow = new kakao.maps.InfoWindow({
					            content: '<div style="width:150px;text-align:center;padding:6px 0;">고객님 위치</div>'
					        });
					        infowindow.open(map, mark);
					        // 지도의 중심을 결과값으로 받은 위치로 이동
					        map.setCenter(coords);
					    }
					     console.log($("#years option:selected").text());
					});
				});//클릭이벤트로 주소받고 좌표 검색 끝
				
			</script>
		</div>
	</div>
</div>
</div>
<%@ include file="../inc/footer.jsp"%>