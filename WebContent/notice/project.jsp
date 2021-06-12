<!-- step01_grid_lg.html --!>
<%@page pageEncoding="utf-8" %>
<%@include file="../inc/header.jsp" %>
  <!-- breadcrumb start -->

<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">홈</a></li>
	</ol>
</nav>

<!-- breadcrumb end -->
<!-- container start -->
<div class="container">

	<!-- col start -->
	<div class="row">
		<div class="col-md-12">
			<%--slide start --%>
			<div id="carouselExampleIndicators" class="carousel slide"
				data-ride="carousel">
				<ol class="carousel-indicators">
					<li data-target="#carouselExampleIndicators" data-slide-to="0"
						class="active"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
				</ol>
				<div id="carouselExampleSlidesOnly" class="carousel slide"
					data-bs-ride="carousel">
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="/notice/exercise.gif" class="d-block w-100" alt="..."
								width="500px" height="500px">
						</div>
						<div class="carousel-item">
							<img src="/notice/download.jpeg" class="d-block w-100" alt="..."
								width="500px" height="400px">
						</div>
						<div class="carousel-item">
							<img src="/image/test.png" class="d-block w-100" alt="...">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
				<div class="btn-group" role="group"
					aria-label="Basic radio toggle button group">
					<input type="radio" class="btn-check" name="btnradio"
						id="btnradio1" autocomplete="off" checked> <label
						class="btn btn-outline-primary" for="btnradio1">20∙30대</label> 
						<input type="radio" class="btn-check" name="btnradio" id="btnradio2"
						autocomplete="off"> <label class="btn btn-outline-primary"
						for="btnradio2">40∙50대</label>
						 <input type="radio" class="btn-check" name="btnradio" id="btnradio3"
						autocomplete="off"> <label class="btn btn-outline-primary"
						for="btnradio3">60∙70대</label>
						<input type="radio" class="btn-check" name="btnradio" id="btnradio4"
						autocomplete="off"> <label class="btn btn-outline-primary"
						for="btnradio4">80∙90대</label>
				</div>
				<%--slide end --%>

				<button type="button" class="btn btn-secondary btn-lg">START</button>

			</div>
		</div>
		<!-- col end -->
	</div>
	<!-- container end -->
	<%@include file="../inc/footer.jsp"%>