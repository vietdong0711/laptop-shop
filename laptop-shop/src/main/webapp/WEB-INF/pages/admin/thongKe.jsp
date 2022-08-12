<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1"><link rel="stylesheet"
		  href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<title>Quản lý nhãn hiệu</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<script>
	window.onload = function() {
		var data = [];
		var label = [];
		var dataForDataSets = [];

		$.ajax({
			async : false,
			type : "GET",
			data : data,
			contentType : "application/json",
			url : "http://localhost:8080/laptopshop/api/don-hang/report",
			success : function(data) {
				for (var i = 0; i < data.length; i++) {
					label.push(data[i][0] + "/" + data[i][1]);
					dataForDataSets.push(data[i][2]/1000000);
				}
			},
			error : function(e) {
				alert("Error: ", e);
				console.log("Error", e);
			}
		});

		var canvas = document.getElementById('myChart');
		
		
		data = {
			labels : label,
			datasets : [ {
				label : "Tổng giá trị ( Triệu đồng)",
				backgroundColor : "#0000ff",
				borderColor : "#0000ff",
				borderWidth : 2,
				hoverBackgroundColor : "#0043ff",
				hoverBorderColor : "#0043ff",
				data : dataForDataSets,
			} ]
		};
		var option = {
			scales : {
				yAxes : [ {
					stacked : true,
					gridLines : {
						display : true,
						color : "rgba(255,99,132,0.2)"
					}
				} ],
				xAxes : [ {
					barPercentage: 0.5,
					gridLines : {
						display : false
					}
				} ]
			},
			maintainAspectRatio: false,
			legend: {
	            labels: {
	                // This more specific font property overrides the global property
	                fontSize: 20
	            }
			}
		};

		var myBarChart = Chart.Bar(canvas, {
			data : data,
			options : option
		});
	}
</script>

</head>
<body>
	<jsp:include page="template/header.jsp"></jsp:include>
	<jsp:include page="template/sidebar.jsp"></jsp:include>

	<div class="col-md-9 animated bounce">
		<h3 class="page-header">Thống kê</h3>
		<ul class="nav nav-tabs" id="tabs">
			<li class="active"><a href="#information">Biểu đồ</a></li>
			<li><a href="#changePass">Thống kê doanh thu theo thời gian</a></li>
			<li><a href="#ketqua">Các sản phẩm sắp hết</a></li>
		</ul>

		<div>
			<div class="tab-content">
				<div class="tab-pane active" id="information">
					<canvas id="myChart" width="600px" height="400px"></canvas>
					<h4 style="text-align: center; padding-right: 10%">Biểu đồ tổng giá trị đơn hàng hoàn thành theo tháng</h4>
				</div>
				<div class="tab-pane" id="changePass">
					<form class="form-inline" id="searchForm" name="searchObject">
						<div class="form-group">
							<input class="form-control" type="text" id="fromDate"
								   placeholder="Từ ngày">
						</div>

						<div class="form-group">
							<input class="form-control" type="text" id="toDate"
								   placeholder="Đến ngày">
						</div>
						&nbsp;&nbsp; &nbsp;&nbsp;
						<button type="button" class="btn btn-primary" id="btnDuyetDonHang">Duyệt
							Đơn</button>
					</form>
					<div id="thongtin">

					</div>

				</div>

				<div class="tab-pane" id="ketqua">
					<table class="table table-hover ketquaTable">
						<thead>
						<tr>
							<th>Hình ảnh</th>
							<th>Tên SP</th>
							<th>Danh Mục</th>
							<th>Hãng sản xuất</th>
							<th>Đơn giá</th>
							<th>Số lượng</th>
						</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="template/footer.jsp"></jsp:include>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script type="text/javascript">
		$(function() {
			var from = $("#fromDate").datepicker({
				dateFormat : "dd-mm-yy",
				changeMonth : true
			}).on("change", function() {
				to.datepicker("option", "minDate", getDate(this));
			});
			to = $("#toDate").datepicker({
				dateFormat : "dd-mm-yy",
				changeMonth : true
			}).on("change", function() {
				from.datepicker("option", "maxDate", getDate(this));
			});

			function getDate(element) {
				var date;
				var dateFormat = "dd-mm-yy";
				try {
					date = $.datepicker.parseDate(dateFormat, element.value);
				} catch (error) {
					date = null;
				}
				return date;
			}
		});
	</script>
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js"></script>
	<script src="<c:url value='/js/thongKeAdmin.js'/>" ></script>
</body>
</html>