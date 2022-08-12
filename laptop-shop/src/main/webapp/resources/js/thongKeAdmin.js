$(document).ready(function() {
    $('#tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })

    ajaxGet();

    function ajaxGet(){
        // prepare data
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/laptopshop/api/san-pham/san-pham-sap-het",
            success: function(result){
                console.log(result);
                $.each(result, function(i, sanPham){
                    var sanPhamRow = '<tr>' +
                        '<td>' + '<img src="/laptopshop/img/'+sanPham.id+'.png" class="img-responsive" style="height: 50px; width: 50px" />'+'</td>' +
                        '<td>' + sanPham.tenSanPham + '</td>' +
                        '<td>' + sanPham.danhMuc.tenDanhMuc + '</td>' +
                        '<td>' + sanPham.hangSanXuat.tenHangSanXuat + '</td>' +
                        '<td>' + sanPham.donGia + '</td>' +
                        '<td>' + sanPham.donViKho + '</td>' +
                        '<td width="0%">'+'<input type="hidden" id="sanPhamId" value=' + sanPham.id + '>'+ '</td>';

                    $('.ketquaTable tbody').append(sanPhamRow);
                });;
            },
            error : function(e){
                alert("Error: ",e);
                console.log("Error" , e );
            }
        });
    };
    $(document).on('click', '#btnDuyetDonHang', function (event) {
        event.preventDefault();
        ajaxGetDS();
    });


    function ajaxGetDS(){
        // prepare data
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/laptopshop/api/don-hang/thong-ke-ngay?from="+$('#fromDate').val()+"&to="+$('#toDate').val(),
            success: function(result){
                console.log(result);
                var tong=0;
                for (let i = 0; i < result.length; i++) {
                    tong = tong + result[i].tongGiaTri;
                }
                var rs= `
                <p>Có ${result.length} đơn hàng.</p>
                <p>Tổng doanh thu ${tong} đồng.</p>`;

                $('#thongtin').append(rs);
            },
            error : function(e){
                alert("Error: ",e);
                console.log("Error" , e );
            }
        });
    };

})