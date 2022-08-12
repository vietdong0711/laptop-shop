<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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


<div class="col-md-9 animated bounce">
	<h3 class="page-header">Danh sách công việc</h3>
	<c:if test = "${listCongViec.soDonHangMoi > 0}">
         <p>Bạn có: <a href='<c:url value="/admin/don-hang" />'> ${listCongViec.soDonHangMoi} đơn hàng mới</a><p>
    </c:if>
    
    <c:if test = "${listCongViec.soDonhangChoDuyet > 0}">
         <p>Bạn có: <a href='<c:url value="/admin/don-hang" />'> ${listCongViec.soDonhangChoDuyet} đơn hàng chờ duyệt</a><p>
    </c:if>

	<c:if test = "${listCongViec.soLienHeMoi > 0}">
         <p>Bạn có: <a href='<c:url value="/admin/lien-he" />'> ${listCongViec.soLienHeMoi} liên hệ mới</a><p>
    </c:if>

    <br>
        <br>
        <br>
        <br><br>


    <div class="tab-pane active" id="information">
        <canvas id="myChart" width="600px" height="400px"></canvas>
        <h4 style="text-align: center; padding-right: 10%">Biểu đồ tổng giá trị đơn hàng hoàn thành theo tháng</h4>
    </div>
    
</div>
</div>

<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.1.3/Chart.min.js"></script>
<script src="<c:url value='/js/thongKeAdmin.js'/>" ></script>