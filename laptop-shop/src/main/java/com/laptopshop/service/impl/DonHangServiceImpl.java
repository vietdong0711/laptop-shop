package com.laptopshop.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.laptopshop.repository.ChiTietDonHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.laptopshop.dto.SearchDonHangObject;
import com.laptopshop.entities.DonHang;
import com.laptopshop.entities.NguoiDung;
import com.laptopshop.entities.QDonHang;
import com.laptopshop.repository.DonHangRepository;
import com.laptopshop.service.DonHangService;
import com.querydsl.core.BooleanBuilder;

@Service
public class DonHangServiceImpl implements DonHangService {

	@Autowired
	private DonHangRepository donHangRepo;

	@Autowired
	private ChiTietDonHangRepository chiTietDonHangRepo;

	@Override
	public Page<DonHang> getAllDonHangByFilter(SearchDonHangObject object, int page) throws ParseException {
		BooleanBuilder builder = new BooleanBuilder();

		String trangThaiDon = object.getTrangThaiDon();
		String tuNgay = object.getTuNgay();
		String denNgay = object.getDenNgay();
		SimpleDateFormat formatDate = new SimpleDateFormat("dd-MM-yyyy");

		if (!trangThaiDon.equals("")) {
			builder.and(QDonHang.donHang.trangThaiDonHang.eq(trangThaiDon));
		}

		if (!tuNgay.equals("") && tuNgay != null) {
			if (trangThaiDon.equals("") || trangThaiDon.equals("Đang chờ giao") || trangThaiDon.equals("Đã hủy")) {
				builder.and(QDonHang.donHang.ngayDatHang.goe(formatDate.parse(tuNgay)));
			} else if (trangThaiDon.equals("Đang giao")) {
				builder.and(QDonHang.donHang.ngayGiaoHang.goe(formatDate.parse(tuNgay)));
			} else { // hoàn thành
				builder.and(QDonHang.donHang.ngayNhanHang.goe(formatDate.parse(tuNgay)));
			}
		}

		if (!denNgay.equals("") && denNgay != null) {
			if (trangThaiDon.equals("") || trangThaiDon.equals("Đang chờ giao") || trangThaiDon.equals("Đã hủy")) {
				builder.and(QDonHang.donHang.ngayDatHang.loe(formatDate.parse(denNgay)));
			} else if (trangThaiDon.equals("Đang giao")) {
				builder.and(QDonHang.donHang.ngayGiaoHang.loe(formatDate.parse(denNgay)));
			} else { // hoàn thành
				builder.and(QDonHang.donHang.ngayNhanHang.loe(formatDate.parse(denNgay)));
			}
		}


		return donHangRepo.findAll(builder, PageRequest.of(page - 1, 6, Sort.by("id").descending()));
	}

	@Override
	public DonHang update(DonHang dh) {
		return donHangRepo.save(dh);
	}

	@Override
	public DonHang findById(long id) {
		return donHangRepo.findById(id).get();
	}

	@Override
	public List<DonHang> findByTrangThaiDonHangAndShipper(String trangThai, NguoiDung shipper) {
		return donHangRepo.findByTrangThaiDonHangAndShipper(trangThai, shipper);
	}

	@Override
	public DonHang save(DonHang dh) {
		return donHangRepo.save(dh);
	}

	@Override
	public List<Object> layDonHangTheoThangVaNam() {
		return donHangRepo.layDonHangTheoThangVaNam();
	}
	
	@Override
	public List<DonHang> getDonHangByNguoiDung(NguoiDung ng) {
		List<DonHang> ls =  donHangRepo.findByNguoiDat(ng);
		for (DonHang dh: ls) {
			if (dh.getDanhSachChiTiet().size()==0){
				donHangRepo.deleteById(dh.getId());
			}
		}
		return  ls;
	}

	@Override
	public Page<DonHang> findDonHangByShipper(SearchDonHangObject object, int page, int size, NguoiDung shipper) throws ParseException {
		BooleanBuilder builder = new BooleanBuilder();

		String trangThaiDon = object.getTrangThaiDon();
		String tuNgay = object.getTuNgay();
		String denNgay = object.getDenNgay();
		SimpleDateFormat formatDate = new SimpleDateFormat("dd-MM-yyyy");
		
		builder.and(QDonHang.donHang.shipper.eq(shipper));

		if (!trangThaiDon.equals("")) {
			builder.and(QDonHang.donHang.trangThaiDonHang.eq(trangThaiDon));
		}

		if (!tuNgay.equals("") && tuNgay != null) {
			if (trangThaiDon.equals("Đang giao")) {
				builder.and(QDonHang.donHang.ngayGiaoHang.goe(formatDate.parse(tuNgay)));
			} else { // hoàn thành
				builder.and(QDonHang.donHang.ngayNhanHang.goe(formatDate.parse(tuNgay)));
			}
		}

		if (!denNgay.equals("") && denNgay != null) {
			if (trangThaiDon.equals("Đang giao")) {
				builder.and(QDonHang.donHang.ngayGiaoHang.loe(formatDate.parse(denNgay)));
			} else { // hoàn thành
				builder.and(QDonHang.donHang.ngayNhanHang.loe(formatDate.parse(denNgay)));
			}
		}

		return donHangRepo.findAll(builder, PageRequest.of(page - 1, size));
	}

	@Override
	public int countByTrangThaiDonHang(String trangThaiDonHang) {
		return donHangRepo.countByTrangThaiDonHang(trangThaiDonHang);
	}

	@Override
	public List<DonHang> dsDonHangTheoThoiGian(String from, String to) throws ParseException {
		List<DonHang> ls = donHangRepo.findAll();
		List<DonHang> rs = new ArrayList<>();
		Date fromDate =  new SimpleDateFormat("dd-MM-yyyy").parse(from);
		Date toDate =  new SimpleDateFormat("dd-MM-yyyy").parse(to);
		System.out.println("from"+fromDate);
		for (DonHang dh:ls) {
			if (dh.getTrangThaiDonHang().trim().equals("Hoàn thành") && dh.getNgayNhanHang().compareTo(fromDate)>0 && dh.getNgayNhanHang().compareTo(toDate)<0){
				rs.add(dh);
			}
		}
		return rs;
	}


}
