package kr.or.batirplan.warehouse.vo;

public class WarehouseProductVO {
    private String wrhousCode;   // 창고 코드
    private int prdlstNo;        // 자재 번호
    private String prdlstNm;     // ✅ 자재명 추가
    private String prdlstStndrd; // ✅ 자재 규격 추가
    private String prdlstUnit;   // ✅ 자재 단위 추가
    private int invntryQy;       // 현재 재고 수량
    private String newestUpdtDe; // 최신 업데이트 날짜

    // ✅ 기본 생성자
    public WarehouseProductVO() {}

    // ✅ Getter & Setter 추가
    public String getWrhousCode() { return wrhousCode; }
    public void setWrhousCode(String wrhousCode) { this.wrhousCode = wrhousCode; }

    public int getPrdlstNo() { return prdlstNo; }
    public void setPrdlstNo(int prdlstNo) { this.prdlstNo = prdlstNo; }

    public String getPrdlstNm() { return prdlstNm; }
    public void setPrdlstNm(String prdlstNm) { this.prdlstNm = prdlstNm; }

    public String getPrdlstStndrd() { return prdlstStndrd; }
    public void setPrdlstStndrd(String prdlstStndrd) { this.prdlstStndrd = prdlstStndrd; }

    public String getPrdlstUnit() { return prdlstUnit; }
    public void setPrdlstUnit(String prdlstUnit) { this.prdlstUnit = prdlstUnit; }

    public int getInvntryQy() { return invntryQy; }
    public void setInvntryQy(int invntryQy) { this.invntryQy = invntryQy; }

    public String getNewestUpdtDe() { return newestUpdtDe; }
    public void setNewestUpdtDe(String newestUpdtDe) { this.newestUpdtDe = newestUpdtDe; }
}
