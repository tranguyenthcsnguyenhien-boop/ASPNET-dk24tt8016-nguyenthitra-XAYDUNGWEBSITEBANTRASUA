using System.Collections.Generic;
using System.Data;
using WebBanTraSua.DTO;

namespace WebBanTraSua.DAL
{
    public class LoaiSPDAL
    {
        KetNoiDB db = new KetNoiDB();

        public List<LoaiSPDTO> LayDanhSachLoai()
        {
            List<LoaiSPDTO> list = new List<LoaiSPDTO>();
            string sql = "SELECT * FROM tblLoaiSP ORDER BY ThuTu ASC";
            DataTable dt = db.LayDuLieu(sql);
            foreach (DataRow row in dt.Rows)
            {
                list.Add(new LoaiSPDTO
                {
                    ID = int.Parse(row["ID"].ToString()),
                    TenLoai = row["TenLoai"].ToString(),
                    ThuTu = row["ThuTu"] != System.DBNull.Value ? int.Parse(row["ThuTu"].ToString()) : 0
                });
            }
            return list;
        }
    }
}