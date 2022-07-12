class Constants {
  static const CMTND = "Chứng minh thư";
  static const CCCD = "Căn cước công dân";
  static const BLX = "Bằng lái xe";
  static const HO_CHIEU = "Hộ chiếu";
  static const GIAY_KHAI_SINH = "Giấy khai sinh";
  static const GIAY_LAI_XE = "Giấy lái xe";
  static const DANG_KY_XE = "Đăng ký xe";
  static const BIEN_SO_XE = "Biển số xe";
  static const KHAC = "Khác";
  final Map<String, List<String>> listData = {
    CMTND: [HO_VA_TEN, NGAY_SINH, SO_CMT,NOI_DANG_KY],
    CCCD: [HO_VA_TEN, NGAY_SINH, SO_CCCD,NOI_DANG_KY],
    BLX: [HO_VA_TEN, NGAY_SINH,NOI_DANG_KY],
    HO_CHIEU: [HO_VA_TEN, NGAY_SINH,NOI_DANG_KY],
    GIAY_KHAI_SINH: [HO_VA_TEN, NGAY_SINH,DIA_CHI,NOI_DANG_KY],
    GIAY_LAI_XE: [HO_VA_TEN, NGAY_SINH, SO_CMT,],
    DANG_KY_XE: [HO_VA_TEN, NGAY_SINH, SO_CMT],
    BIEN_SO_XE: [HO_VA_TEN, NGAY_SINH, SO_CMT],
    KHAC: []
  };
  static const HO_VA_TEN = "Họ và tên";
  static const NGAY_SINH = "Ngay sinh";
  static const SO_CMT = "Số CMT";
  static const SO_CCCD = "Số căn cước công dân";
  static const DIA_CHI = "Địa chỉ";
  static const NOI_DANG_KY = "Nơi đăng ký";
}
